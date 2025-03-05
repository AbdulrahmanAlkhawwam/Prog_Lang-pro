import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:program_language_project/src/core/localization/keys.g.dart';

import '../../constants/res.dart';
import '../../constants/styles.dart';
import '../../utils/app_context.dart';

class EmptyFavoritesScreen extends StatelessWidget {
  const EmptyFavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset(Res.emptyFavourite),
            Padding(
              padding: const EdgeInsets.all(appBor),
              child: Text(LocaleKeys.empty_favorite.tr(),
                style: context.textTheme.labelMedium,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
