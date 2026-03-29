import 'package:get/get.dart';
import 'package:hireme/data/model/companypostmodel.dart';
import 'package:hireme/view/screen/student/sendrequesttocompany.dart';

abstract class CompanyPostDetailsController extends GetxController {
  goToSendRequestToCompany(CompanyPostModel companyPostModel);
}

class CompanyPostDetailsControllerImp extends CompanyPostDetailsController {
  @override
  void onInit() {
    super.onInit();
  }

  @override
  goToSendRequestToCompany(companyPostModel) {
    // Get.to(() => SendRequestToCompany(companyPostModel: companyPostModel));
  }
}
