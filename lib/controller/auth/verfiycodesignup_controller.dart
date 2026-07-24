import 'package:hireme/core/class/statusrequest.dart';
import 'package:hireme/core/constant/routes.dart';
import 'package:get/get.dart';
import 'package:hireme/core/functions/handlingdatacontroller.dart';
import 'package:hireme/core/services/services.dart';
import 'package:hireme/data/datasource/remote/auth/verifycodesignup.dart';

abstract class VerfiyCodeSignUpController extends GetxController {
  goToSuccessSignUp(String verifyCode);
}

class VerfiyCodeSignUpControllerImp extends VerfiyCodeSignUpController {
  VerifyCodeSignUpData verifyCodeSignUpData = VerifyCodeSignUpData(Get.find());
  MyServices myServices =
      Get.find(); // استدعاء الخدمات لقراءة البيانات المحفوظة

  String? email;
  //ربط
  StatusRequest statusRequest = StatusRequest.none;

  List data = [];
  //ربط

  @override
  goToSuccessSignUp(verifyCode) async {
    statusRequest = StatusRequest.loading;
    update();
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

    var response = await verifyCodeSignUpData.postData(
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
      if (response['message'] == "OTP verified successfully.") {
        Get.offNamed(AppRoute.successSignUp);
      } else {
        Get.defaultDialog(
          title: "خطأ",
          middleText: "الكود خاطىء أو منتهي الصلاحية، يرجى المحاولة مرة أخرى.",
        );
        statusRequest = StatusRequest.none;
      }
    } else {
      // في حال فشل الاتصال بالسيرفر أو انقطاع الإنترنت
      Get.defaultDialog(
        title: "خطأ",
        middleText:
            "حدث خطأ أثناء الاتصال بالخادم،تحقق من اتصالك وأعد المحاولة.",
      );
      statusRequest = StatusRequest.none;
    }
    update(); // استدعاء التحديث هنا مهم جداً لإخفاء شاشة التحميل وإعادة عرض النموذج

    print("************************** *-*-* $statusRequest");
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
