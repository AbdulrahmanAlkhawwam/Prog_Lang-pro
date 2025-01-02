import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../constants/res.dart';
import '../../constants/styles.dart';
import '../../utils/app_context.dart';
import '../../utils/message.dart';

class ErrorScreen extends StatelessWidget {
  final Message errorMessage;

  const ErrorScreen({
    super.key,
    required this.errorMessage,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset(Res.error),
            Padding(
              padding: const EdgeInsets.all(appBor),
              child: Text(
                errorMessage.toString(),
                style: context.textTheme.labelMedium,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
