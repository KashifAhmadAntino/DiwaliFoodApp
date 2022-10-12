import 'package:flutter/material.dart';
import 'package:mvc_bolierplate_getx/feature/home/view/home.dart';

import '../../feature/log_in/view/login_screen.dart';

abstract class RouteName {
  static const loginScreen = '/login';
  static const homeScreen = '/home';

  RouteName._();
}

class GenerateRoute {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final route = settings.name;
    if (route == RouteName.loginScreen) {
      return MaterialPageRoute(
        builder: (
          BuildContext context,
        ) =>
            LoginScreen(),
      );
    } else if (route == RouteName.homeScreen) {
      return MaterialPageRoute(
        builder: (
          BuildContext context,
        ) =>
            const HomePage(),
      );
    } else {
      return PageRouteBuilder(
          pageBuilder: (BuildContext context, Animation<double> animation,
                  Animation<double> secondaryAnimation) =>
              LoginScreen());
    }
  }
}
