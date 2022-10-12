import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:mvc_bolierplate_getx/core/constants/app_text_style.dart';
import 'package:mvc_bolierplate_getx/core/constants/color_palette.dart';
import 'package:mvc_bolierplate_getx/core/constants/image_path.dart';
import 'package:mvc_bolierplate_getx/core/reponsive/SizeConfig.dart';
import 'package:mvc_bolierplate_getx/core/routes/app_routes.dart';
import 'package:mvc_bolierplate_getx/core/universal_widgets/form_field_widget.dart';
import 'package:mvc_bolierplate_getx/core/universal_widgets/form_submit_widget.dart';
import 'package:mvc_bolierplate_getx/core/utilites/utility.dart';
import 'package:mvc_bolierplate_getx/feature/log_in/controller/login_controller.dart';

import '../../../core/universal_widgets/searchable_dropdown.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);

  var loginController = Get.put(LoginController());

  String? currentSelectedValue;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(20 * SizeConfig.heightMultiplier!),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Login',
              style: AppTextStyle.blackBold40,
            ),
            SizedBox(
              height: 40 * SizeConfig.heightMultiplier!,
            ),
            SearchableDropdownWidget(
              hintText: 'Select Country',
              currrentSelectedValue: currentSelectedValue,
              titlesList: const [
                'India',
                'Australia',
                'UAE',
                'Canada',
                'Germany',
                'USA',
              ],
            ),
            SizedBox(
              height: 20 * SizeConfig.heightMultiplier!,
            ),
            FormFieldWidget(
              hintText: 'Phone Number',
              textInputType: TextInputType.number,
            ),
            SizedBox(
              height: 20 * SizeConfig.heightMultiplier!,
            ),
            FormFieldWidget(
              hintText: 'Password',
              obscureCharacter: '*',
              isObscureText: true,
            ),
            SizedBox(
              height: 10 * SizeConfig.heightMultiplier!,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  'Forgot Password?',
                  style: AppTextStyle.primaryMedium15,
                ),
              ],
            ),
            SizedBox(
              height: 20 * SizeConfig.heightMultiplier!,
            ),
            FormSubmitWidget(
              isDisable: false,
              title: 'Login',
              titleStyle: AppTextStyle.whiteMedium16,
              onTap: () {
                Navigator.pushNamed(context, RouteName.homeScreen);
                Utility.showInfoDialog(
                  message: 'Logged In',
                  isSuccess: true,
                );
              },
            ),
            SizedBox(
              height: 10 * SizeConfig.heightMultiplier!,
            ),
            FormSubmitWidget(
              isDisable: false,
              title: 'Login with Google',
              prefixIcon: SvgPicture.asset(
                ImagePath.googleIcon,
              ),
              buttonColor: AppColors.kPureWhite,
              titleStyle: AppTextStyle.whiteMedium16
                  .copyWith(color: AppColors.kPureBlack),
              onTap: () async {
                await loginController.googleAuthentication.signIn();
                // Navigator.pushNamed(context, RouteName.homeScreen);
                // Utility.showInfoDialog(
                //   message: 'Logged In',
                //   isSuccess: true,
                // );
              },
            ),
          ],
        ),
      ),
    );
  }
}
