import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sha_bank/blocs/payment_method/payment_methods_bloc.dart';
import 'package:sha_bank/models/payment_method_model.dart';
import 'package:sha_bank/models/top_up_form_model.dart';
import 'package:sha_bank/shared/theme.dart';
import 'package:sha_bank/ui/pages/top_up_amount_page.dart';
import 'package:sha_bank/ui/widgets/bank_item.dart';
import 'package:sha_bank/ui/widgets/buttons.dart';

import '../../blocs/auth/auth_bloc.dart';

class TopUpPage extends StatefulWidget {
  const TopUpPage({super.key});

  @override
  State<TopUpPage> createState() => _TopUpPageState();
}

class _TopUpPageState extends State<TopUpPage> {
  PaymentMethodModel? selectedPaymentMethod;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Top Up'),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(
          horizontal: 24,
        ),
        children: [
          const SizedBox(height: 30),
          Text(
            'Wallet',
            style: blackTextStyle.copyWith(
              fontSize: 16,
              fontWeight: semiBold,
            ),
          ),
          const SizedBox(height: 10),
          BlocBuilder<AuthBloc, AuthState>(
            builder: (context, state) {
              if (state is AuthSuccess) {
                return Row(
                  children: [
                    Image.asset(
                      'assets/img_wallet.png',
                      width: 80,
                    ),
                    const SizedBox(width: 16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // r.{4} split every 4 characters
                        Text(
                          state.user.cardNumber!.replaceAllMapped(
                              RegExp(r".{4}"), (match) => "${match.group(0)} "),
                          style: blackTextStyle.copyWith(
                            fontWeight: medium,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          state.user.name.toString(),
                          style: greyTextStyle.copyWith(
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ],
                );
              }
              return Container();
            },
          ),
          buildSelectBank(context),
          const SizedBox(height: 12),
          // if (selectedPaymentMethod != null)
          //   CustomFilledButton(
          //     title: 'Continue',
          //     onPressed: () {
          //       Navigator.push(
          //         context,
          //         MaterialPageRoute(
          //           builder: (context) => TopUpAmountPage(
          //             data: TopupFormModel(
          //               paymentMethodCode: selectedPaymentMethod?.code,
          //             ),
          //           ),
          //         ),
          //       );
          //       // Navigator.pushNamed(context, '/top-up-amount');
          //     },
          //   ),
          // const SizedBox(height: 57),
        ],
      ),
      floatingActionButton: (selectedPaymentMethod != null)
          ? Container(
              margin: const EdgeInsets.all(24),
              child: CustomFilledButton(
                title: 'Continue',
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => TopUpAmountPage(
                        data: TopupFormModel(
                          paymentMethodCode: selectedPaymentMethod?.code,
                        ),
                      ),
                    ),
                  );
                  // Navigator.pushNamed(context, '/top-up-amount');
                },
              ),
            )
          : Container(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  Widget buildSelectBank(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Select Bank',
            style: blackTextStyle.copyWith(
              fontSize: 16,
              fontWeight: semiBold,
            ),
          ),
          const SizedBox(height: 14),
          BlocProvider(
            create: (context) => PaymentMethodsBloc()..add(PaymentMethodsGet()),
            child: BlocBuilder<PaymentMethodsBloc, PaymentMethodsState>(
              builder: (context, state) {
                if (state is PaymentMethodsSuccess) {
                  return Column(
                    children: state.paymentMethods.map((paymentMethods) {
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedPaymentMethod = paymentMethods;
                          });
                        },
                        child: BankItem(
                          paymentMethods: paymentMethods,
                          isSelected:
                              paymentMethods.id == selectedPaymentMethod?.id,
                        ),
                      );
                    }).toList(),

                    //[
                    // const BankItem(
                    //   imgUrl: 'assets/img_bank_bca.png',
                    //   title: 'Bank BCA',
                    //   isSelected: true,
                    // ),
                    // const BankItem(
                    //   imgUrl: 'assets/img_bank_bni.png',
                    //   title: 'Bank BNI',
                    // ),
                    // const BankItem(
                    //   imgUrl: 'assets/img_bank_mandiri.png',
                    //   title: 'Bank Mandiri',
                    // ),
                    // const BankItem(
                    //   imgUrl: 'assets/img_bank_ocbc.png',
                    //   title: 'Bank OCBC',
                    // ),
                    //],
                  );
                }
                return const Center(
                  child: CircularProgressIndicator(),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
