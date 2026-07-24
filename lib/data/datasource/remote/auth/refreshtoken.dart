import 'package:hireme/core/class/crud.dart';
import 'package:hireme/linkapi.dart';

class RefreshTokenData {
  Crud crud;
  RefreshTokenData(this.crud);
  postData(String refreshToken) async {
    var response = await crud.postData(AppLink.refreshToken, {});
    return response.fold((l) => l, (r) => r);
  }
}
