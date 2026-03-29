import 'package:hireme/core/constant/routes.dart';
import 'package:get/get.dart';
import 'package:hireme/data/datasource/static/static.dart';
import 'package:hireme/view/screen/company/companyprofile.dart';
import 'package:hireme/view/screen/company/companysearch.dart';
import 'package:hireme/view/screen/company/savedstudents.dart';
import 'package:hireme/view/screen/student/studentprofile.dart';

abstract class CompanyHomeController extends GetxController {
  goToCompanyPosts();
  goToStudentProfile();
  goToIncomingRequests();
  goToComingRequests();
  action(int index);
  onChange(int index);
  goToSearchPage();
  goToMyProfile();
  goToSavedStudents();
  deleteMyPost(int index);
}

class CompanyHomeControllerImp extends CompanyHomeController {
  int currentIndex = 0;
  // متغير للتحكم في حالة الفتح والإغلاق

  List<bool>? isExpanded = [];
  @override
  goToCompanyPosts() {
    Get.toNamed(AppRoute.companyPostsDetails);
  }

  @override
  goToComingRequests() {
    Get.toNamed(AppRoute.companyComingRequests);
  }

  // @override
  // goToProfile() {
  //   Get.toNamed(AppRoute.CompanyProfile);
  // }

  @override
  void onInit() {
    super.onInit();
    for (int i = 0; i < companyPosts.length; i++) {
      isExpanded!.add(false);
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  action(index) {
    isExpanded![index] = !isExpanded![index];
    update();
  }

  @override
  goToIncomingRequests() {
    Get.toNamed(AppRoute.incomingApplicationsScreen);
  }

  @override
  onChange(index) {
    currentIndex = index;
    update();
  }

  @override
  goToStudentProfile() {
    Get.to(() => StudentProfile(
          student: bestStudents[currentIndex], // الطالب المختار من السلايدر
          isMine: false, // الزائر شركة، لذا لا تظهر أزرار التعديل
          isCompany: true,
        ));
  }

  @override
  goToSearchPage() {
    Get.to(() => CompanySearch());
  }

  @override
  goToMyProfile() {
    Get.to(() => CompanyProfile(
          company: companyProfileList[0],
          isMine: true,
        ));
  }

  @override
  goToSavedStudents() {
    Get.to(() => SavedStudents());
  }

  @override
  deleteMyPost(index) {
    companyPosts.removeAt(index);
    printHi();
    update();
  }

  void printHi() {
    print("hi");
  }
}
