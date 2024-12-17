import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:program_language_project/src/core/utils/app_context.dart';
import 'package:pinput/pinput.dart';
import 'package:program_language_project/src/features/mangers/auth/bloc/auth_bloc.dart';

class OtpScreen extends StatelessWidget {
  OtpScreen({super.key});

  final timer = Timer(
    Duration(minutes: 5),
    () {},
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(28),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Spacer(),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 2),
              child: Text(
                "Verification code",
                style: TextStyle(
                  color: context.colors.onSurface,
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 28),
              child: Text(
                "we send code for this number ... if you don’t have any account , please resend again to get the code ",
                style: TextStyle(
                  color: context.colors.onSurface,
                  fontSize: 12,
                ),
              ),
            ),
            Pinput(
              length: 6,
              onCompleted: (pin) =>
                  context.read<AuthBloc>().add(OTP(passkey: pin)),
            ),
            Spacer(),
            Text(timer.toString()),
            TextButton(
              onPressed: () => context.pop(),
              child: Text("Change phone number"),
            ),
          ],
        ),
      ),
    );
  }
}
