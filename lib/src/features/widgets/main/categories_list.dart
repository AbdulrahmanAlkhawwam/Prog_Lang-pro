import 'package:flutter/material.dart';

import '../../models/category.dart';
import 'category_item.dart';

class CategoriesList extends StatelessWidget {
  final List<Category> categories;
  final int? select;

  const CategoriesList({
    super.key,
    required this.categories,
    required this.select,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 32,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) => CategoryItem(
          isSelect: index == select,
          onTap: () {},
          category: categories[index],
        ),
        separatorBuilder: (context, index) => const SizedBox(width: 8),
        itemCount: categories.length,
      ),
    );
  }
}
