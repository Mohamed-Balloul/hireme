import 'package:hireme/core/constant/routes.dart';
import 'package:get/get.dart';
import 'package:hireme/data/datasource/static/static.dart';
import 'package:hireme/data/model/companiespostmodel.dart';
import 'package:hireme/data/model/freelancerpostmodel.dart';
import 'package:hireme/view/screen/student/savedposts.dart';
import 'package:hireme/view/screen/student/showonecompanypost.dart';
import 'package:hireme/view/screen/student/showonefreelancerpost.dart';
import 'package:hireme/view/screen/student/studentprofile.dart';
import 'package:hireme/view/screen/student/studentsearch.dart';

abstract class StudentHomeController extends GetxController {
  goToCompaniesPosts();
  goToOneCompanyPost(CompaniesPostModel companiesPostModel);
  goToOneFreelancerPost(FreelancerPostModel freelancerPostModel);
  goToFreelancerPosts();
  goToMyProfile();
  goToCustomer();
  action(int index);
  change(int index);
  onChange(int index);
  goToSearchPage();
  goToSavedPosts();
}

class StudentHomeControllerImp extends StudentHomeController {
  int currentIndex = 0;
  int currentIndx = 0;
  // متغير للتحكم في حالة الفتح والإغلاق

  List<bool>? isExpanded = [];
  @override
  goToCompaniesPosts() {
    Get.toNamed(AppRoute.companiesPosts);
  }

  @override
  goToFreelancerPosts() {
    Get.toNamed(AppRoute.freelancerPosts);
  }

  @override
  goToMyProfile() {
    // Get.toNamed(AppRoute.companyBottomNavigationBarPage);
    Get.to(() => StudentProfile(
          student: studentProfileList[0],
          isCompany: false,
          isMine: true,
        ));
  }

  @override
  void onInit() {
    super.onInit();
    for (int i = 0; i < allcompaniesPosts.length; i++) {
      isExpanded!.add(false);
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  goToCustomer() {
    Get.toNamed(AppRoute.customerBottomNavigationBarPage);
  }

  @override
  action(int index) {
    isExpanded![index] = !isExpanded![index];
    update();
  }

  @override
  change(index) {
    currentIndex = index;
    update();
  }

  @override
  onChange(index) {
    currentIndx = index;
    update();
  }

  @override
  goToOneCompanyPost(companiesPostModel) {
    Get.to(() => ShowOneCompanyPost(companiesPostModel: companiesPostModel));
  }

  @override
  goToOneFreelancerPost(freelancerPostModel) {
    Get.to(
        () => ShowOneFreelancerPost(freelancerPostModel: freelancerPostModel));
  }

  @override
  goToSearchPage() {
    Get.to(() => StudentSearch());
  }

  @override
  goToSavedPosts() {
    Get.to(() => SavedPosts());
  }
}
