import 'package:flutter/material.dart';
import 'package:sha_bank/models/user_model.dart';
import 'package:sha_bank/shared/theme.dart';

class HomeUserItem extends StatelessWidget {
  final UserModel user;
  const HomeUserItem({
    super.key,
    required this.user,
  });
  // final String imageUrl;
  // final String username;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      width: 90,
      margin: const EdgeInsets.only(right: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: whiteColor,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 45,
            width: 45,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                fit: BoxFit.cover,
                image: user.profilePicture == null
                    ? const AssetImage('assets/img_profile.png')
                    : NetworkImage(user.profilePicture!) as ImageProvider,
              ),
            ),
          ),
          const SizedBox(height: 14),
          Text(
            '@${user.name}',
            style: blackTextStyle.copyWith(
              fontWeight: medium,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}
