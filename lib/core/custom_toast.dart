import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ShowCustomToast {
  void showToast({bool errorMessage = false, String? message}) {
    log('showing snxckbar');
    Get.showSnackbar(GetSnackBar(
      messageText: Text(
        message ?? "",
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: Colors.white,
        ),
      ),
      duration: const Duration(seconds: 3),
      animationDuration: const Duration(seconds: 0),
      icon: Icon(
        !errorMessage ? Icons.close : Icons.info,
        color: Colors.white,
      ),
      borderRadius: 4.0,
      padding: EdgeInsets.all(16),
      margin: EdgeInsets.only(left: 16, right: 16, bottom: 48),
      backgroundColor: !errorMessage ? Colors.green : Colors.red,
      borderWidth: 1,
      snackPosition: SnackPosition.BOTTOM,
      snackStyle: SnackStyle.FLOATING,
      //backgroundColor: Colors.white,
    ));
  }
}
