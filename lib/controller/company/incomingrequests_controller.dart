import 'package:get/get.dart';
import 'package:hireme/controller/company/companyhome_controller.dart';
import 'package:hireme/core/class/statusrequest.dart';
import 'package:hireme/core/functions/handlingdatacontroller.dart';
import 'package:hireme/core/services/services.dart';
import 'package:hireme/data/datasource/remote/company/company.dart';
import 'package:hireme/data/datasource/static/static.dart';
import 'package:hireme/data/model/incomingrequeststocompanymodel.dart';
import 'package:hireme/data/model/studentprofilemodel.dart';
import 'package:hireme/view/screen/customer/customerprofile.dart';
import 'package:hireme/view/screen/student/studentprofile.dart';

abstract class IncomingRequestsController extends GetxController {
  goToPostDetails();
  // goToCompanyProfile(String companyName);
  goToStudentProfile(String studentName);
  //ربط
  getApplications(int adId);
  // الدالة الجديدة هنا
  Future<void> refreshData();
}

class IncomingRequestsControllerImp extends IncomingRequestsController {
  CompanyHomeControllerImp controller = Get.find<CompanyHomeControllerImp>();
  //--ربط
  StatusRequest statusRequest = StatusRequest.none;
  MyServices myServices = Get.find();

  CompanyData companyData = CompanyData(Get.find());

  List<IncomingRequestsToCompanyModel> applications = [];
  //--ربط
  @override
  Future<void> refreshData() async {
    // await getCompanyData();
    // await getAllStudents();
    await getApplications(controller.selectedAdId);
    update(); // تحديث واجهة المستخدم بعد تحديث البيانات
  }

  //ربط
  @override
  getApplications(adId) async {
    statusRequest = StatusRequest.loading;
    print(
        "=========getApplications==========IncomingRequestsToCompanyController===========-*-Controller $statusRequest ");
    update();

    String token = myServices.sharedPreferences.getString("token") ?? "";
    var response = await companyData.getApplications(token, adId.toString());

    print(
        "=========getApplications=======IncomingRequestsToCompanyController==============* Controller $response ");
    print(
        "========getApplications=========IncomingRequestsToCompanyController=============--Controller $statusRequest ");

    statusRequest = handlingData(response);

    if (StatusRequest.success == statusRequest) {
      // Start backend
      if (response["data"] != null) {
        // تفريغ القائمة قبل الإضافة لتجنب التكرار عند تحديث الصفحة
        applications.clear();

        // تحويل القائمة القادمة من السيرفر إلى موديلات وإضافتها
        List responseData = response['data'];
        applications.addAll(responseData
            .map((e) => IncomingRequestsToCompanyModel.fromJson(e)));
      } else {
        // Get.defaultDialog(
        //   title: "warning",
        //   middleText: "email or password is wrong, try again",
        // );
        statusRequest = StatusRequest.failure;
      }
      // End
    } else {}
    update();
    print(
        "*******getApplications*********IncomingRequestsToCompanyController********** *-*-* $statusRequest");
  }

  //ربط
  @override
  void onInit() {
    getApplications(controller.selectedAdId);
    super.onInit();
  }

  @override
  goToPostDetails() {
    // Get.to(() => CompanyPostDetails(companyPostModel: companyPostModel));
  }

  @override
  void goToStudentProfile(studentName) {
    // البحث في قائمة بروفايلات الشركات عن الشركة التي تملك نفس الاسم
    StudentProfileModel? studentData = studentProfileList.firstWhere(
      (element) => element.name == studentName,
      orElse: () => studentProfileList[0], // قيمة افتراضية في حال عدم الوجود
    );

    Get.to(() => StudentProfile(
          student: studentData,
          isMine: false, // لأن الزائر طالب وليس صاحب الشركة
          isCompany: true,
        ));
  }
}
