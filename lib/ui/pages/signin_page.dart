import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sha_bank/models/sign_in_form_model.dart';
import 'package:sha_bank/shared/theme.dart';
import 'package:sha_bank/ui/widgets/buttons.dart';
import 'package:sha_bank/ui/widgets/forms.dart';
import 'package:sha_bank/ui/widgets/titles.dart';

import '../../blocs/auth/auth_bloc.dart';
import '../../shared/shared_method.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  bool validate() {
    if (emailController.text.isEmpty || passwordController.text.isEmpty) {
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthFailed) {
            showCustomSnackBar(context, state.e);
          }
          if (state is AuthSuccess) {
            Navigator.pushNamedAndRemoveUntil(
              context,
              '/home-page',
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
              Container(
                width: 155,
                height: 50,
                margin: const EdgeInsets.only(top: 100, bottom: 100),
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/img_logo_light.png'),
                  ),
                ),
              ),
              const CustomTitleWidget(title: 'Sign In &\nGrow Your Finance'),
              const SizedBox(height: 30),
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: whiteColor,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // NOTE: EMAIL INPUT
                    CustomFormWidget(
                      title: 'Email Address',
                      controller: emailController,
                    ),
                    const SizedBox(height: 16),
                    // NOTE: PASSWORD INPUT
                    CustomFormWidget(
                      controller: passwordController,
                      title: "Password",
                      obscureText: true,
                    ),
                    const SizedBox(height: 8),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        'Forgot Password',
                        style: blueTextStyle.copyWith(fontSize: 14),
                      ),
                    ),
                    const SizedBox(height: 30),
                    CustomFilledButton(
                      title: 'Sign In',
                      onPressed: () {
                        if (validate()) {
                          context.read<AuthBloc>().add(
                                AuthLogin(
                                  SignInFormModel(
                                    email: emailController.text,
                                    password: passwordController.text,
                                  ),
                                ),
                              );
                        } else {
                          showCustomSnackBar(
                              context, 'Semua field harus di isi');
                        }
                        // Navigator.pushNamedAndRemoveUntil(
                        //   context,
                        //   '/home-page',
                        //   (route) => false,
                        // );
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 50),
              CustomTextButton(
                title: 'Create New Account',
                onPressed: () {
                  Navigator.pushNamed(context, '/sign-up');
                },
              ),
            ],
          );
        },
      ),
    );
  }
}
