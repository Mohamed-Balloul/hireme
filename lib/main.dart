import 'dart:io';
import 'package:flutter_localizations/flutter_localizations.dart'; // استيراد المكتبة
import 'package:hireme/bindings/initialbinding.dart';
import 'package:hireme/core/localization/changelocal.dart';
import 'package:hireme/core/localization/translation.dart';
import 'package:hireme/core/services/services.dart';
import 'package:hireme/overridehttp.dart';
import 'package:hireme/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initialServices();
  HttpOverrides.global = MyHttpOverrides();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    LocaleController controller = Get.put(LocaleController());
    return GetMaterialApp(
      initialBinding: InitialBinding(),
      locale: controller.language,
      //
      supportedLocales: const [
        Locale('ar', 'AE'), // العربية
        Locale('en', 'US'), // الإنجليزية
      ],
      localizationsDelegates: const [
        // هؤلاء هم المناديب المسؤولون عن حل مشكلتك:
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      // ...
      //
      theme: controller.appTheme,
      translations: MyTranslation(),
      debugShowCheckedModeBanner: false,
      getPages: routes,
    );
  }
}
