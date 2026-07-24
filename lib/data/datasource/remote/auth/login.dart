import 'package:hireme/core/class/crud.dart';
import 'package:hireme/linkapi.dart';

class LoginData {
  Crud crud;
  LoginData(this.crud);
  postData(
    String email,
    String password,
    String deviceId,
    String fcmToken,
    String platform,
    String appVersion,
  ) async {
    var response = await crud.postData(AppLink.login, {
      "email": email,
      "password": password,
      "device_id": deviceId, // يمكنك إرسال معرف الجهاز إذا كان مطلوبًا
      "fcm_token": fcmToken, // يمكنك إرسال رمز FCM إذا كان مطلوبًا
      "platform": platform, // أو "ios" حسب النظام المستخدم
      "app_version": appVersion, // يمكنك إرسال إصدار التطبيق إذا كان مطلوبًا
    });
    return response.fold((l) => l, (r) => r);
  }
}
