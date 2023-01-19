import 'package:flutter/material.dart';
import 'package:sha_bank/blocs/auth/auth_bloc.dart';
import 'package:sha_bank/models/user_edit_form_model.dart';
import 'package:sha_bank/shared/shared_method.dart';
import '../../shared/theme.dart';
import '../widgets/buttons.dart';
import '../widgets/forms.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileEditPage extends StatefulWidget {
  const ProfileEditPage({super.key});

  @override
  State<ProfileEditPage> createState() => _ProfileEditPageState();
}

class _ProfileEditPageState extends State<ProfileEditPage> {
  final userNameController = TextEditingController(text: '');
  final nameController = TextEditingController(text: '');
  final emailController = TextEditingController(text: '');
  final passwordController = TextEditingController(text: '');

  @override
  void initState() {
    super.initState();
    final authState = context.read<AuthBloc>().state;
    if (authState is AuthSuccess) {
      userNameController.text = authState.user.username!;
      nameController.text = authState.user.name!;
      emailController.text = authState.user.email!;
      passwordController.text = authState.user.password!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Profile'),
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
                      controller: userNameController,
                      title: 'Username',
                    ),
                    // NOTE: FUll NAME
                    CustomFormWidget(
                      controller: nameController,
                      title: 'Full Name',
                    ),
                    const SizedBox(height: 16),
                    // NOTE: EMAIL INPUT
                    CustomFormWidget(
                      controller: emailController,
                      title: 'Email Address',
                    ),
                    const SizedBox(height: 16),
                    // NOTE: PASSWORD INPUT
                    CustomFormWidget(
                      controller: passwordController,
                      title: "Password",
                      obscureText: true,
                    ),
                    const SizedBox(height: 30),
                    CustomFilledButton(
                      title: 'Update Now',
                      onPressed: () {
                        context.read<AuthBloc>().add(
                              AuthUpdateUser(
                                UserEditFormModel(
                                  name: nameController.text,
                                  username: userNameController.text,
                                  email: emailController.text,
                                  password: passwordController.text,
                                ),
                              ),
                            );
                        // Navigator.pushNamedAndRemoveUntil(
                        //   context,
                        //   '/edit-profile-success',
                        //   (route) => false,
                        // );
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
