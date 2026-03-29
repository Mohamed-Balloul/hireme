import 'package:hireme/data/datasource/static/static.dart';
import 'package:hireme/data/model/companypostmodel.dart';
import 'package:get/get.dart';
import 'package:hireme/data/model/companyprofilemodel.dart';
import 'package:hireme/data/model/customerprofilemodel.dart';
import 'package:hireme/data/model/myrequesttocompanymodel.dart';
import 'package:hireme/data/model/myrequesttocustomermodel.dart';
import 'package:hireme/view/screen/company/companyprofile.dart';
import 'package:hireme/view/screen/customer/customerprofile.dart';
// import 'package:hireme/view/screen/student/companypostdetails.dart';

abstract class MyOrdersController extends GetxController {
  goToPostDetails(CompanyPostModel companyPostModel);
  goToCompanyProfile(String companyName);
  goToCustomerProfile(String customerName);
  deleteOrder(int id, bool isCompany);
  printHi();
}

class MyOrdersControllerImp extends MyOrdersController {
  // القائمة التي يتم عرضها
  // List<MyRequestToCompanyModel> get myAllRequestsToCompaniesList {
  //   /*if (selectedFilter == "الكل")*/ return myRequestsToCompaniesList;
  //   // return allNotifications.where((n) => n.type == selectedFilter).toList();
  // }

  // القائمة التي يتم عرضها
  // List<MyRequestToCustomerModel> get myAllRequestsToCustomersList {
  //   /*if (selectedFilter == "الكل")*/ return myRequestsToCustomersList;
  //   // return allNotifications.where((n) => n.type == selectedFilter).toList();
  // }

  @override
  void onInit() {
    super.onInit();
  }

  @override
  goToPostDetails(companyPostModel) {}
  @override
  void goToCompanyProfile(companyName) {
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

  @override
  printHi() {
    print("hi");
  }

  @override
  deleteOrder(id, isCompany) {
    // isCompany
    //     ? myRequestsToCompaniesList.removeWhere((element) => element. == id)
    //     : myRequestsToCustomersList.removeWhere((element) => element.id == id);
    isCompany
        ? myRequestsToCompaniesList.removeAt(id)
        : myRequestsToCustomersList.removeAt(id);
    printHi();
    update();
  }
}
