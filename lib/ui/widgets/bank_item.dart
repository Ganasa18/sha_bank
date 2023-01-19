import 'package:flutter/material.dart';
import 'package:sha_bank/models/payment_method_model.dart';
import 'package:sha_bank/shared/theme.dart';

class BankItem extends StatelessWidget {
  const BankItem({
    super.key,
    // required this.imgUrl,
    // required this.title,
    required this.paymentMethods,
    this.isSelected = false,
  });
  // final String imgUrl;
  // final String title;
  final PaymentMethodModel paymentMethods;
  final bool isSelected;

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
          // Image.asset(
          //   imgUrl,
          //   height: 30,
          // ),
          paymentMethods.thumbnail == ''
              ? const Spacer()
              : Image.network(
                  paymentMethods.thumbnail.toString(),
                  height: 30,
                ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                paymentMethods.name.toString(),
                style: blackTextStyle.copyWith(
                  fontSize: 16,
                  fontWeight: medium,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                '50 mins',
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
