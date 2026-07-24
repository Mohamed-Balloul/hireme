import 'package:hireme/core/class/statusrequest.dart';
import 'package:hireme/core/constant/routes.dart';
import 'package:get/get.dart';
import 'package:hireme/core/functions/handlingdatacontroller.dart';
import 'package:hireme/core/services/services.dart';
import 'package:hireme/data/datasource/remote/forgetpassword/verifycodeforgetpassword.dart';

abstract class VerfiyCodeController extends GetxController {
  goToResetPassword(String verifyCode);
}

class VerfiyCodeControllerImp extends VerfiyCodeController {
  String? email;

  //ربط
  StatusRequest statusRequest = StatusRequest.none;
  VerifyCodeForgetPasswordData verifyCodeForgetPasswordData =
      VerifyCodeForgetPasswordData(Get.find());
  MyServices myServices =
      Get.find(); // استدعاء الخدمات لقراءة البيانات المحفوظة
  List data = [];
  //ربط

  @override
  goToResetPassword(verifyCode) async {
    // Get.offNamed(AppRoute.resetPassword);
    statusRequest = StatusRequest.loading;
    update();
    // بعد ما ينجح الـ API call
    // جلب البيانات الحقيقية للجهاز والتوكن
    String fcmToken =
        myServices.sharedPreferences.getString("fcm_token") ?? "no_token";
    String deviceId =
        myServices.sharedPreferences.getString("device_id") ?? "unknown_device";
    String platform = GetPlatform.isAndroid
        ? "android"
        : (GetPlatform.isIOS ? "ios" : "unknown");
    String appVersion =
        "1.0.0"; // يمكنك جلبها ديناميكياً عبر حزمة PackageInfo إن أردت
// ثم انتقل لصفحة الـ verify
    var response = await verifyCodeForgetPasswordData.postData(
      email!,
      verifyCode,
      fcmToken,
      deviceId,
      platform,
      appVersion,
    );

    print("==============================* Controller $response ");

    statusRequest = handlingData(response);

    if (StatusRequest.success == statusRequest) {
      // Start backend
      // String resetToken =
      //     response['token']; // افترضنا أن الباك اند يعيد التوكن بهذا الاسم
      if (response['message'] == "OTP verified successfully.") {
        Get.offNamed(AppRoute.resetPassword, arguments: {
          "email": email,
          // 'token': resetToken // تمرير التوكن للواجهة التالية
        }); // تأكد من إرسال التوكن مع البريد الإلكتروني
      } else {
        Get.defaultDialog(
          title: "خطأ",
          middleText:
              "رمز التحقق خاطئ أو منتهي الصلاحية، يرجى المحاولة مرة أخرى.",
        );
        statusRequest = StatusRequest.none;
      }
      // End
    } else {
      // في حال فشل الاتصال بالسيرفر أو انقطاع الإنترنت
      Get.defaultDialog(
        title: "خطأ",
        middleText:
            "حدث خطأ أثناء الاتصال بالخادم،تحقق من اتصالك وأعد المحاولة.",
      );
      statusRequest = StatusRequest.none;
    }
    update();
  }

  @override
  void onInit() {
    email = Get.arguments['email'];
    super.onInit();
  }

  @override
  void dispose() {
    super.dispose();
  }
}
