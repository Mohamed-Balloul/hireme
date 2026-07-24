import 'package:hireme/core/class/crud.dart';
import 'package:hireme/linkapi.dart';

class CompanyData {
  Crud crud;
  CompanyData(this.crud);
  getCompanyData(String id, String token) async {
    var response = await crud.getData("${AppLink.company}/$id", {
      "Accept": "application/json",
      "Content-Type": "application/json",
      "Authorization": "Bearer $token"
    });
    return response.fold((l) => l, (r) => r);
  }

  getAllStudents(String token) async {
    var response = await crud.getData(AppLink.allStudents, {
      "Accept": "application/json",
      "Content-Type": "application/json",
      "Authorization": "Bearer $token"
    });
    return response.fold((l) => l, (r) => r);
  }

  createCompanyPost(Map data, String token) async {
    var response = await crud.postData(
        AppLink.ads,
        data, // نمرر البيانات هنا
        {
          "Accept": "application/json",
          "Content-Type": "application/json",
          "Authorization": "Bearer $token"
        });
    return response.fold((l) => l, (r) => r);
  }

  getAllCompaniesAds(
      // String id,
      /*String token*/
      ) async {
    var response = await crud.getData(AppLink.allCompaniesAds, {
      // "Accept": "application/json",
      // "Content-Type": "application/json",
      // "Authorization": "Bearer $token"
    });
    return response.fold((l) => l, (r) => r);
  }

  getAllCustomersAds(
      // String id,
      /*String token*/
      ) async {
    var response = await crud.getData(AppLink.allCustomersAds, {
      // "Accept": "application/json",
      // "Content-Type": "application/json",
      // "Authorization": "Bearer $token"
    });
    return response.fold((l) => l, (r) => r);
  }
}
