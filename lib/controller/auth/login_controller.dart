import 'package:hireme/controller/notifications/notifications_controller.dart';
import 'package:hireme/core/class/statusrequest.dart';
import 'package:hireme/core/constant/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hireme/core/functions/handlingdatacontroller.dart';
import 'package:hireme/core/services/services.dart';
import 'package:hireme/data/datasource/remote/auth/login.dart';
import 'package:hireme/data/datasource/remote/auth/signup.dart';
import 'package:hireme/view/widget/auth/mockauthservice.dart';
import 'package:hireme/view/widget/auth/usertype.dart';

abstract class LoginController extends GetxController {
  login();
  goToSignUp();
  goToForgetPassword();
  //
  showHidePassword();
}

class LoginControllerImp extends LoginController {
  GlobalKey<FormState> formState = GlobalKey<FormState>();

  late TextEditingController email;
  late TextEditingController password;

  bool isPasswordHidden = true;

  //ربط
  MyServices myServices = Get.find();
  StatusRequest statusRequest = StatusRequest.none;

  LoginData loginData = LoginData(Get.find());

  List data = [];
  //ربط

  @override
  goToSignUp() {
    Get.offNamed(AppRoute.signUp);
  }

  @override
  goToForgetPassword() {
    Get.offNamed(AppRoute.forgetPassword);
  }

  @override
  login() async {
    var formdata = formState.currentState;
    if (formdata!.validate()) {
      //--
      statusRequest = StatusRequest.loading;
      //--
      // جلب البيانات الحقيقية للجهاز والتوكن
      String fcmToken =
          myServices.sharedPreferences.getString("fcm_token") ?? "no_token";
      String deviceId = myServices.sharedPreferences.getString("device_id") ??
          "unknown_device";
      String platform = GetPlatform.isAndroid
          ? "android"
          : (GetPlatform.isIOS ? "ios" : "unknown");
      String appVersion =
          "1.0.0"; // يمكنك جلبها ديناميكياً عبر حزمة PackageInfo إن أردت

      //--
      print("==============================-*-Controller $statusRequest ");
      update();

      var response = await loginData.postData(
        email.text,
        password.text,
        deviceId,
        fcmToken,
        platform,
        appVersion,
      );

      print("==============================* Controller $response ");
      print("==============================--Controller $statusRequest ");

      statusRequest = handlingData(response);

      if (StatusRequest.success == statusRequest) {
        // Start backend
        if (response["message"] == "Logged in successfully.") {
          print(
              " ++++++++++++++++ message +++++++++++++ ${response["message"]}");
          // data.addAll(response['data']);
          //*

          var responseData = response['data'];
          String userType = responseData['user']['type'];
          String token = responseData['access_token'];
          print("--login--token-$token");
          String userId = responseData['user']['id'].toString(); // جلب الـ ID
          print("--login--user_id-$userId");
          // 1. تخزين البيانات أولاً (مهم جداً الترتيب)
          myServices.sharedPreferences.setString("step", "2");
          myServices.sharedPreferences.setString("token", token);
          myServices.sharedPreferences.setString(
              "user_id", userId); // تخزين الـ ID ليستخدم كـ device_id
          myServices.sharedPreferences
              .setString("username", responseData['user']['username']);
          myServices.sharedPreferences.setString("role", userType);

          // 2. الآن استدعاء دالة الإشعارات (بدون _)
          // الدالة الآن ستجد الـ token والـ id جاهزين في الـ Shared Preferences
          //*
          Get.find<NotificationsControllerImp>().getAndSaveToken();
          // 1. استدعاء الخدمة الوهمية
          UserType role = await MockAuthService().login(userType);

          // 2. التوجيه بناءً على النتيجة
          switch (role) {
            case UserType.student:
              Get.offNamed(AppRoute.studentBottomNavigationBarPage);
              break;
            case UserType.company:
              Get.offNamed(AppRoute.companyBottomNavigationBarPage);
              break;
            case UserType.customer:
              Get.offNamed(AppRoute.customerBottomNavigationBarPage);
              break;
            default:
              // إظهار رسالة خطأ
              break;
          }
        } else {
          Get.defaultDialog(
            title: "خطأ",
            middleText: "البريد الإلكتروني أو كلمة المرور خاطئة!",
          );
          statusRequest = StatusRequest.none;
        }
        // End
      } else {
        // في حال فشل الاتصال بالإنترنت أو خطأ السيرفر العام
        Get.defaultDialog(
          title: "خطأ في الاتصال",
          middleText:
              "تعذر الاتصال بالخادم، يرجى التحقق من الإنترنت والمحاولة مجدداً.",
        );
        statusRequest = StatusRequest.none;
      }
      update();
      print("************************** *-*-* $statusRequest");
      //--
    } else {
      print("Not Valid");
    }
  }

  @override
  void onInit() {
    email = TextEditingController();
    password = TextEditingController();
    super.onInit();
  }

  @override
  void dispose() {
    email.dispose();
    password.dispose();
    super.dispose();
  }

  @override
  showHidePassword() {
    isPasswordHidden = isPasswordHidden == false ? true : false;
    update();
  }
}
