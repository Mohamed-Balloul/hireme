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

  //delete my Project
  deleteMyProject(String projectId, String token) async {
    var response = await crud.deleteData("${AppLink.projects}/$projectId", {
      "Accept": "application/json",
      "Content-Type": "application/json",
      "Authorization": "Bearer $token"
    });
    return response.fold((l) => l, (r) => r);
  }

  // أضف هذه الدوال بداخل كلاس CustomerData:

  // 1. جلب المشاريع المستلمة التي يحق للعميل الاعتراض عليها
  // getReceivedProjects(String token) async {
  //   var response = await crud.getData(AppLink.receivedProjects, {
  //     "Accept": "application/json",
  //     "Content-Type": "application/json",
  //     "Authorization": "Bearer $token"
  //   });
  //   return response.fold((l) => l, (r) => r);
  // }

  // // 2. إرسال طلب الاعتراض للباك-إند
  // sendObjectionToAdmin(Map data, String token) async {
  //   var response = await crud.postData(AppLink.sendObjection, data, {
  //     "Accept": "application/json",
  //     "Content-Type": "application/json",
  //     "Authorization": "Bearer $token"
  //   });
  //   return response.fold((l) => l, (r) => r);
  // }
// قم بتحديث دالتي جلب وإرسال الاعتراض بداخل كلاس CustomerData:

  // 1. جلب المشاريع المستلمة المؤهلة لتقديم الاعتراض
  getReceivedProjects(String token) async {
    var response = await crud.getData(AppLink.eligibleObjections, {
      "Accept": "application/json",
      "Content-Type": "application/json",
      "Authorization": "Bearer $token"
    });
    return response.fold((l) => l, (r) => r);
  }

  // 2. إنشاء وإرسال الاعتراض للأدمن
  sendObjectionToAdmin(Map data, String token) async {
    var response = await crud.postData(AppLink.createObjection, data, {
      "Accept": "application/json",
      "Content-Type": "application/json",
      "Authorization": "Bearer $token"
    });
    return response.fold((l) => l, (r) => r);
  }

  //accept application
  acceptApplication(String token, String applicationId) async {
    var response = await crud.postData(
        "${AppLink.server}/project-applications/$applicationId/accept",
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
        "${AppLink.server}/project-applications/$applicationId/reject",
        {}, // إرسال خريطة البيانات هنا (فارغة في هذه الحالة)
        {
          "Accept": "application/json",
          "Content-Type": "application/json",
          "Authorization": "Bearer $token"
        });
    return response.fold((l) => l, (r) => r);
  }
}
