import 'package:hireme/core/class/crud.dart';
import 'package:hireme/linkapi.dart';

class VerifyCodeForgetPasswordData {
  Crud crud;
  VerifyCodeForgetPasswordData(this.crud);
  postData(
    String email,
    String verifycode,
    String fcmToken,
    String deviceId,
    String platform,
    String appVersion,
  ) async {
    var response = await crud.postData(AppLink.verifyOtp, {
      "email": email,
      "code": verifycode,
      "type": "password_reset",
      "device_id": deviceId, // يمكنك إرسال معرف الجهاز إذا كان مطلوبًا
      "fcm_token": fcmToken, // يمكنك إرسال رمز FCM إذا كان مطلوبًا
      "platform": platform, // أو "ios" حسب النظام المستخدم
      "app_version": appVersion, // يمكنك إرسال إصدار التطبيق إذا كان مطلوبًا
    });
    return response.fold((l) => l, (r) => r);
  }
}
