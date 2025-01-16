import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../constants/styles.dart';
import '../../localization/keys.g.dart';
import '../../utils/app_context.dart';

class CancelledDialog extends StatelessWidget {
  const CancelledDialog({super.key});

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
              LocaleKeys.dialog_cancelled_title.tr(),
              style: context.textTheme.titleSmall,
            ),
            Container(
              padding: EdgeInsets.all(16),
              margin: EdgeInsets.symmetric(vertical: 16),
              width: double.infinity,
              decoration: BoxDecoration(
                  color: context.colors.errorContainer,
                  borderRadius: BorderRadius.circular(appBor)),
              child: Text(
                LocaleKeys.dialog_cancelled_content.tr(),
                style: context.textTheme.labelMedium?.copyWith(
                  color: context.colors.onErrorContainer,
                ),
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: TextButton(
                    onPressed: () => context.pop(false),
                    child: Text(LocaleKeys.dialog_cancelled_cancelled.tr()),
                  ),
                ),
                Expanded(
                  child: FilledButton(
                    child: Text(LocaleKeys.dialog_cancelled_edit.tr()),
                    onPressed: () => context.pop(true),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
