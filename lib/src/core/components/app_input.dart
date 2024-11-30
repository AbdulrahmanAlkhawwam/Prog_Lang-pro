import 'package:flutter/material.dart';

import '../utils/app_context.dart';

class AppInput extends StatelessWidget {
  final Function()? onTap;
  final Function(dynamic)? onChanged;
  final FormFieldValidator<dynamic>? validator;
  final String? validate;
  final TextEditingController? controller;
  final IconButton? suffixIconButton;
  final Icon? suffixIcon;
  final IconButton? prefixIconButton;
  final Icon? prefixIcon;
  final TextInputType? keyboardType;
  final TextStyle? hintStyle;
  final String? hint;
  final String? helperText;
  final bool isEnabled;

  const AppInput({
    super.key,
    required this.isEnabled,
    this.controller,
    this.hint,
    this.hintStyle,
    this.suffixIconButton,
    this.suffixIcon,
    this.prefixIconButton,
    this.prefixIcon,
    this.onChanged,
    this.onTap,
    this.validate,
    this.validator,
    this.keyboardType,
    this.helperText,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      cursorHeight: 25,
      keyboardType: keyboardType ?? TextInputType.text,
      validator: isEnabled
          ? validator ??
              (value) => (value == null || value.isEmpty) ? validate : null
          : null,
      autocorrect: true,
      onTap: onTap,
      onChanged: onChanged,
      enabled: isEnabled,
      cursorColor: context.colors.onSurface,
      controller: controller,
      decoration: InputDecoration(
        helperText: helperText,
        helperStyle: context.textTheme.bodySmall?.copyWith(
          color: context.colors.secondary.withOpacity(0.5),
        ),
        hintText: hint,
        hintStyle: !isEnabled
            ? context.textTheme.bodyMedium
                ?.copyWith(color: context.colors.outline)
            : null,
        suffix: suffixIconButton ?? suffixIcon,
        prefix: prefixIconButton ?? prefixIcon,
        border: InputBorder.none,
        contentPadding: EdgeInsets.symmetric(
          vertical: 12,
          horizontal: 18,
        ),
      ),
    );
  }
}
