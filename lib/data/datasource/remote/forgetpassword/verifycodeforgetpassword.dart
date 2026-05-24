import 'package:hireme/core/class/crud.dart';
import 'package:hireme/linkapi.dart';

class VerifyCodeForgetPasswordData {
  Crud crud;
  VerifyCodeForgetPasswordData(this.crud);
  postData(String email, String verifycode) async {
    var response = await crud.postData(AppLink.signUp, {
      "email": email,
      "verifycode": verifycode,
    });
    return response.fold((l) => l, (r) => r);
  }
}
