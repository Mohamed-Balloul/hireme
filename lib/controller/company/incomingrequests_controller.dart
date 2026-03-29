import 'package:get/get.dart';
import 'package:hireme/data/datasource/static/static.dart';
import 'package:hireme/data/model/studentprofilemodel.dart';
import 'package:hireme/view/screen/customer/customerprofile.dart';
import 'package:hireme/view/screen/student/studentprofile.dart';

abstract class IncomingRequestsController extends GetxController {
  goToPostDetails();
  // goToCompanyProfile(String companyName);
  goToStudentProfile(String studentName);
}

class IncomingRequestsControllerImp extends IncomingRequestsController {
  @override
  void onInit() {
    super.onInit();
  }

  @override
  goToPostDetails() {
    // Get.to(() => CompanyPostDetails(companyPostModel: companyPostModel));
  }

  // @override
  // void goToCompanyProfile(companyName) {
  //   // البحث في قائمة بروفايلات الشركات عن الشركة التي تملك نفس الاسم
  //   CompanyProfileModel? companyData = companyProfileList.firstWhere(
  //     (element) => element.name == companyName,
  //     orElse: () => companyProfileList[0], // قيمة افتراضية في حال عدم الوجود
  //   );

  //   Get.to(() => CompanyProfile(
  //         company: companyData,
  //         isMine: false, // لأن الزائر طالب وليس صاحب الشركة
  //       ));
  // }

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
