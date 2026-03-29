import 'package:get/get.dart';
import 'package:hireme/data/datasource/static/static.dart';
import 'package:hireme/data/model/companyprofilemodel.dart';
import 'package:hireme/data/model/customerprofilemodel.dart';
import 'package:hireme/data/model/studentnotificationmodel.dart';
import 'package:hireme/view/screen/company/companyprofile.dart';
import 'package:hireme/view/screen/customer/customerprofile.dart';

abstract class StudentNotificationsController extends GetxController {
  changeFilter(String newFilter);
  deleteNotification(int id);
  goToCompanyProfile(String companyName);
  goToCustomerProfile(String customerName);
}

class StudentNotificationsControllerImp extends StudentNotificationsController {
  // النوع المحدد حالياً للفلترة
  String selectedFilter = "الكل";

  // قائمة الفلاتر
  List<String> filters = ["الكل", "أدمن", "شركات", "عملاء"];

  // القائمة التي يتم عرضها بعد الفلترة
  List<StudentNotificationModel> get filteredNotifications {
    if (selectedFilter == "الكل") return allNotifications;
    return allNotifications.where((n) => n.type == selectedFilter).toList();
  }

  @override
  void changeFilter(newFilter) {
    selectedFilter = newFilter;
    update();
  }

  @override
  void deleteNotification(id) {
    allNotifications.removeWhere((element) => element.id == id);
    update();
  }

  @override
  void onInit() {
    super.onInit();
  }

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
}
