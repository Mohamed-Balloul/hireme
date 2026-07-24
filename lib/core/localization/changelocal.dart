import 'package:hireme/core/constant/apptheme.dart';
import 'package:hireme/core/services/services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';

class LocaleController extends GetxController {
  Locale? language;
  MyServices myServices = Get.find();
  ThemeData appTheme = themeEnglish;

  changeLang(String langcode) {
    Locale locale = Locale(langcode);
    myServices.sharedPreferences.setString("lang", langcode);
    appTheme = langcode == "ar" ? themeArabic : themeEnglish;
    Get.changeTheme(appTheme);
    Get.updateLocale(locale);
  }

  // getToken() async {
  //   String? token = await FirebaseMessaging.instance.getToken();
  //   print(
  //       "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ =*=*= Firebase Token =*=*= : $token");
  // }

  // myRequestForNotificationsPermission() async {
  //   FirebaseMessaging messaging = FirebaseMessaging.instance;

  //   NotificationSettings settings = await messaging.requestPermission(
  //     alert: true,
  //     announcement: false,
  //     badge: true,
  //     carPlay: false,
  //     criticalAlert: false,
  //     provisional: false,
  //     sound: true,
  //   );

  // print('حالة صلاحية الإشعارات: ${settings.authorizationStatus}');
  // }

  @override
  void onInit() {
    // String? sharedPrefLang = myServices.sharedPreferences.getString("lang");
    language = const Locale("ar");
    appTheme = themeArabic;
    // if (sharedPrefLang == "ar") {
    //   language = const Locale("ar");
    //   appTheme = themeArabic;
    // } else if (sharedPrefLang == "en") {
    //   language = const Locale("en");
    //   appTheme = themeEnglish;
    // } else {
    //   language = Locale(Get.deviceLocale!.languageCode);
    //   appTheme = themeEnglish;
    // }
    // TODO: implement initState
    // FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    //   if (message.notification != null) {
    //     print(
    //         " ====== on Message app is foreground ========= Title: ${message.notification!.title}");
    //     print(
    //         " ====== on Message app is foreground ========= Body: ${message.notification!.body}");

    //     Get.snackbar(
    //       message.notification!.title ?? "تنبيه جديد", // عنوان الإشعار
    //       message.notification!.body ?? "", // نص الإشعار
    //       snackPosition: SnackPosition.BOTTOM, // مكان الظهور (اختياري)
    //     );
    //   }
    // });
    // myRequestForNotificationsPermission();
    // getToken();
    super.onInit();
  }
}
