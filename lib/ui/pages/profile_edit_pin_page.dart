import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/auth/auth_bloc.dart';
import '../../shared/shared_method.dart';
import '../../shared/theme.dart';
import '../widgets/buttons.dart';
import '../widgets/forms.dart';

class ProfileEditPinPage extends StatefulWidget {
  const ProfileEditPinPage({super.key});

  @override
  State<ProfileEditPinPage> createState() => _ProfileEditPinPageState();
}

class _ProfileEditPinPageState extends State<ProfileEditPinPage> {
  final oldPinController = TextEditingController(text: '');
  final newPinController = TextEditingController(text: '');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit PIN'),
      ),
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthFailed) {
            showCustomSnackBar(context, state.e);
          }
          if (state is AuthSuccess) {
            Navigator.pushNamedAndRemoveUntil(
              context,
              '/edit-profile-success',
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
          return ListView(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            children: [
              const SizedBox(height: 30),
              Container(
                padding: const EdgeInsets.all(22),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: whiteColor,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // NOTE: USERNAME
                    CustomFormWidget(
                      controller: oldPinController,
                      title: 'Old PIN',
                      obscureText: true,
                    ),
                    // NOTE: FUll NAME
                    CustomFormWidget(
                      controller: newPinController,
                      title: 'New PIN',
                      obscureText: true,
                    ),

                    const SizedBox(height: 30),
                    CustomFilledButton(
                      title: 'Update Now',
                      onPressed: () {
                        context.read<AuthBloc>().add(
                              AuthUpdatePin(
                                  oldPinController.text, newPinController.text),
                            );
                      },
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
