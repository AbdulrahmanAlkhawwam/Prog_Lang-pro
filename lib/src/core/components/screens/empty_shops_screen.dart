import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../constants/res.dart';
import '../../constants/styles.dart';
import '../../utils/app_context.dart';

class EmptyScreen extends StatelessWidget {
  final bool isShopScreen;

  const EmptyScreen({super.key, required this.isShopScreen});

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
                isShopScreen ? "There are no Shops" : "There are no Product",
                style: context.textTheme.labelMedium,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
