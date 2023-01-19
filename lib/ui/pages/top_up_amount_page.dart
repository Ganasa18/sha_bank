import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:sha_bank/blocs/auth/auth_bloc.dart';
import 'package:sha_bank/models/top_up_form_model.dart';
import 'package:sha_bank/shared/shared_method.dart';
import 'package:sha_bank/shared/theme.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../blocs/topup/topup_bloc.dart';
import '../widgets/buttons.dart';

class TopUpAmountPage extends StatefulWidget {
  final TopupFormModel data;
  const TopUpAmountPage({super.key, required this.data});

  @override
  State<TopUpAmountPage> createState() => _TopUpAmountPageState();
}

class _TopUpAmountPageState extends State<TopUpAmountPage> {
  final TextEditingController amountController =
      TextEditingController(text: '0');

  @override
  void initState() {
    super.initState();
    amountController.addListener(() {
      final text = amountController.text;

      // print(text);
      // print(amountController.value);

      amountController.value = amountController.value.copyWith(
        text: NumberFormat.currency(
          locale: 'id',
          decimalDigits: 0,
          symbol: '',
        ).format(
          int.parse(text == '' ? '0' : text.replaceAll('.', '')),
        ),
      );
    });
  }

  addAmount(String number) {
    if (amountController.text == '0') {
      amountController.text = '';
    }
    setState(() {
      amountController.text = amountController.text + number;
    });
  }

  deleteAmount() {
    if (amountController.text.isNotEmpty) {
      setState(() {
        amountController.text = amountController.text
            .substring(0, amountController.text.length - 1);
        if (amountController.text == '') {
          amountController.text = '0';
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: darkBackgroundColor,
      body: BlocProvider(
        create: (context) => TopupBloc(),
        child: BlocConsumer<TopupBloc, TopupState>(
          listener: (context, state) async {
            if (state is TopupFailed) {
              showCustomSnackBar(context, state.e);
            }

            if (state is TopupSuccess) {
              if (await canLaunchUrl(Uri.parse(state.redirectUrl))) {
                launchUrl(Uri.parse(state.redirectUrl));
              }
              // ignore: use_build_context_synchronously
              context.read<AuthBloc>().add(
                    AuthUpdateBalance(
                      int.parse(
                        amountController.text.replaceAll('.', ''),
                      ),
                    ),
                  );
              // ignore: use_build_context_synchronously
              Navigator.pushNamedAndRemoveUntil(
                context,
                '/top-up-success',
                (route) => false,
              );
            }
          },
          builder: (context, state) {
            if (state is TopupLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return ListView(
              padding: const EdgeInsets.symmetric(horizontal: 58.0),
              children: [
                const SizedBox(height: 56),
                Center(
                  child: Text(
                    'Total Amount',
                    style: whiteTextStyle.copyWith(
                      fontWeight: semiBold,
                      fontSize: 20,
                    ),
                  ),
                ),
                const SizedBox(height: 67),
                // Align default center
                Align(
                  child: SizedBox(
                    width: 200,
                    child: TextFormField(
                      enabled: false,
                      controller: amountController,
                      style: whiteTextStyle.copyWith(
                        fontSize: 36,
                        fontWeight: medium,
                      ),
                      decoration: InputDecoration(
                        prefixIcon: Text(
                          'Rp',
                          style: whiteTextStyle.copyWith(
                            fontSize: 36,
                            fontWeight: medium,
                          ),
                        ),
                        disabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: greyColor),
                        ),
                      ),
                      cursorColor: greyColor,
                    ),
                  ),
                ),
                const SizedBox(height: 66),
                Wrap(
                  spacing: 40,
                  runSpacing: 40,
                  children: [
                    CustomInputButton(
                      title: '1',
                      onTap: () {
                        addAmount('1');
                      },
                    ),
                    CustomInputButton(
                      title: '2',
                      onTap: () {
                        addAmount('2');
                      },
                    ),
                    CustomInputButton(
                      title: '3',
                      onTap: () {
                        addAmount('3');
                      },
                    ),
                    CustomInputButton(
                      title: '4',
                      onTap: () {
                        addAmount('4');
                      },
                    ),
                    CustomInputButton(
                      title: '5',
                      onTap: () {
                        addAmount('5');
                      },
                    ),
                    CustomInputButton(
                      title: '6',
                      onTap: () {
                        addAmount('6');
                      },
                    ),
                    CustomInputButton(
                      title: '7',
                      onTap: () {
                        addAmount('7');
                      },
                    ),
                    CustomInputButton(
                      title: '8',
                      onTap: () {
                        addAmount('8');
                      },
                    ),
                    CustomInputButton(
                      title: '9',
                      onTap: () {
                        addAmount('9');
                      },
                    ),
                    const SizedBox(width: 60, height: 60),
                    CustomInputButton(
                      title: '0',
                      onTap: () {
                        addAmount('0');
                      },
                    ),
                    GestureDetector(
                      onTap: () {
                        deleteAmount();
                      },
                      child: Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: numberBackgroundColor,
                        ),
                        child: Center(
                          child: Icon(
                            Icons.arrow_back,
                            color: whiteColor,
                            // size: 24,// ukuran default 24
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 50),
                CustomFilledButton(
                  title: 'Checkout Now',
                  onPressed: () async {
                    if (await Navigator.pushNamed(context, '/pin') == true) {
                      // di gunakanan karna membutuhkan pin untuk kirim data
                      final authState = context.read<AuthBloc>().state;

                      String pin = '';
                      if (authState is AuthSuccess) {
                        pin = authState.user.pin!;
                      }

                      context.read<TopupBloc>().add(
                            TopupPost(
                              widget.data.copyWith(
                                pin: pin,
                                amount:
                                    amountController.text.replaceAll('.', ''),
                              ),
                            ),
                          );

                      // if (await canLaunchUrl(
                      //     Uri.parse('https://demo.midtrans.com/'))) {
                      //   launchUrl(Uri.parse('https://demo.midtrans.com/'));
                      // }
                      // // ignore: use_build_context_synchronously
                      //  Navigator.pushNamedAndRemoveUntil(
                      //   context,
                      //   '/top-up-success',
                      //   (route) => false,
                      // );
                    }
                  },
                ),
                const SizedBox(height: 25),
                CustomTextButton(
                  title: 'Term & Conditions',
                  onPressed: () {},
                ),
                const SizedBox(height: 40),
              ],
            );
          },
        ),
      ),
    );
  }
}
