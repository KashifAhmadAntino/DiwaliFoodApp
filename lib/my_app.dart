import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mvc_bolierplate_getx/core/constants/color_palette.dart';

import 'core/constants/image_path.dart';
import 'core/reponsive/SizeConfig.dart';
import 'core/routes/app_routes.dart';

class MyApp extends StatelessWidget {
  // final AppTranslations translations;
  final Widget child;
  const MyApp(
      {Key? key,
      // required this.translations,
      required this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(360, 728),
        minTextAdapt: true,
        builder: (_, __) {
          return LayoutBuilder(builder: (context, constraints) {
            return OrientationBuilder(builder: (context, orientation) {
              SizeConfig().init(constraints, orientation);
              SystemChrome.setPreferredOrientations([
                DeviceOrientation.portraitUp,
              ]);
              return GetMaterialApp(
                title: 'Food Wizard',
                scaffoldMessengerKey: snackbarKey,
                //  darkTheme: ThemeData.dark(),
                theme: ThemeData(
                  //scaffold color of app
                  scaffoldBackgroundColor: AppColors.kPureWhite,
                  //used in my trainer screen & icon back button color & post screen
                  primaryColor: AppColors.kPureWhite,
                  //used in all trainer screen in Item category
                  secondaryHeaderColor: AppColors.kPureWhite,
                  primaryColorLight: AppColors.kPureWhite,
                  primaryColorDark: AppColors.kPureWhite,
                  // used in achiements certificate
                  highlightColor: const Color(0xff28362B),
                  indicatorColor: const Color(0xff37342F),
                  // icon used in homescreen & used in needle color
                  primaryIconTheme:
                      const IconThemeData(color: AppColors.kPureWhite),
                  // appBarTheme: const AppBarTheme(
                  //     color: AppColors.kPureWhite,
                  //     titleTextStyle: TextStyle(color: AppColors.kPureWhite),
                  //     iconTheme: IconThemeData(color: AppColors.kPureWhite),
                  //     actionsIconTheme: IconThemeData(color: AppColors.kPureWhite)),
                  // primary text theme
                  textTheme: const TextTheme(
                    //primary text color used in gettrainerscreen & trainer profile Screen & home Screen
                    bodyText1: TextStyle(color: AppColors.kPureBlack),
                    // used in home screen today text
                  ),
                  //Trainer card in get trainer screen & all trainer Screen & home sceen
                  cardColor: AppColors.kPureBlack,
                ),
                // translations: translations,
                locale: const Locale('en', 'US'),
                fallbackLocale: const Locale('es', 'ES'),
                onGenerateRoute: GenerateRoute.generateRoute,
                navigatorObservers: const [],
                home: child,
              );
            });
          });
        });
  }
}
