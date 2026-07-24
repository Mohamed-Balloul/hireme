import 'package:hireme/core/class/crud.dart';
import 'package:hireme/linkapi.dart';

class ResetPasswordData {
  Crud crud;
  ResetPasswordData(this.crud);
  postData(String email, String password) async {
    var response = await crud.postData(AppLink.resetPassword, {
      "email": email,
      "password": password,
      // "token": token, // هذا هو العنصر المفقود
      "password_confirmation": password, // تأكيد كلمة المرور
    });
    return response.fold((l) => l, (r) => r);
  }
}
