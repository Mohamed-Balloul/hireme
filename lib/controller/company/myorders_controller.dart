import 'package:hireme/data/model/companypostmodel.dart';
import 'package:get/get.dart';
// import 'package:hireme/view/screen/student/companypostdetails.dart';

abstract class MyOrdersController extends GetxController {
  goToPostDetails(CompanyPostModel companyPostModel);
}

class MyOrdersControllerImp extends MyOrdersController {
  @override
  void onInit() {
    super.onInit();
  }

  @override
  goToPostDetails(companyPostModel) {
    // Get.to(() => CompanyPostDetails(companyPostModel: companyPostModel));
  }
}
