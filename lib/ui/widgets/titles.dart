import 'package:flutter/material.dart';
import '../../shared/theme.dart';

class CustomTitleWidget extends StatelessWidget {
  const CustomTitleWidget({
    super.key,
    required this.title,
  });
  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: blackTextStyle.copyWith(
        fontSize: 20,
        fontWeight: semiBold,
      ),
    );
  }
}
