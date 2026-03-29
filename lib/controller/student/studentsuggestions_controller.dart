// import 'package:hireme/core/constant/routes.dart';
import 'package:hireme/core/constant/routes.dart';
import 'package:hireme/data/datasource/static/static.dart';
import 'package:get/get.dart';
import 'package:hireme/data/model/companiespostmodel.dart';
import 'package:hireme/data/model/companyprofilemodel.dart';
import 'package:hireme/data/model/customerprofilemodel.dart';
import 'package:hireme/view/screen/company/companyprofile.dart';
import 'package:hireme/view/screen/customer/customerprofile.dart';
import 'package:hireme/view/screen/student/sendrequesttocompany.dart';
import 'package:hireme/view/screen/student/studentsearch.dart';

abstract class StudentSuggestionsController extends GetxController {
  // goToPostDetails(CompanyPostModel companyPostModel);
  goToSendRequestToCompany(CompaniesPostModel companiesPostModel);
  goToCompanyProfile(String companyName);
  action(int index);
  change(int index);
  //---

  goToCustomerProfile(String customerName);
  // action(int index);
  // change(int index);
  goToSendRequestToCustomer();
}

class StudentSuggestionsControllerImp extends StudentSuggestionsController {
  int currentIndex = 0;

  // متغير للتحكم في حالة الفتح والإغلاق

  List<bool>? isExpanded = [];
  @override
  void onInit() {
    super.onInit();
    for (int i = 0; i < suggestedItems.length; i++) {
      isExpanded!.add(false);
    }
  }

  // @override
  // goToPostDetails(companyPostModel) {
  //   Get.to(() => CompanyPostDetails(companyPostModel: companyPostModel));
  // }

  @override
  action(index) {
    isExpanded![index] = !isExpanded![index];
    update();
  }

  @override
  change(index) {
    currentIndex = index;
    update();
  }

  @override
  goToSendRequestToCompany(companiesPostModel) {
    Get.to(() => SendRequestToCompany(companiesPostModel: companiesPostModel));
  }

  @override
  goToCompanyProfile(companyName) {
    // البحث في قائمة بروفايلات الشركات عن الشركة التي تملك نفس الاسم
    CompanyProfileModel? companyData = companyProfileList.firstWhere(
      (element) => element.name == companyName,
      orElse: () => companyProfileList[0], // قيمة افتراضية في حال عدم الوجود
    );

    Get.to(() => CompanyProfile(
          company: companyData,
          isMine: false, // لأن الزائر طالب وليس صاحب الشركة
        ));
  }
  //---------
  // int currentIndex = 0;

  // متغير للتحكم في حالة الفتح والإغلاق

  // List<bool>? isExpanded = [];
  // @override
  // void onInit() {
  //   super.onInit();
  //   for (int i = 0; i < freelancerPostsList.length; i++) {
  //     isExpanded!.add(false);
  //   }
  // }

  // @override
  // goToPostDetails(freelancerPostModel) {
  //   Get.to(
  //       () => FreelancerPostDetails(freelancerPostModel: freelancerPostModel));
  // }

  @override
  goToSendRequestToCustomer() {
    Get.toNamed(AppRoute.sendRequestToCustomer);
  }

  // @override
  // action(index) {
  //   isExpanded![index] = !isExpanded![index];
  //   update();
  // }

  // @override
  // change(index) {
  //   currentIndex = index;
  //   update();
  // }

  @override
  void goToCustomerProfile(customerName) {
    // البحث في قائمة بروفايلات الشركات عن الشركة التي تملك نفس الاسم
    CustomerProfileModel? customerData = customerProfileList.firstWhere(
      (element) => element.name == customerName,
      orElse: () => customerProfileList[0], // قيمة افتراضية في حال عدم الوجود
    );

    Get.to(() => CustomerProfile(
          customer: customerData,
          isMine: false, // لأن الزائر طالب وليس صاحب الشركة
        ));
  }
}
