import 'dart:developer';

import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sha_bank/shared/theme.dart';
import 'package:image_picker/image_picker.dart';

void showCustomSnackBar(BuildContext context, String message) {
  Flushbar(
    message: message,
    flushbarPosition: FlushbarPosition.TOP,
    backgroundColor: colorRed,
    duration: const Duration(seconds: 2),
  ).show(context);
}

formatCurrency(
  num number, {
  String symbol = "Rp ",
}) {
  return NumberFormat.currency(
    locale: 'id',
    decimalDigits: 0,
    symbol: symbol,
  ).format(number);
}

// Future digunakan jika menggunakan asynchronously

Future<XFile?> selectImage() async {
  XFile? selectImage = await ImagePicker().pickImage(
    source: ImageSource.gallery,
  );

  // inspect(selectImage);

  return selectImage;
}
