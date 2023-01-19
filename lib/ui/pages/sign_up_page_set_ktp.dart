import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sha_bank/models/sign_up_form_model.dart';

import '../../blocs/auth/auth_bloc.dart';
import '../../shared/shared_method.dart';
import '../../shared/theme.dart';
import '../widgets/buttons.dart';
import '../widgets/titles.dart';

class SignUpSetKtpPage extends StatefulWidget {
  final SignUpForm data;
  const SignUpSetKtpPage({
    super.key,
    required this.data,
  });

  @override
  State<SignUpSetKtpPage> createState() => _SignUpSetKtpPageState();
}

class _SignUpSetKtpPageState extends State<SignUpSetKtpPage> {
  XFile? selectedImage;

  bool validate() {
    if (selectedImage == null) {
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    // log('${widget.data.toJson()} from set up ktp');
    return Scaffold(
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthFailed) {
            showCustomSnackBar(context, state.e);
          }
          if (state is AuthSuccess) {
            Navigator.pushNamed(context, '/sign-up-success');
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
              const CustomTitleWidget(title: 'Verify Your\nAccount'),
              const SizedBox(height: 30),
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: whiteColor,
                ),
                child: Column(
                  // crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () async {
                        final image = await selectImage();
                        setState(() {
                          selectedImage = image;
                        });
                      },
                      child: Container(
                        width: 120,
                        height: 120,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: lightColor,
                          image: selectedImage == null
                              ? null
                              : DecorationImage(
                                  fit: BoxFit.cover,
                                  image: FileImage(
                                    File(selectedImage!.path),
                                  ), // ! selectedImage udah pasti tidak null
                                ),
                        ),
                        child: selectedImage != null
                            ? null
                            : Center(
                                child: Image.asset(
                                  'assets/ic_upload.png',
                                  width: 32,
                                ),
                              ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Passport/ID Card',
                      style: blackTextStyle.copyWith(
                        fontSize: 18,
                        fontWeight: medium,
                      ),
                    ),
                    const SizedBox(height: 50),
                    CustomFilledButton(
                      title: 'Continue',
                      onPressed: () {
                        if (validate()) {
                          context.read<AuthBloc>().add(
                                AuthRegister(
                                  widget.data.copyWith(
                                    ktp: selectedImage == null
                                        ? null
                                        : 'data:image/png;base64,${base64Encode(
                                            File(selectedImage!.path)
                                                .readAsBytesSync(),
                                          )}',
                                  ),
                                ),
                              );
                          // Navigator.pushNamed(context, '/sign-up-success');
                        } else {
                          showCustomSnackBar(
                              context, 'Image tidak boleh kosong');
                        }
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 60),
              CustomTextButton(
                title: 'Skip for Now',
                onPressed: () {
                  context.read<AuthBloc>().add(
                        AuthRegister(
                          widget.data.copyWith(
                            ktp: '',
                          ),
                        ),
                      );
                },
              ),
            ],
          );
        },
      ),
    );
  }
}
