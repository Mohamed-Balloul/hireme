import 'package:get/get.dart';
import 'package:hireme/controller/customer/customerhome_controller.dart';
import 'package:hireme/core/class/statusrequest.dart';
import 'package:hireme/core/functions/handlingdatacontroller.dart';
import 'package:hireme/core/services/services.dart';
import 'package:hireme/data/datasource/remote/customer/customer.dart';
import 'package:hireme/data/datasource/static/static.dart';
import 'package:hireme/data/model/IncomingRequestsToCustomerModel.dart';
import 'package:hireme/data/model/studentprofilemodel.dart';
import 'package:hireme/view/screen/student/studentprofile.dart';

abstract class IncomingRequestsToCustomerController extends GetxController {
  goToPostDetails();
  goToStudentProfile(String studentName);
  //ربط
  getApplications(int projectId);
  // الدالة الجديدة هنا
  Future<void> refreshData();
}

class IncomingRequestsToCustomerControllerImp
    extends IncomingRequestsToCustomerController {
  CustomerHomeControllerImp controller = Get.find<CustomerHomeControllerImp>();
  //--ربط
  StatusRequest statusRequest = StatusRequest.none;
  MyServices myServices = Get.find();

  CustomerData customerData = CustomerData(Get.find());

  List<IncomingRequestsToCustomerModel> applications = [];
  //--ربط
  @override
  Future<void> refreshData() async {
    // await getCompanyData();
    // await getAllStudents();
    await getApplications(controller.selectedProject);
    update(); // تحديث واجهة المستخدم بعد تحديث البيانات
  }

  //ربط
  @override
  getApplications(projectId) async {
    statusRequest = StatusRequest.loading;
    print(
        "=========getApplications==========IncomingRequestsToCustomerController===========-*-Controller $statusRequest ");
    update();

    String token = myServices.sharedPreferences.getString("token") ?? "";

    print("-----projectID----*- *- *- * -* --$projectId");
    print("-----token----*- *- *- * -* --$token");
    var response =
        await customerData.getApplications(token, projectId.toString());

    print(
        "=========getApplications=======IncomingRequestsToCustomerController==============* Controller $response ");
    print(
        "========getApplications=========IncomingRequestsToCustomerController=============--Controller $statusRequest ");

    statusRequest = handlingData(response);

    if (StatusRequest.success == statusRequest) {
      // Start backend
      if (response["data"] != null) {
        // تفريغ القائمة قبل الإضافة لتجنب التكرار عند تحديث الصفحة
        applications.clear();

        // تحويل القائمة القادمة من السيرفر إلى موديلات وإضافتها
        List responseData = response['data'];
        applications.addAll(responseData
            .map((e) => IncomingRequestsToCustomerModel.fromJson(e)));
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
        "*******getApplications*********IncomingRequestsToCustomerController********** *-*-* $statusRequest");
  }

  @override
  void onInit() {
    getApplications(controller.selectedProject);
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
          isCompany: false,
        ));
  }
}
