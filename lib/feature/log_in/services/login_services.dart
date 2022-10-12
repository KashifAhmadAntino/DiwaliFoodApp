import 'package:get/get.dart';

import '../../../core/api_service/dio_service.dart';
import '../controller/login_controller.dart';

class LogInService {
  static LoginController loginController = Get.put(LoginController());
  static var dio = DioUtil().getInstance();
}
