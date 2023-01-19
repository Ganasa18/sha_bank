import 'package:flutter/material.dart';
import 'package:sha_bank/models/operator_card_model.dart';

import '../../shared/theme.dart';

class DataProviderItem extends StatelessWidget {
  final OperatorCardModel operatorCard;
  final bool isSelected;

  const DataProviderItem({
    super.key,
    required this.operatorCard,
    // required this.imgUrl,
    // required this.title,
    this.isSelected = false,
  });

  // final String imgUrl;
  // final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 18),
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: whiteColor,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          width: 2,
          color: isSelected ? blueColor : whiteColor,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Image.network(
            operatorCard.thumbnail.toString(),
            height: 30,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                operatorCard.name.toString(),
                style: blackTextStyle.copyWith(
                  fontSize: 16,
                  fontWeight: medium,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                operatorCard.status.toString(),
                style: greyTextStyle.copyWith(
                  fontSize: 12,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
