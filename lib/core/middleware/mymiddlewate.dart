import 'package:hireme/core/constant/routes.dart';
import 'package:hireme/core/services/services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyMiddleware extends GetMiddleware {
  @override
  int? get Priority => 1;
  MyServices myServices = Get.find();

  @override
  RouteSettings? redirect(String? route) {
    if (myServices.sharedPreferences.getString("ishesawallonboardings") ==
        "1") {
      return const RouteSettings(name: AppRoute.letsGetStarted);
    }
  }
}
