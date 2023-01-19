import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sha_bank/models/user_model.dart';
import 'package:sha_bank/shared/shared_method.dart';
import 'package:sha_bank/ui/widgets/home_latest_transaction_item.dart';
import 'package:sha_bank/ui/widgets/home_service_item.dart';
import 'package:sha_bank/ui/widgets/home_tips_item.dart';
import 'package:sha_bank/ui/widgets/home_user_item.dart';

import '../../blocs/auth/auth_bloc.dart';
import '../../blocs/tip/tip_bloc.dart';
import '../../blocs/transaction/transaction_bloc.dart';
import '../../blocs/user/user_bloc.dart';
import '../../models/transfer_form_model.dart';
import '../../shared/theme.dart';
import 'transfer_amount_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomAppBar(
        elevation: 0,
        color: whiteColor,
        shape: const CircularNotchedRectangle(),
        clipBehavior: Clip.antiAlias,
        notchMargin: 6,
        child: BottomNavigationBar(
          backgroundColor: whiteColor,
          type: BottomNavigationBarType.fixed,
          elevation: 0,
          selectedItemColor: blueColor,
          unselectedItemColor: blackColor,
          showSelectedLabels: true,
          showUnselectedLabels: true,
          selectedLabelStyle: blueTextStyle.copyWith(
            fontSize: 10,
            fontWeight: medium,
          ),
          unselectedLabelStyle: blackTextStyle.copyWith(
            fontSize: 10,
            fontWeight: medium,
          ),
          items: [
            BottomNavigationBarItem(
                icon: Image.asset(
                  'assets/ic_overview.png',
                  width: 20,
                  color: blueColor,
                ),
                label: 'Overview'),
            BottomNavigationBarItem(
                icon: Image.asset(
                  'assets/ic_history.png',
                  width: 20,
                ),
                label: 'History'),
            const BottomNavigationBarItem(icon: Icon(Icons.person), label: ''),
            BottomNavigationBarItem(
                icon: Image.asset(
                  'assets/ic_statistic.png',
                  width: 20,
                ),
                label: 'Statistic'),
            BottomNavigationBarItem(
                icon: Image.asset(
                  'assets/ic_reward.png',
                  width: 20,
                ),
                label: 'Reward'),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: purpleColor,
        child: Image.asset(
          'assets/ic_plus_circle.png',
          width: 24,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        children: [
          buildProfile(context),
          buildWalletCard(),
          buildLevel(),
          buildServices(context),
          buildLatestTransactions(),
          buildSendAgain(),
          buildFriendlyTips(),
        ],
      ),
    );
  }

  Widget buildProfile(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        if (state is AuthSuccess) {
          final UserModel user = state.user;
          return Container(
            margin: const EdgeInsets.only(top: 40),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Howdy',
                      style: greyTextStyle.copyWith(
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      user.name.toString(),
                      style: blackTextStyle.copyWith(
                        fontSize: 20,
                        fontWeight: semiBold,
                      ),
                    ),
                  ],
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, '/profile-page');
                  },
                  child: Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: user.profilePicture == null
                            ? const AssetImage('assets/img_profile.png')
                            : NetworkImage(user.profilePicture!)
                                as ImageProvider,
                      ),
                    ),
                    child: Align(
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
                    ),
                  ),
                ),
              ],
            ),
          );
        }
        return Container();
      },
    );
  }

  Widget buildWalletCard() {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        if (state is AuthSuccess) {
          final UserModel user = state.user;
          return Container(
            width: double.infinity,
            height: 220,
            margin: const EdgeInsets.only(top: 30),
            padding: const EdgeInsets.all(30),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(28),
              image: const DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage('assets/img_bg_card.png'),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  user.name.toString(),
                  style: whiteTextStyle.copyWith(
                    fontWeight: medium,
                    fontSize: 18,
                  ),
                ),
                const SizedBox(height: 28),
                Text(
                  '**** **** **** ${user.cardNumber!.substring(12, 16)}',
                  style: whiteTextStyle.copyWith(
                    fontWeight: medium,
                    fontSize: 18,
                    letterSpacing: 6,
                  ),
                ),
                const SizedBox(height: 21),
                Text('Balance', style: whiteTextStyle),
                Text(
                  formatCurrency(user.balance ?? 0),
                  style: whiteTextStyle.copyWith(
                    fontSize: 24,
                    fontWeight: semiBold,
                  ),
                ),
              ],
            ),
          );
        }
        return Container();
      },
    );
  }

  Widget buildLevel() {
    return Container(
      padding: const EdgeInsets.all(22),
      margin: const EdgeInsets.only(top: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: whiteColor,
      ),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                'Level 1',
                style: blackTextStyle.copyWith(
                  fontWeight: medium,
                ),
              ),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.only(right: 4),
                child: Text(
                  '55%',
                  style: greenTextStyle.copyWith(
                    fontWeight: semiBold,
                  ),
                ),
              ),
              Text(
                'of ${formatCurrency(20000)}',
                style: blackTextStyle.copyWith(
                  fontWeight: semiBold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          ClipRRect(
            borderRadius: BorderRadius.circular(55),
            child: LinearProgressIndicator(
              minHeight: 5,
              value: 0.55,
              valueColor: AlwaysStoppedAnimation(greenColor),
              backgroundColor: lightColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildServices(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Do Something',
            style: blackTextStyle.copyWith(fontSize: 16, fontWeight: semiBold),
          ),
          const SizedBox(height: 14),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              HomeServiceItem(
                iconUrl: "assets/ic_topup.png",
                title: 'Top Up',
                onTap: () {
                  Navigator.pushNamed(context, '/top-up');
                },
              ),
              HomeServiceItem(
                iconUrl: "assets/ic_send.png",
                title: 'Send',
                onTap: () {
                  Navigator.pushNamed(context, '/transfer');
                },
              ),
              HomeServiceItem(
                iconUrl: "assets/ic_withdraw.png",
                title: 'Withdraw',
                onTap: () {},
              ),
              HomeServiceItem(
                iconUrl: "assets/ic_more.png",
                title: 'More',
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) => const MoreDialog(),
                  );
                },
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget buildLatestTransactions() {
    return Container(
      margin: const EdgeInsets.only(top: 30),
      child: BlocProvider(
        create: (context) => TransactionBloc()..add(TransactionGet()),
        child: BlocBuilder<TransactionBloc, TransactionState>(
          builder: (context, state) {
            if (state is TransactionSuccess) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Latest Transactions',
                    style: blackTextStyle.copyWith(
                        fontSize: 16, fontWeight: semiBold),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 14),
                    padding: const EdgeInsets.all(22),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: whiteColor,
                    ),
                    child: Column(
                      children: state.transactions.map((transaction) {
                        return HomeLatestTransactionItem(
                          transaction: transaction,
                        );
                      }).toList(),
                    ),
                  ),
                ],
              );
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }

  Widget buildSendAgain() {
    return Container(
      margin: const EdgeInsets.only(top: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Send Again',
            style: blackTextStyle.copyWith(fontSize: 16, fontWeight: semiBold),
          ),
          const SizedBox(height: 14),
          BlocProvider(
            create: (context) => UserBloc()..add(UserGetRecent()),
            child: BlocBuilder<UserBloc, UserState>(
              builder: (context, state) {
                if (state is UserSuccess) {
                  return SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
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
                          child: HomeUserItem(user: user),
                        );
                      }).toList(),
                    ),
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

  Widget buildFriendlyTips() {
    return Container(
      margin: const EdgeInsets.only(top: 30, bottom: 50),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Friendly Tips',
            style: blackTextStyle.copyWith(
              fontSize: 16,
              fontWeight: semiBold,
            ),
          ),
          const SizedBox(height: 14),
          BlocProvider(
            create: (context) => TipBloc()..add(TipGet()),
            child: BlocBuilder<TipBloc, TipState>(
              builder: (context, state) {
                if (state is TipSuccess) {
                  return Wrap(
                    spacing: 17,
                    runSpacing: 18,
                    children: state.tips.map(
                      (tip) {
                        return HomeTipsItem(tip: tip);
                      },
                    ).toList(),
                  );
                }
                return const Center(
                  child: CircularProgressIndicator(),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}

class MoreDialog extends StatelessWidget {
  const MoreDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      alignment: Alignment.bottomCenter,
      backgroundColor: Colors.transparent,
      insetPadding: EdgeInsets.zero,
      content: Container(
        height: 326,
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.all(30),
        decoration: BoxDecoration(
          color: whiteColor,
          borderRadius: BorderRadius.circular(40),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Do More With Us',
              style: blackTextStyle.copyWith(
                fontSize: 16,
                fontWeight: semiBold,
              ),
            ),
            const SizedBox(height: 13),
            Wrap(
              spacing: 29,
              runSpacing: 25,
              children: [
                HomeServiceItem(
                  iconUrl: "assets/ic_product_data.png",
                  title: 'Data',
                  onTap: () {
                    Navigator.pushNamed(context, '/data');
                  },
                ),
                HomeServiceItem(
                  iconUrl: "assets/ic_product_water.png",
                  title: 'Water',
                  onTap: () {},
                ),
                HomeServiceItem(
                  iconUrl: "assets/ic_product_stream.png",
                  title: 'Stream',
                  onTap: () {},
                ),
                HomeServiceItem(
                  iconUrl: "assets/ic_product_movie.png",
                  title: 'Movie',
                  onTap: () {},
                ),
                HomeServiceItem(
                  iconUrl: "assets/ic_product_food.png",
                  title: 'Food',
                  onTap: () {},
                ),
                HomeServiceItem(
                  iconUrl: "assets/ic_product_travel.png",
                  title: 'Travel',
                  onTap: () {},
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
