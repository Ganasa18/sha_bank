import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sha_bank/blocs/user/user_bloc.dart';
import 'package:sha_bank/models/transfer_form_model.dart';
import 'package:sha_bank/models/user_model.dart';
import 'package:sha_bank/shared/theme.dart';
import 'package:sha_bank/ui/pages/transfer_amount_page.dart';
import 'package:sha_bank/ui/widgets/buttons.dart';
import 'package:sha_bank/ui/widgets/forms.dart';
import 'package:sha_bank/ui/widgets/transfer_result_user_item.dart';
import 'package:sha_bank/ui/widgets/transfer_user_item.dart';

class TransferPage extends StatefulWidget {
  const TransferPage({super.key});

  @override
  State<TransferPage> createState() => _TransferPageState();
}

class _TransferPageState extends State<TransferPage> {
  final usernameController = TextEditingController(text: '');
  UserModel? selectedUser;

  late UserBloc userBloc;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    userBloc = context.read<UserBloc>()..add(UserGetRecent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Transfer'),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        children: [
          const SizedBox(height: 30),
          Text(
            'Search',
            style: blackTextStyle.copyWith(
              fontSize: 16,
              fontWeight: semiBold,
            ),
          ),
          const SizedBox(height: 14),
          CustomFormWidget(
            controller: usernameController,
            title: 'by username',
            isShowTitle: false,
            onFieldSubmitted: (value) {
              if (value.isNotEmpty) {
                userBloc.add(UserGetByUsername(usernameController.text));
                // bisa juga dari value
                // userBloc.add(UserGetByUsername(value));
              } else {
                selectedUser = null;
                userBloc.add(UserGetRecent());
              }
              setState(() {});
            },
          ),
          usernameController.text.isEmpty
              ? buildRecentUsers()
              : buildResultUsers(),
          // buildResultUsers(),
          const SizedBox(height: 274),
        ],
      ),
      floatingActionButton: selectedUser != null
          ? Container(
              margin: const EdgeInsets.all(24),
              child: CustomFilledButton(
                title: 'Continue',
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => TransferAmountPage(
                          data: TransferFormModel(
                        sendTo: selectedUser!.username,
                      )),
                    ),
                  );
                },
              ),
            )
          : Container(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  Widget buildRecentUsers() {
    return Container(
      margin: const EdgeInsets.only(top: 40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Recent Users',
            style: blackTextStyle.copyWith(
              fontSize: 16,
              fontWeight: semiBold,
            ),
          ),

          BlocBuilder<UserBloc, UserState>(
            builder: (context, state) {
              if (state is UserSuccess) {
                return Column(
                  children: state.users.map((user) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => TransferAmountPage(
                                data: TransferFormModel(
                              sendTo: user.username,
                            )),
                          ),
                        );
                      },
                      child: TransferRecentUserItem(user: user),
                    );
                  }).toList(),
                );
              }
              return const Center(
                child: CircularProgressIndicator(),
              );
            },
          ),

          // const TransferRecentUserItem(
          //   imageUrl: 'assets/img_friend1.png',
          //   name: 'Yonna Jie',
          //   username: 'yoenna',
          //   isVerified: true,
          // ),
        ],
      ),
    );
  }

  Widget buildResultUsers() {
    return Container(
      margin: const EdgeInsets.only(top: 40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Result',
            style: blackTextStyle.copyWith(
              fontSize: 16,
              fontWeight: semiBold,
            ),
          ),
          const SizedBox(height: 14),
          BlocBuilder<UserBloc, UserState>(
            builder: (context, state) {
              if (state is UserSuccess) {
                return Wrap(
                  runSpacing: 17,
                  spacing: 17,
                  children: state.users.map((user) {
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedUser = user;
                        });
                      },
                      child: TransferResultUserItem(
                        user: user,
                        isSelected: user.id == selectedUser?.id,
                      ),
                    );
                  }).toList(),
                );
              }
              return const Center(
                child: CircularProgressIndicator(),
              );
            },
          )
        ],
      ),
    );
  }
}
