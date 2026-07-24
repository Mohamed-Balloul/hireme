import 'package:hireme/core/class/crud.dart';
import 'package:hireme/linkapi.dart';

class NotificationData {
  Crud crud;
  NotificationData(this.crud);

  // 1. جلب قائمة الإشعارات
  // جلب الإشعارات (للجميع: طالب، شركة، عميل)
  getNotifications(String token) async {
    var response = await crud.getData(AppLink.pushNotifications,
        {"Authorization": "Bearer $token", "Accept": "application/json"});
    return response.fold((l) => l, (r) => r);
  }

  // 2. تسجيل الجهاز (للتوكنات)

  // تسجيل الجهاز (يربط الهاتف بالحساب الحالي)
  registerDevice(String token, Map data) async {
    var response = await crud.postData(AppLink.deviceTokens, data,
        {"Authorization": "Bearer $token", "Accept": "application/json"});
    return response.fold((l) => l, (r) => r);
  }

  // 3. جعل الإشعار مقروء
  markAsRead(String token, String notificationId) async {
    // ملاحظة: ستحتاج لإضافة دالة patchData في كلاس Crud أو استخدام postData إذا كان السيرفر يدعم ذلك
    var response = await crud.patchData(
        "${AppLink.pushNotifications}/$notificationId/read",
        {},
        {"Authorization": "Bearer $token", "Accept": "application/json"});
    return response.fold((l) => l, (r) => r);
  }

  // 4. حذف الجهاز (عند تسجيل الخروج)
  // داخل NotificationData
  deleteDevice(String accessToken, String deviceRecordId) async {
    var response = await crud.deleteData(
        "${AppLink.deviceTokens}/$deviceRecordId",
        {"Authorization": "Bearer $accessToken", "Accept": "application/json"});
    return response.fold((l) => l, (r) => r);
  }

  // 5
  // جلب قائمة الأجهزة المسجلة (إذا أردت عرضها للمستخدم)
  listMyDevices(String token) async {
    var response = await crud.getData(AppLink.deviceTokens,
        {"Authorization": "Bearer $token", "Accept": "application/json"});
    return response.fold((l) => l, (r) => r);
  }
}
