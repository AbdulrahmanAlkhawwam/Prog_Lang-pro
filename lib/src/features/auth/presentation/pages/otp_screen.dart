import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:program_language_project/src/core/localization/keys.g.dart';

import '../../../../core/constants/styles.dart';
import '../../../../core/utils/app_context.dart';
import '../manger/bloc/auth_bloc.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({super.key});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  int _seconds = 300;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() => _timer = Timer.periodic(
        Duration(seconds: 1),
        (timer) => setState(() => _seconds > 0 ? _seconds-- : _timer?.cancel()),
      );

  String _formatTime(int seconds) {
    int minutes = seconds ~/ 60;
    int remainingSeconds = seconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}';
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 32),
        child: Column(
          children: [
            Spacer(flex: 1),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  LocaleKeys.auth_otp_title.tr(),
                  style: context.textTheme.titleMedium,
                ),
              ],
            ),
            const SizedBox(height: 4),
            Text(
              LocaleKeys.auth_otp_description.tr(),
              style: TextStyle(fontSize: 12),
            ),
            const SizedBox(height: 28),
            Pinput(
              autofocus: true,
              enabled: _seconds > 0,
              keyboardType: TextInputType.number,
              closeKeyboardWhenCompleted: true,
              defaultPinTheme: PinTheme(
                margin: EdgeInsets.symmetric(horizontal: 4),
                width: 56,
                height: 64,
                textStyle: context.textTheme.titleSmall,
                decoration: BoxDecoration(
                  color: context.colors.surfaceContainer,
                  borderRadius: BorderRadius.circular(appBor),
                ),
              ),
              focusedPinTheme: PinTheme(
                margin: EdgeInsets.symmetric(horizontal: 4),
                width: 56,
                height: 64,
                textStyle: context.textTheme.titleSmall,
                decoration: BoxDecoration(
                  color: context.colors.primaryContainer.withOpacity(0.25),
                  borderRadius: BorderRadius.circular(appBor),
                ),
              ),
              disabledPinTheme: PinTheme(
                margin: EdgeInsets.symmetric(horizontal: 4),
                width: 56,
                height: 64,
                textStyle: context.textTheme.titleSmall,
                decoration: BoxDecoration(
                  color: context.colors.outline.withOpacity(0.25),
                  borderRadius: BorderRadius.circular(appBor),
                ),
              ),
              length: 6,
              onCompleted: (pin) =>
                  context.read<AuthBloc>().add(OTP(passkey: pin)),
            ),
            Spacer(flex: 2),
            Text(
              _formatTime(_seconds),
              style: context.textTheme.titleSmall?.copyWith(
                color: context.colors.secondary,
              ),
            ),
            TextButton(
              onPressed: () => context.pop(),
              child: Text(
                "Change phone number",
                style: context.textTheme.labelMedium
                    ?.copyWith(color: context.colors.surface),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
