import 'package:flutter/material.dart';
import 'package:sha_bank/shared/theme.dart';
import 'package:sha_bank/ui/widgets/buttons.dart';

class SignUpSuccessPage extends StatelessWidget {
  const SignUpSuccessPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Akun Berhasil\nTerdaftar',
              style: blackTextStyle.copyWith(
                fontSize: 20,
                fontWeight: semiBold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 26),
            Text(
              'Grow your finance start\ntogether with us',
              style: greyTextStyle.copyWith(
                fontSize: 16,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 50),
            CustomFilledButton(
              width: 183,
              title: 'Get Started',
              onPressed: () {
                // remove navigation sebelumnya
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  '/home-page',
                  (route) => false,
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
