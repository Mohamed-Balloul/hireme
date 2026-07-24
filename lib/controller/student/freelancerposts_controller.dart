import 'package:get/get.dart';
import 'package:hireme/controller/student/studenthome_controller.dart';
// import 'package:hireme/core/class/statusrequest.dart';
import 'package:hireme/core/constant/routes.dart';
// import 'package:hireme/core/services/services.dart';
// import 'package:hireme/data/datasource/remote/student/student.dart';
import 'package:hireme/data/datasource/static/static.dart';
import 'package:hireme/data/model/customerprofilemodel.dart';
import 'package:hireme/data/model/freelancerpostmodel.dart';
import 'package:hireme/view/screen/customer/customerprofile.dart';
import 'package:hireme/view/screen/student/freelancerpostdetails.dart';

abstract class FreelancerPostsController extends GetxController {
  goToPostDetails(FreelancerPostModel freelancerPostModel);
  goToCustomerProfile(String customerName);
  action(int index);
  change(int index);
  goToSendRequestToCustomer();
  //--
  getAllCustomersPosts();
}

class FreelancerPostsControllerImp extends FreelancerPostsController {
  StudentHomeControllerImp homeController =
      Get.find<StudentHomeControllerImp>();
  int currentIndex = 0;
  //--
  List<FreelancerPostModel> allCustomersPosts = [];

  // متغير للتحكم في حالة الفتح والإغلاق

  List<bool>? isExpanded = [];

  @override
  void onInit() {
    getAllCustomersPosts();
    super.onInit();
    // for (int i = 0; i < freelancerPostsList.length; i++) {
    //   isExpanded!.add(false);
    // }
  }

  @override
  goToPostDetails(freelancerPostModel) {
    Get.to(
        () => FreelancerPostDetails(freelancerPostModel: freelancerPostModel));
  }

  @override
  goToSendRequestToCustomer() {
    Get.toNamed(AppRoute.sendRequestToCustomer);
  }

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
  getAllCustomersPosts() {
    // جلب البيانات الحقيقية من الهوم كنترولر
    allCustomersPosts = homeController.allCustomersAds;

    // تهيئة قائمة "عرض المزيد" بناءً على عدد البيانات الحقيقية المجلوبة
    isExpanded = List.generate(allCustomersPosts.length, (index) => false);

    update(); // تحديث الواجهة
  }
}
