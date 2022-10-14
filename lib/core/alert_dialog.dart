import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProgressDialog {
  openProgressDialog() {
    Get.dialog(
      WillPopScope(
        onWillPop: () async => false,
        child: SizedBox(
          child: Center(
            child: Container(
              height: 80,
              width: 80,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12), color: Colors.white),
              child: Center(
                child: CircularProgressIndicator(),
              ),
            ),
          ),
        ),
      ),
      barrierDismissible: true,
    );
  }

  closeProgressDialog({int seconds = 1, VoidCallback? onDialogClosed}) {
    bool isOpen = Get.isDialogOpen ?? false;
    if (isOpen) {
      Future.delayed(Duration(seconds: seconds), () {
        log('drawer closed');
        Get.back();
        if (onDialogClosed != null) {
          onDialogClosed();
        }
      });
      // Get.back();
    } else {
      log('already closed');
    }
  }
}
