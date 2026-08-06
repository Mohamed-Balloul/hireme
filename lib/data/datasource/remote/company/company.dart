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

  //--
  getStudentDataById(String studentId, String token) async {
    var response = await crud.getData("${AppLink.student}/$studentId", {
      "Accept": "application/json",
      "Content-Type": "application/json",
      "Authorization": "Bearer $token"
    });
    return response.fold((l) => l, (r) => r);
  }
  //--

  getMyAds(String token) async {
    var response = await crud.getData(AppLink.myAds, {
      "Accept": "application/json",
      "Content-Type": "application/json",
      "Authorization": "Bearer $token"
    });
    return response.fold((l) => l, (r) => r);
  }

  getApplications(String token, String adId) async {
    var response = await crud.getData("${AppLink.ads}/$adId/applications", {
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

  //--
  editProfileInfo(
    String id,
    String token,
    Map data, // إرسال خريطة البيانات هنا
  ) async {
    var response = await crud.putData("${AppLink.company}/$id", data, {
      "Accept": "application/json",
      "Content-Type": "application/json",
      "Authorization": "Bearer $token"
    });
    return response.fold((l) => l, (r) => r);
  }

  //delete my ad
  deleteMyAd(String adId, String token) async {
    var response = await crud.deleteData("${AppLink.ads}/$adId", {
      "Accept": "application/json",
      "Content-Type": "application/json",
      "Authorization": "Bearer $token"
    });
    return response.fold((l) => l, (r) => r);
  }

  //accept application
  acceptApplication(String token, String applicationId) async {
    var response = await crud.postData(
        "${AppLink.server}/ad-applications/$applicationId/accept",
        {}, // إرسال خريطة البيانات هنا (فارغة في هذه الحالة)
        {
          "Accept": "application/json",
          "Content-Type": "application/json",
          "Authorization": "Bearer $token"
        });
    return response.fold((l) => l, (r) => r);
  }

  //reject application
  rejectApplication(String token, String applicationId) async {
    var response = await crud.postData(
        "${AppLink.server}/ad-applications/$applicationId/reject",
        {}, // إرسال خريطة البيانات هنا (فارغة في هذه الحالة)
        {
          "Accept": "application/json",
          "Content-Type": "application/json",
          "Authorization": "Bearer $token"
        });
    return response.fold((l) => l, (r) => r);
  }
}
