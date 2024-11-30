import 'package:flutter/material.dart';

import '../utils/app_context.dart';
import '../constants/styles.dart';

class SearchInput extends StatelessWidget {
  final Function()? onTap;
  final Function(dynamic)? onChanged;
  final TextEditingController? controller;
  final String? hint;

  const SearchInput({
    super.key,
    required this.onTap,
    required this.onChanged,
    required this.controller,
    required this.hint,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56,
      margin: EdgeInsets.fromLTRB(24, 16, 24, 0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(curvedBor),
        boxShadow: [
          BoxShadow(color: context.colors.outline),
          BoxShadow(
            color: context.colors.surfaceContainer,
            spreadRadius: -4,
            blurRadius: 8,
          ),
        ],
      ),
      child: SearchBar(
        onTap: onTap,
        hintText: hint,
        onChanged: onChanged,
        controller: controller,
        elevation: WidgetStatePropertyAll(0),
        backgroundColor: WidgetStatePropertyAll(Colors.transparent),
        textStyle: WidgetStatePropertyAll(context.textTheme.bodySmall),
        hintStyle: WidgetStatePropertyAll(
          context.textTheme.bodySmall?.copyWith(color: context.colors.outline),
        ),
      ),
    );
  }
}
