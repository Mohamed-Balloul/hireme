import 'package:hireme/core/constant/routes.dart';
import 'package:get/get.dart';
import 'package:hireme/data/datasource/static/static.dart';
import 'package:hireme/view/screen/customer/savedstudents.dart';
import 'package:hireme/view/screen/customer/customerprofile.dart';
import 'package:hireme/view/screen/customer/customersearch.dart';
import 'package:hireme/view/screen/student/studentprofile.dart';

abstract class CustomerHomeController extends GetxController {
  goToCustomerPosts();
  goToFreelancerPosts();
  // goToProfile();
  goToCompanyPosts();
  goToIncomingRequests();
  goToComingRequests();
  goToStudentProfile();
  action(int index);
  onChange(int index);
  goToSearchPage();
  goToMyProfile();
  goToSavedStudents();
  deleteMyPost(int index);
}

class CustomerHomeControllerImp extends CustomerHomeController {
  @override
  goToCustomerPosts() {
    Get.toNamed(AppRoute.customerPostsDetails);
  }

  @override
  goToFreelancerPosts() {
    Get.toNamed(AppRoute.customerComingRequests);
  }

  // @override
  // goToProfile() {
  //   Get.toNamed(AppRoute.CompanyProfile);
  // }

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
    for (int i = 0; i < customerPosts.length; i++) {
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
    Get.toNamed(AppRoute.incomingApplicationsToCustomerScreen);
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
          isCompany: false,
        ));
  }

  @override
  goToSearchPage() {
    Get.to(() => CustomerSearch());
  }

  @override
  goToMyProfile() {
    Get.to(() => CustomerProfile(
          customer: customerProfileList[0],
          isMine: true,
        ));
  }

  @override
  goToSavedStudents() {
    Get.to(() => SavedStudents());
  }

  @override
  deleteMyPost(index) {
    customerPosts.removeAt(index);
    update();
  }
}
