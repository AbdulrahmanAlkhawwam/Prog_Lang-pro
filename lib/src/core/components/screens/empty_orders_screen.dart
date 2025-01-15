import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../constants/res.dart';
import '../../constants/styles.dart';
import '../../localization/keys.g.dart';
import '../../utils/app_context.dart';

class EmptyOrdersScreen extends StatelessWidget {
  final Future<void> Function() onRefresh;

  const EmptyOrdersScreen({super.key, required this.onRefresh});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: onRefresh,
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SvgPicture.asset(Res.emptyOrders),
              Padding(
                padding: const EdgeInsets.all(appBor),
                child: Text(
                  LocaleKeys.empty_order.tr(),
                  style: context.textTheme.labelMedium,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
