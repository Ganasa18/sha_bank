import 'package:flutter/material.dart';
import 'package:sha_bank/models/user_model.dart';
import 'package:sha_bank/shared/theme.dart';

class TransferResultUserItem extends StatelessWidget {
  final UserModel user;
  final bool isSelected;

  const TransferResultUserItem({
    super.key,
    required this.user,
    // required this.imageUrl,
    // required this.name,
    // required this.username,
    // this.isVerified = false,
    this.isSelected = false,
  });

  // final String imageUrl;
  // final String name;
  // final String username;
  // final bool isVerified;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 175,
      width: 155,
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 22),
      decoration: BoxDecoration(
        color: whiteColor,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          width: 2,
          color: isSelected ? blueColor : whiteColor,
        ),
      ),
      child: Column(
        children: [
          Container(
            width: 70,
            height: 70,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                image: user.profilePicture == null
                    ? const AssetImage('assets/img_profile.png')
                    : NetworkImage(user.profilePicture!) as ImageProvider,
              ),
            ),
            child: user.verified == 1
                ? Align(
                    alignment: Alignment.topRight,
                    child: Container(
                      width: 16,
                      height: 16,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: whiteColor,
                      ),
                      child: Center(
                        child: Icon(
                          Icons.check_circle,
                          color: greenColor,
                          size: 14,
                        ),
                      ),
                    ),
                  )
                : null,
          ),
          const SizedBox(height: 13),
          Text(
            user.name.toString(),
            style: blackTextStyle.copyWith(fontSize: 16, fontWeight: medium),
          ),
          const SizedBox(height: 2),
          Text(
            '@${user.username}',
            style: greyTextStyle.copyWith(fontSize: 12),
          ),
        ],
      ),
    );
  }
}
