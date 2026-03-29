import 'package:get/get.dart';
import 'package:hireme/data/model/freelancerpostmodel.dart';
import 'package:hireme/view/screen/student/freelancerpostdetails.dart';

abstract class FreelancerPostsController extends GetxController {
  goToPostDetails(FreelancerPostModel freelancerPostModel);
}

class FreelancerPostsControllerImp extends FreelancerPostsController {
  @override
  void onInit() {
    super.onInit();
  }

  @override
  goToPostDetails(freelancerPostModel) {
    Get.to(
        () => FreelancerPostDetails(freelancerPostModel: freelancerPostModel));
  }
}
