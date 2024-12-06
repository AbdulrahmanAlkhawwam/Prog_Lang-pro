import 'package:flutter/material.dart';

import '../constants/styles.dart';

extension AppNavigation on BuildContext {
  Future push(Route route) => Navigator.push(this, route);

  Future pushReplacement(Route route) =>
      Navigator.pushAndRemoveUntil(this, route, (route) => false);

  void pop([value]) => Navigator.pop(this, value);
}

extension AppTheme on BuildContext {
  ColorScheme get colors => Theme.of(this).colorScheme;

  bool get isDark => Theme.of(this).brightness == Brightness.dark;

  TextTheme get textTheme => Theme.of(this).textTheme;
}

extension AppResponsive on BuildContext {
  double get height => MediaQuery.sizeOf(this).height;

  double get width => MediaQuery.sizeOf(this).width;

  double get bottomPadding => MediaQuery.paddingOf(this).bottom;

  double get bottomInsets => MediaQuery.viewInsetsOf(this).bottom;
}

extension AppDirectionality on BuildContext {
  TextDirection get textDirection => Directionality.of(this);
}

extension AppSnackbar on BuildContext {
  void showSuccessSnackBar({String? massage}) {
    ScaffoldMessenger.of(this).clearSnackBars();
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        backgroundColor: colors.primaryContainer,
        shape: OutlineInputBorder(
          borderRadius: BorderRadius.circular(appBor),
          borderSide: BorderSide(color: Colors.transparent, width: inputBor),
        ),
        duration: const Duration(milliseconds: 1500),
        content: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.check_circle_outline,
              weight: 32,
              color: colors.onPrimaryContainer,
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                textAlign: TextAlign.start,
                massage ?? "Success",
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: textTheme.bodyMedium?.copyWith(
                  color: colors.onPrimaryContainer,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void showErrorSnackBar({String? massage}) {
    ScaffoldMessenger.of(this).clearSnackBars();
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        backgroundColor: colors.errorContainer,
        shape: OutlineInputBorder(
          borderRadius: BorderRadius.circular(appBor),
          borderSide: BorderSide(color: Colors.transparent, width: inputBor),
        ),
        duration: const Duration(milliseconds: 1500),
        content: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline,
              weight: 32,
              color: colors.onErrorContainer,
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                textAlign: TextAlign.start,
                massage ?? "Error",
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: textTheme.bodyMedium?.copyWith(
                  color: colors.onErrorContainer,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
