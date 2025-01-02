import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../constants/styles.dart';
import '../../utils/app_context.dart';
import '../../localization/keys.g.dart';

class ThemeDialog extends StatelessWidget {
  const ThemeDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: context.colors.surface,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              LocaleKeys.dialog_theme_title.tr(),
              style: context.textTheme.titleSmall,
            ),
            Container(
              padding: EdgeInsets.all(16),
              margin: EdgeInsets.symmetric(vertical: 16),
              width: double.infinity,
              decoration: BoxDecoration(
                  color: context.colors.surfaceContainer,
                  borderRadius: BorderRadius.circular(appBor)),
              child: Column(
                children: [
                  ListTile(
                    onTap: () => context.pop("en"),
                    leading: Icon(
                      Icons.dark_mode_outlined,
                      color: context.colors.primaryContainer,
                    ),
                    title: Text(
                      LocaleKeys.dialog_theme_dark.tr(),
                      style: context.textTheme.labelMedium,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    child: Divider(color: context.colors.outline),
                  ),
                  ListTile(
                    onTap: () => context.pop("ar"),
                    leading: Icon(
                      Icons.light_mode_outlined,
                      color: context.colors.primaryContainer,
                    ),
                    title: Text(
                      LocaleKeys.dialog_theme_light.tr(),
                      style: context.textTheme.labelMedium,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    child: Divider(color: context.colors.outline),
                  ),
                  ListTile(
                    onTap: () => context.pop("ar"),
                    leading: Icon(
                      Icons.devices,
                      color: context.colors.primaryContainer,
                    ),
                    title: Text(
                      LocaleKeys.dialog_theme_system.tr(),
                      style: context.textTheme.labelMedium,
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
