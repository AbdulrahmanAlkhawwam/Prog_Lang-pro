import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../constants/res.dart';
import '../../constants/styles.dart';
import '../../utils/app_context.dart';

class EmptyShopsScreen extends StatelessWidget {
  const EmptyShopsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset(Res.emptyShops),
            Padding(
              padding: const EdgeInsets.all(appBor),
              child: Text(
                "There are no Shops",
                style: context.textTheme.labelMedium,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
