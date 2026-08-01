import 'package:hireme/core/class/crud.dart';
import 'package:hireme/linkapi.dart';

class CustomerData {
  Crud crud;
  CustomerData(this.crud);
  getCustomerData(String id, String token) async {
    var response = await crud.getData("${AppLink.customer}/$id", {
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

  getMyProjects(String token) async {
    var response = await crud.getData(AppLink.myProjects, {
      "Accept": "application/json",
      "Content-Type": "application/json",
      "Authorization": "Bearer $token"
    });
    return response.fold((l) => l, (r) => r);
  }

  getApplications(String token, String projectId) async {
    var response =
        await crud.getData("${AppLink.projects}/$projectId/applications", {
      "Accept": "application/json",
      "Content-Type": "application/json",
      "Authorization": "Bearer $token"
    });
    return response.fold((l) => l, (r) => r);
  }

  createCustomerPost(Map data, String token) async {
    var response = await crud.postData(
        AppLink.projects,
        data, // نمرر البيانات هنا
        {
          "Accept": "application/json",
          "Content-Type": "application/json",
          "Authorization": "Bearer $token"
        });
    return response.fold((l) => l, (r) => r);
  }

  //--
  editProfileInfo(
    String id,
    String token,
    Map data, // إرسال خريطة البيانات هنا
  ) async {
    var response = await crud.putData("${AppLink.customer}/$id", data, {
      "Accept": "application/json",
      "Content-Type": "application/json",
      "Authorization": "Bearer $token"
    });
    return response.fold((l) => l, (r) => r);
  }
}
