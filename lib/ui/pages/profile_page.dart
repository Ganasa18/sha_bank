import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sha_bank/blocs/auth/auth_bloc.dart';
import 'package:sha_bank/shared/shared_method.dart';
import 'package:sha_bank/shared/theme.dart';
import 'package:sha_bank/ui/pages/profile_menu_item.dart';
import 'package:sha_bank/ui/widgets/buttons.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'My Profile',
        ),
        elevation: 0,
        backgroundColor: lightBackgroundColor,
      ),
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthFailed) {
            showCustomSnackBar(context, state.e);
          }
          if (state is AuthInitial) {
            Navigator.pushNamedAndRemoveUntil(
              context,
              '/sign-in',
              (route) => false,
            );
          }
        },
        builder: (context, state) {
          if (state is AuthLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (state is AuthSuccess) {
            return ListView(
              children: [
                const SizedBox(height: 30),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 22),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: whiteColor,
                  ),
                  child: Column(
                    children: [
                      Container(
                        width: 120,
                        height: 120,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            image: state.user.profilePicture == null
                                ? const AssetImage('assets/img_profile.png')
                                : NetworkImage(state.user.profilePicture!)
                                    as ImageProvider,
                          ),
                        ),
                        child: state.user.verified == 1
                            ? Align(
                                alignment: Alignment.topRight,
                                child: Container(
                                  width: 28,
                                  height: 28,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: whiteColor,
                                  ),
                                  child: Center(
                                    child: Icon(
                                      Icons.check_circle,
                                      color: greenColor,
                                      size: 24,
                                    ),
                                  ),
                                ),
                              )
                            : null,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        state.user.name.toString(),
                        style: blackTextStyle.copyWith(
                          fontWeight: medium,
                          fontSize: 18,
                        ),
                      ),
                      const SizedBox(height: 41),
                      ProfileMenuItem(
                        iconUrl: 'assets/ic_edit_profile.png',
                        title: 'Edit Profile',
                        onTap: () async {
                          if (await Navigator.pushNamed(context, '/pin') ==
                              true) {
                            Navigator.pushNamed(context, '/edit-profile-page');
                          }
                        },
                      ),
                      ProfileMenuItem(
                        iconUrl: 'assets/ic_pin.png',
                        title: 'My PIN',
                        onTap: () async {
                          if (await Navigator.pushNamed(context, '/pin') ==
                              true) {
                            Navigator.pushNamed(context, '/pin-edit');
                          }
                        },
                      ),
                      ProfileMenuItem(
                        iconUrl: 'assets/ic_wallet.png',
                        title: 'Wallet Settings',
                        onTap: () {},
                      ),
                      ProfileMenuItem(
                        iconUrl: 'assets/ic_reward.png',
                        title: 'My Rewards',
                        onTap: () {},
                      ),
                      ProfileMenuItem(
                        iconUrl: 'assets/ic_help.png',
                        title: 'Help Center',
                        onTap: () {},
                      ),
                      ProfileMenuItem(
                        iconUrl: 'assets/ic_logout.png',
                        title: 'Log Out',
                        onTap: () {
                          context.read<AuthBloc>().add(AuthLogout());
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 87),
                CustomTextButton(title: 'Report a Problem', onPressed: () {}),
                const SizedBox(height: 50),
              ],
            );
          }
          return Container();
        },
      ),
    );
  }
}
