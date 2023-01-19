import 'package:flutter/material.dart';
import '../../shared/theme.dart';
import '../widgets/buttons.dart';

class DataPackageSuccessPage extends StatelessWidget {
  const DataPackageSuccessPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Paket Data\nBerhasil Terbeli',
              style: blackTextStyle.copyWith(
                fontSize: 20,
                fontWeight: semiBold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 26),
            Text(
              'Use the money wisely and\ngrow your finance',
              style: greyTextStyle.copyWith(
                fontSize: 16,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 50),
            CustomFilledButton(
              width: 183,
              title: 'Back To Home',
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
