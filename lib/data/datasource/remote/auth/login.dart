import 'package:hireme/core/class/crud.dart';
import 'package:hireme/linkapi.dart';

class LoginData {
  Crud crud;
  LoginData(this.crud);
  postData(String email, String password) async {
    var response = await crud.postData(AppLink.signUp, {
      "email": email,
      "password": password,
    });
    return response.fold((l) => l, (r) => r);
  }
}
