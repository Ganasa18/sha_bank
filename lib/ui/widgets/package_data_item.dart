import 'package:flutter/material.dart';
import 'package:sha_bank/models/data_plan_model.dart';
import 'package:sha_bank/shared/shared_method.dart';

import '../../shared/theme.dart';

class PackageDataItem extends StatelessWidget {
  final DataPlanModel dataPlan;
  const PackageDataItem({
    super.key,
    required this.dataPlan,
    this.isSelected = false,
  });

  // final int amount;
  // final int price;
  final bool isSelected;
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
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 13),
          Text(
            dataPlan.name.toString(),
            style: blackTextStyle.copyWith(fontSize: 32, fontWeight: medium),
          ),
          const SizedBox(height: 2),
          Text(
            formatCurrency(dataPlan.price ?? 0),
            style: greyTextStyle.copyWith(fontSize: 12),
          ),
        ],
      ),
    );
  }
}
