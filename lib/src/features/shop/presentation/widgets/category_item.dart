import 'package:flutter/material.dart';

import '../../../../core/constants/styles.dart';
import '../../../../core/utils/app_context.dart';
import '../../../shop/domain/entities/category.dart';

class CategoryItem extends StatelessWidget {
  final Category category;
  final bool? isSelect;

  final Function() onTap;

  const CategoryItem({
    super.key,
    required this.category,
    required this.isSelect,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(curvedBor),
      child: Container(
        height: 32,
        padding: EdgeInsets.symmetric(vertical: 4, horizontal: 12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(curvedBor),
          color: isSelect ?? false
              ? context.colors.primaryContainer
              : context.colors.surfaceContainer,
        ),
        child: Text(
          category.name,
          style: context.textTheme.labelSmall,
        ),
      ),
    );
  }
}
