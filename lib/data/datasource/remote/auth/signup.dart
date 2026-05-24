import 'package:hireme/core/class/crud.dart';
import 'package:hireme/linkapi.dart';

class SignUpData {
  Crud crud;
  SignUpData(this.crud);
  postData(String username, String password, String email, String role) async {
    var response = await crud.postData(AppLink.signUp, {
      "username": username,
      "password": password,
      "email": email,
      "role": role,
    });
    return response.fold((l) => l, (r) => r);
  }
}
