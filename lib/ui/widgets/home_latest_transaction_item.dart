import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sha_bank/models/transaction_model.dart';
import 'package:sha_bank/shared/shared_method.dart';
import 'package:sha_bank/shared/theme.dart';

class HomeLatestTransactionItem extends StatelessWidget {
  TransactionModel transaction;

  HomeLatestTransactionItem({
    super.key,
    required this.transaction,
    // required this.iconUrl,
    // required this.title,
    // required this.time,
    // required this.value,
  });

  // final String iconUrl;
  // final String title;
  // final String time;
  // final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 18),
      child: Row(
        children: [
          transaction.transactionType!.thumbnail != ''
              ? Image.network(
                  transaction.transactionType!.thumbnail!,
                  width: 48,
                )
              : Container(),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  transaction.transactionType!.name.toString(),
                  style: blackTextStyle.copyWith(
                    fontSize: 16,
                    fontWeight: medium,
                  ),
                ),
                Text(
                  DateFormat('MMM dd')
                      .format(transaction.createdAt ?? DateTime.now()),
                  style: greyTextStyle.copyWith(
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          Text(
            formatCurrency(
              transaction.amount ?? 0,
              symbol: transaction.transactionType!.action == 'cr' ? '+ ' : '- ',
            ),
            style: blackTextStyle.copyWith(fontSize: 16, fontWeight: medium),
          ),
        ],
      ),
    );
  }
}
