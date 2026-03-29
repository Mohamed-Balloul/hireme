import 'package:get/get.dart';
import 'package:hireme/core/constant/routes.dart';
import 'package:hireme/data/datasource/static/static.dart';
import 'package:hireme/data/model/customerprofilemodel.dart';
import 'package:hireme/view/screen/customer/customerprofile.dart';

abstract class ShowOneFreelancerPostController extends GetxController {
  goToSendRequestToCustomer();
  goToCustomerProfile(String customerName);
}

class ShowOneFreelancerPostControllerImp
    extends ShowOneFreelancerPostController {
  @override
  void onInit() {
    super.onInit();
  }

  @override
  goToSendRequestToCustomer() {
    // Get.to(() => SendRequestToCompany(companyPostModel: companyPostModel));
    Get.toNamed(AppRoute.sendRequestToCustomer);
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
