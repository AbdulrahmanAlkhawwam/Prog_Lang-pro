import 'package:flutter/material.dart';

import '../../domain/entities/category.dart';
import 'category_item.dart';

class CategoriesList extends StatelessWidget {
  final List<Category> categories;
  final int? select;
  final Function(dynamic) onTap;

  const CategoriesList({
    super.key,
    required this.categories,
    required this.select,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 32,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) => CategoryItem(
          isSelect: categories[index].id == select,
          onTap: () => onTap(categories[index].id),
          category: categories[index],
        ),
        separatorBuilder: (context, index) => const SizedBox(width: 8),
        itemCount: categories.length,
      ),
    );
  }
}
