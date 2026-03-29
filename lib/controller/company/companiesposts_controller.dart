import 'package:hireme/data/model/companypostmodel.dart';
import 'package:get/get.dart';
import 'package:hireme/view/screen/student/companypostdetails.dart';

abstract class CompanyPostsController extends GetxController {
  goToPostDetails(CompanyPostModel companyPostModel);
}

class CompanyPostsControllerImp extends CompanyPostsController {
  @override
  void onInit() {
    super.onInit();
  }

  @override
  goToPostDetails(companyPostModel) {
    Get.to(() => CompanyPostDetails(companyPostModel: companyPostModel));
  }
}
