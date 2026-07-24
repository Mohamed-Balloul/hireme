import 'package:hireme/core/class/crud.dart';
import 'package:hireme/linkapi.dart';

class StudentData {
  Crud crud;
  StudentData(this.crud);
  getStudentData(String id, String token) async {
    var response = await crud.getData("${AppLink.student}/$id", {
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

  //--my orders as a student
  //--My ads applications
  getAllMyAdApplications(
      // String id,
      String token) async {
    var response = await crud.getData(AppLink.myAdApplications, {
      "Accept": "application/json",
      "Content-Type": "application/json",
      "Authorization": "Bearer $token"
    });
    return response.fold((l) => l, (r) => r);
  }

  //--My Project applications
  getAllMyProjectApplications(
      // String id,
      String token) async {
    var response = await crud.getData(AppLink.myProjectApplications, {
      "Accept": "application/json",
      "Content-Type": "application/json",
      "Authorization": "Bearer $token"
    });
    return response.fold((l) => l, (r) => r);
  }

  //--delete ad applications
  deleteMyAdApplication(String id, String token) async {
    var response =
        await crud.deleteData("${AppLink.deleteMyAdApplication}/$id", {
      "Accept": "application/json",
      "Content-Type": "application/json",
      "Authorization": "Bearer $token"
    });
    return response.fold((l) => l, (r) => r);
  }

  //--delete Project applications
  deleteMyProjectApplication(String id, String token) async {
    var response =
        await crud.deleteData("${AppLink.deleteMyProjectApplication}/$id", {
      "Accept": "application/json",
      "Content-Type": "application/json",
      "Authorization": "Bearer $token"
    });
    return response.fold((l) => l, (r) => r);
  }

  //--Create And Send Applications to Company
  createAndSendApplicationToCompany(
    String token,
    int adId,
    int expectedSalarly,
    String githubLink,
  ) async {
    var response = await crud.postData(AppLink.allAdsApplications, {
      "ad_id": adId,
      "github_link": githubLink,
      "expected_salary": expectedSalarly,
      "resume": "resumes/my-cv.pdf"
    }, {
      "Accept": "application/json",
      "Content-Type": "application/json",
      "Authorization": "Bearer $token"
    });
    return response.fold((l) => l, (r) => r);
  }

  //--Create And Send Applications to Customer
  createAndSendApplicationToCustomer(
    String token,
    int adId,
    int expectedSalarly,
  ) async {
    var response = await crud.postData(AppLink.allProjectsApplications, {
      "ad_id": adId,
      "expected_salary": expectedSalarly,
      "resume": "resumes/my-cv.pdf"
    }, {
      "Accept": "application/json",
      "Content-Type": "application/json",
      "Authorization": "Bearer $token"
    });
    return response.fold((l) => l, (r) => r);
  }
}
