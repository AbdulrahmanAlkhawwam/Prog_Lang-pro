import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import './skeleton.dart';
import '../constants/styles.dart';
import '../utils/app_context.dart';

class AppButton extends StatelessWidget {
  final Function()? onPressed;
  final Color? background;
  final Color? splash;
  final Color? textColor;

  final bool isLoading;
  final Widget? child;
  final String text;

  const AppButton({
    super.key,
    required this.isLoading,
    required this.text,
    this.background,
    this.textColor,
    this.onPressed,
    this.splash,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          height: 56,
          width: 300,
          decoration: BoxDecoration(
            color: onPressed == null
                ? context.colors.outline
                : background ?? context.colors.primaryContainer,
            borderRadius: BorderRadius.circular(curvedBor),
          ),
          child: Material(
            type: MaterialType.button,
            color: Colors.transparent,
            shape: const StadiumBorder(),
            clipBehavior: Clip.hardEdge,
            child: InkWell(
              splashColor: onPressed == null
                  ? context.colors.outline
                  : splash ?? context.colors.primary,
              onTap: !isLoading ? onPressed : null,
              child: Container(
                alignment: Alignment.center,
                child: child ??
                    Text(
                      text,
                      textAlign: TextAlign.center,
                      style: context.textTheme.titleSmall?.copyWith(
                        color: onPressed == null
                            ? context.colors.surface
                            : textColor ?? context.colors.onPrimaryContainer,
                      ),
                    ),
              ),
            ),
          ),
        ),
        if (isLoading && onPressed != null)
          Shimmer.fromColors(
            baseColor: context.colors.primaryContainer.withOpacity(0.75),
            highlightColor: context.colors.surface.withOpacity(0.25),
            enabled: true,
            child: const Skeleton(
              borderRadius: curvedBor,
              height: 56,
              width: 300,
            ),
          )
      ],
    );
  }
}
