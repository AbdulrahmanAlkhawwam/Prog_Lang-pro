import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';
import 'package:program_language_project/src/app.dart';
import 'package:program_language_project/src/core/components/app_input.dart';
import 'package:program_language_project/src/core/utils/app_context.dart';
import 'package:pinput/pinput.dart';
import 'package:program_language_project/src/features/mangers/auth/bloc/auth_bloc.dart';

class OtpScreen extends StatelessWidget {
  OtpScreen({super.key});
  final VerificationCode = TextEditingController();
  final globalKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(28),
        child: Form(
          key: globalKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(child: SizedBox(height: 1)),
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
                onCompleted: (pin) {
                  context.read<AuthBloc>().add(OTP(passkey: pin));
                },
              ),
              Expanded(child: SizedBox(height: 1)),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextButton(
                    onPressed: () {},
                    child: Text("Resend"),
                  ),
                  TextButton(
                    onPressed: () => context.pop(),
                    child: Text("Change phone number"),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
