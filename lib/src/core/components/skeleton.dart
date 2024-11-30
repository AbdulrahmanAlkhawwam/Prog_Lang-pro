import 'package:flutter/material.dart';

import '../utils/app_context.dart';

class Skeleton extends StatelessWidget {
  final double width;
  final double height;
  final int lines;
  final double spacing;
  final double? padHorizontal;
  final double? widthFactor;
  final double borderRadius;

  const Skeleton({
    super.key,
    this.width = double.infinity,
    this.height = 20,
    this.lines = 1,
    this.spacing = 16,
    this.padHorizontal,
    this.widthFactor,
    double? borderRadius,
  }) : borderRadius = borderRadius ?? (height / 2);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (int i = 0; i < lines - 1; i++)
          Container(
            width: double.infinity,
            height: height,
            margin: EdgeInsets.symmetric(
              vertical: spacing / 2,
              horizontal: padHorizontal ?? 0,
            ),
            decoration: BoxDecoration(
              color: context.colors.outline,
              borderRadius: BorderRadius.circular(borderRadius),
            ),
          ),
        FractionallySizedBox(
          widthFactor: widthFactor,
          alignment: AlignmentDirectional.centerStart,
          child: Container(
            width: width,
            height: height,
            margin: EdgeInsets.symmetric(
              vertical: spacing / 2,
              horizontal: padHorizontal ?? 0,
            ),
            decoration: BoxDecoration(
              color: context.colors.outline,
              borderRadius: BorderRadius.circular(borderRadius),
            ),
          ),
        ),
      ],
    );
  }
}
