import 'package:hireme/core/constant/routes.dart';
import 'package:hireme/data/model/companypostmodel.dart';
import 'package:get/get.dart';
import 'package:hireme/view/screen/student/companypostdetails.dart';

abstract class CompanyComingRequestsController extends GetxController {
  // goToPostDetails(CompanyPostModel companyPostModel);
  goToPostDetails();
}

class CompanyComingRequestsControllerImp
    extends CompanyComingRequestsController {
  @override
  void onInit() {
    super.onInit();
  }

  @override
  goToPostDetails() {
    // Get.to(() => CompanyPostDetails(companyPostModel: companyPostModel));
    Get.toNamed(AppRoute.comingRequestsOnCompanyPost);
  }
}
