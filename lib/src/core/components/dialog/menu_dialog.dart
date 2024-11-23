import 'package:flutter/material.dart';

import '../../constants/styles.dart';
import '../../utils/app_context.dart';

class MenuDialog extends StatelessWidget {
  final Function(dynamic) onTap;
  final List<dynamic> menu;
  final String text;

  const MenuDialog({
    super.key,
    required this.onTap,
    required this.menu,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: context.colors.primaryContainer,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(semicircle)),
      alignment: Alignment.center,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                text,
                textAlign: TextAlign.center,
                style: context.textTheme.titleLarge,
              ),
              const SizedBox(height: 16),
              for (var item in menu)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: ListTile(
                    title: Text(item),
                    onTap: () {
                      onTap(item);
                      context.pop();
                    },
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    splashColor: context.colors.primary,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
