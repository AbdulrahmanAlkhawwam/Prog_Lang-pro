import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../constants/res.dart';
import '../../constants/styles.dart';
import '../../utils/app_context.dart';

class EmptyOrdersScreen extends StatelessWidget {
  const EmptyOrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset(Res.emptyOrders),
            Padding(
              padding: const EdgeInsets.all(appBor),
              child: Text(
                "There are no Orders",
                style: context.textTheme.labelMedium,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
