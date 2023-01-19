import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sha_bank/models/sign_up_form_model.dart';
import 'package:sha_bank/shared/shared_method.dart';
import 'package:sha_bank/ui/pages/sign_up_page_set_ktp.dart';

import '../../shared/theme.dart';
import '../widgets/buttons.dart';
import '../widgets/forms.dart';
import '../widgets/titles.dart';

class SignUpUploadProfilePage extends StatefulWidget {
  final SignUpForm data;

  const SignUpUploadProfilePage({
    super.key,
    required this.data,
  });

  @override
  State<SignUpUploadProfilePage> createState() =>
      _SignUpUploadProfilePageState();
}

class _SignUpUploadProfilePageState extends State<SignUpUploadProfilePage> {
  final pinCotroller = TextEditingController(text: '');
  XFile? selectedImage;

  bool validate() {
    if (pinCotroller.text.length != 6) {
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    // print(widget.data.toJson());
    return Scaffold(
      body: ListView(
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
                              image: FileImage(File(selectedImage!
                                  .path)), // ! selectedImage udah pasti tidak null
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
                // Container(
                //   width: 120,
                //   height: 120,
                //   decoration: const BoxDecoration(
                //     shape: BoxShape.circle,
                //     image: DecorationImage(
                //       fit: BoxFit.cover,
                //       image: AssetImage('assets/img_profile.png'),
                //     ),
                //   ),
                // ),
                const SizedBox(height: 16),
                Text(
                  'Shayna Hanna',
                  style: blackTextStyle.copyWith(
                    fontSize: 18,
                    fontWeight: medium,
                  ),
                ),
                const SizedBox(height: 30),
                // NOTE: PIN INPUT
                CustomFormWidget(
                  controller: pinCotroller,
                  title: "Set PIN (6 digit number)",
                  keyboardType: TextInputType.number,
                  obscureText: true,
                ),
                const SizedBox(height: 30),
                CustomFilledButton(
                  title: 'Continue',
                  onPressed: () {
                    if (validate()) {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => SignUpSetKtpPage(
                            data: widget.data.copyWith(
                                pin: pinCotroller.text,
                                profilePicture: selectedImage == null
                                    ? null
                                    : 'data:image/png;base64,${base64Encode(
                                        File(selectedImage!.path)
                                            .readAsBytesSync(),
                                      )}'),
                          ),
                        ),
                      );
                      // Navigator.pushNamed(context, '/sign-up-set-ktp');
                    } else {
                      showCustomSnackBar(context, 'Pin harus 6 digit');
                    }
                  },
                ),
              ],
            ),
          ),
          const SizedBox(height: 50),
        ],
      ),
    );
  }
}
