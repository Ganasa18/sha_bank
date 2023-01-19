import 'package:flutter/material.dart';
import 'package:sha_bank/shared/theme.dart';

class HomeServiceItem extends StatelessWidget {
  const HomeServiceItem({
    super.key,
    required this.iconUrl,
    required this.title,
    this.onTap,
  });

  final String iconUrl;
  final String title;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            width: 70,
            height: 70,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: whiteColor,
            ),
            child: Center(
              child: Image.asset(
                iconUrl,
                width: 26,
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            title,
            style: blackTextStyle.copyWith(fontWeight: medium),
          ),
        ],
      ),
    );
  }
}
