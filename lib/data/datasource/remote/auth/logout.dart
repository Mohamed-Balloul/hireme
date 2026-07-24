import 'package:hireme/core/class/crud.dart';
import 'package:hireme/linkapi.dart';

class LogoutData {
  Crud crud;
  LogoutData(this.crud);
  postData(String token) async {
    // نطلب التوكن هنا
    var response = await crud.postData(
        AppLink.logout,
        {}, // البدي فارغ حسب بوستمان
        {
          "Accept": "application/json",
          "Content-Type": "application/json",
          "Authorization": "Bearer $token" // هنا نضع التوكن
        });
    return response.fold((l) => l, (r) => r);
  }
}
