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

  TextTheme get textTheme => Theme.of(this).textTheme;
}

extension AppResponsive on BuildContext {
  double get height => MediaQuery.sizeOf(this).height;

  double get width => MediaQuery.sizeOf(this).width;

  String get deviceMode =>
      MediaQuery.orientationOf(this) == Orientation.landscape
          ? "landscape"
          : "portrait";

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
        backgroundColor: colors.primaryContainer.withOpacity(0.7),
        shape: OutlineInputBorder(
          borderRadius: BorderRadius.circular(circle),
          borderSide: BorderSide(color: colors.primary, width: 1),
        ),
        duration: const Duration(milliseconds: 1500),
        content: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // SvgPicture.asset(
            //   Res.success,
            //   width: 32,
            //   color: colors.primary,
            // ),
            // const SizedBox(width: 8),
            Expanded(
              child: Text(
                textAlign: TextAlign.center,
                massage ?? "Success",
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: textTheme.bodyMedium?.copyWith(
                  color: colors.primary,
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
        backgroundColor: colors.errorContainer.withOpacity(0.7),
        shape: OutlineInputBorder(
          borderRadius: BorderRadius.circular(circle),
          borderSide: BorderSide(color: colors.error, width: 1),
        ),
        duration: const Duration(milliseconds: 1500),
        content: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // SvgPicture.asset(
            //   Res.error,
            //   width: 32,
            //   color: colors.error,
            // ),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                textAlign: TextAlign.center,
                massage ?? "Error",
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: textTheme.bodyMedium?.copyWith(
                  color: colors.error,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
