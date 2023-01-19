import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sha_bank/models/sign_up_form_model.dart';
import 'package:sha_bank/shared/shared_method.dart';
import 'package:sha_bank/ui/pages/sign_up_page_profile.dart';

import '../../blocs/auth/auth_bloc.dart';
import '../../shared/theme.dart';
import '../widgets/buttons.dart';
import '../widgets/forms.dart';
import '../widgets/titles.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final nameController = TextEditingController(text: '');
  final emailController = TextEditingController(text: '');
  final passwordController = TextEditingController(text: '');

  bool validate() {
    if (nameController.text.isEmpty ||
        emailController.text.isEmpty ||
        passwordController.text.isEmpty) {
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
          if (state is AuthCheckEmailSuccess) {
            SignUpForm form = SignUpForm(
              name: nameController.text,
              email: emailController.text,
              password: passwordController.text,
              pin: '',
            );
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => SignUpUploadProfilePage(
                  data: form,
                ),
              ),
            );
            // Navigator.pushNamed(context, '/sign-up-upload-profile');
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
              const CustomTitleWidget(title: 'Join Us to Unlock\nYour Growth'),
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
                    // NOTE: FUll NAME
                    CustomFormWidget(
                      title: 'Full Name',
                      controller: nameController,
                    ),
                    const SizedBox(height: 16),
                    // NOTE: EMAIL INPUT
                    CustomFormWidget(
                      title: 'Email Address',
                      controller: emailController,
                    ),
                    const SizedBox(height: 16),
                    // NOTE: PASSWORD INPUT
                    CustomFormWidget(
                      title: "Password",
                      obscureText: true,
                      controller: passwordController,
                    ),
                    const SizedBox(height: 30),
                    CustomFilledButton(
                      title: 'Continue',
                      onPressed: () {
                        if (validate()) {
                          context.read<AuthBloc>().add(
                                AuthCheckEmail(emailController.text),
                              );
                        } else {
                          showCustomSnackBar(
                              context, 'Semua field harus di isi');
                        }
                      },
                    ),
                    const SizedBox(height: 30),
                  ],
                ),
              ),
              const SizedBox(height: 50),
              CustomTextButton(
                title: 'Sign In',
                onPressed: () {
                  Navigator.pushNamed(context, '/sign-in');
                },
              ),
              const SizedBox(height: 58),
            ],
          );
        },
      ),
    );
  }
}
