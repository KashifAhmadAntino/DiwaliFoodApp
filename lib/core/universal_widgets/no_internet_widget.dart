import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mvc_bolierplate_getx/core/reponsive/SizeConfig.dart';

/// A no internet Widget which will be shown if network connection is not
/// available.
class NoInternetWidget extends StatelessWidget {
  const NoInternetWidget({Key? key}) : super(key: key);
  static const noInternetWidgetKey = Key('no-internet-pages-key');
  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: Colors.black12,
        body: Padding(
          padding: EdgeInsets.all(15 * SizeConfig.heightMultiplier!),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'noInternet'.tr,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      );
}
