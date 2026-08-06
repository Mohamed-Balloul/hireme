// import 'package:hireme/core/constant/routes.dart';
// import 'package:hireme/core/services/services.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// class MyMiddleware extends GetMiddleware {
//   @override
//   int? get Priority => 1;
//   MyServices myServices = Get.find();

//   @override
//   RouteSettings? redirect(String? route) {
//     if (myServices.sharedPreferences.getString("ishesawallonboardings") ==
//         "1") {
//       return const RouteSettings(name: AppRoute.letsGetStarted);
//     }
//   }
// }
//------------------------
// مسار الملف المقترح: lib/core/middleware/auth_middleware.dart

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hireme/core/constant/routes.dart';
import 'package:hireme/core/services/services.dart';

class AuthMiddleware extends GetMiddleware {
  @override
  int? get priority => 1; // أولوية التنفيذ (يعمل أول واحد)

  MyServices myServices = Get.find();

  @override
  RouteSettings? redirect(String? route) {
    String? step = myServices.sharedPreferences.getString("step");
    String? role = myServices.sharedPreferences.getString("role");

    // الحالة 1: المستخدم مسجل دخوله مسبقاً (step == "2")
    if (step == "2") {
      if (role == "student") {
        return const RouteSettings(
            name: AppRoute.studentBottomNavigationBarPage);
      } else if (role == "company") {
        return const RouteSettings(
            name: AppRoute.companyBottomNavigationBarPage);
      } else if (role == "customer") {
        return const RouteSettings(
            name: AppRoute.customerBottomNavigationBarPage);
      }
    }

    // الحالة 2: مستخدم قديم أكمل الـ Onboarding ولكنه حالياً مسجل خروج (step == "1")
    if (step == "1") {
      return const RouteSettings(name: AppRoute.login);
    }

    // الحالة الافتراضية: مستخدم جديد كلياً يرى الـ Onboarding أو الـ Splash
    return null;
  }
}
