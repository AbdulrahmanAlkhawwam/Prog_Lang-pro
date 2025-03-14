import 'package:flutter/material.dart';

import '../../../../core/utils/app_context.dart';

class NewCartScreen extends StatelessWidget {
  const NewCartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                color: context.colors.surfaceContainer,
                border: Border.all(color: context.colors.surfaceBright),
              ),
            )
          ],
        ),
      ),
    );
  }
}
