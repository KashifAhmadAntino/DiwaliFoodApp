import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mvc_bolierplate_getx/core/api_service/dio_service.dart';
import 'package:mvc_bolierplate_getx/core/constants/app_text_style.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static var dio = DioUtil().getInstance();
  String ip = '';

  @override
  void initState() {
    getIp();
    super.initState();
  }

  Future<void> getIp() async {
    var response = await dio!.get('https://api.ipify.org?format=json');
    setState(() {
      ip = response.data['ip'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: Get.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Home',
              style: AppTextStyle.blackBold40,
            ),
            Text(
              'IP : $ip',
              style: AppTextStyle.greyMedium14,
            )
          ],
        ),
      ),
    );
  }
}
