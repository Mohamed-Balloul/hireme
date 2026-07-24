import 'package:hireme/controller/customer/customerbottomnavigationbar/customerbottomnavigationbar_controller.dart';
import 'package:hireme/core/class/statusrequest.dart';
import 'package:hireme/core/constant/routes.dart';
import 'package:get/get.dart';
import 'package:hireme/core/functions/handlingdatacontroller.dart';
import 'package:hireme/core/services/services.dart';
import 'package:hireme/data/datasource/remote/auth/logout.dart';
import 'package:hireme/data/datasource/remote/customer/customer.dart';
import 'package:hireme/data/datasource/remote/student/notifications.dart';
import 'package:hireme/data/datasource/static/static.dart';
import 'package:hireme/data/model/customerprofilemodel.dart';
import 'package:hireme/data/model/studentprofilemodel.dart';
import 'package:hireme/view/screen/customer/savedstudents.dart';
import 'package:hireme/view/screen/customer/customerprofile.dart';
import 'package:hireme/view/screen/customer/customersearch.dart';
import 'package:hireme/view/screen/student/studentprofile.dart';

abstract class CustomerHomeController extends GetxController {
  goToCustomerPosts();
  goToFreelancerPosts();
  // goToProfile();
  goToCompanyPosts();
  goToIncomingRequests();
  goToComingRequests();
  goToStudentProfile();
  action(int index);
  onChange(int index);
  goToSearchPage();
  goToMyProfile();
  goToSavedStudents();
  deleteMyPost(int index);
  //--
  logout();
  getCustomerData();
  getAllStudents();
}

class CustomerHomeControllerImp extends CustomerHomeController {
  //--ربط
  StatusRequest statusRequest = StatusRequest.none;
  MyServices myServices = Get.find();
  LogoutData logoutData = LogoutData(Get.find());
  CustomerData customerData = CustomerData(Get.find());
  NotificationData notificationData = NotificationData(Get.find());
  CustomerProfileModel? customerModel;
  CustomerBottomNavigationBarrControllerImp controller =
      Get.find<CustomerBottomNavigationBarrControllerImp>();
  List<StudentProfileModel> allStudents = [];
  //--ربط
  @override
  goToCustomerPosts() {
    Get.toNamed(AppRoute.customerPostsDetails);
  }

  @override
  goToFreelancerPosts() {
    Get.toNamed(AppRoute.customerComingRequests);
  }

  // @override
  // goToProfile() {
  //   Get.toNamed(AppRoute.CompanyProfile);
  // }

  int currentIndex = 0;
  // متغير للتحكم في حالة الفتح والإغلاق

  List<bool>? isExpanded = [];
  @override
  goToCompanyPosts() {
    Get.toNamed(AppRoute.companyPostsDetails);
  }

  @override
  goToComingRequests() {
    Get.toNamed(AppRoute.companyComingRequests);
  }

  // @override
  // goToProfile() {
  //   Get.toNamed(AppRoute.CompanyProfile);
  // }

  @override
  void onInit() {
    getCustomerData();
    // getAllStudents();
    super.onInit();
    for (int i = 0; i < customerPosts.length; i++) {
      isExpanded!.add(false);
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  action(index) {
    isExpanded![index] = !isExpanded![index];
    update();
  }

  @override
  goToIncomingRequests() {
    Get.toNamed(AppRoute.incomingApplicationsToCustomerScreen);
  }

  @override
  onChange(index) {
    currentIndex = index;
    update();
  }

  @override
  goToStudentProfile() {
    Get.to(() => StudentProfile(
          student: bestStudents[currentIndex], // الطالب المختار من السلايدر
          isMine: false, // الزائر شركة، لذا لا تظهر أزرار التعديل
          isCompany: false,
        ));
  }

  @override
  goToSearchPage() {
    Get.to(() => CustomerSearch());
  }

  @override
  goToMyProfile() {
    Get.to(() => CustomerProfile(
          customer: customerProfileList[0],
          isMine: true,
        ));
  }

  @override
  goToSavedStudents() {
    Get.to(() => SavedStudents());
  }

  @override
  deleteMyPost(index) {
    customerPosts.removeAt(index);
    update();
  }

  //ربط
  @override
  getAllStudents() async {
    statusRequest = StatusRequest.loading;
    print("==============================-*-Controller $statusRequest ");
    update();

    String token = myServices.sharedPreferences.getString("token") ?? "";
    var response = await customerData.getAllStudents(token);

    print("==============================* Controller $response ");
    print("==============================--Controller $statusRequest ");

    statusRequest = handlingData(response);

    if (StatusRequest.success == statusRequest) {
      // Start backend
      if (response["message"] != null) {
        // تفريغ القائمة قبل الإضافة لتجنب التكرار عند تحديث الصفحة
        allStudents!.clear();

        // تحويل القائمة القادمة من السيرفر إلى موديلات وإضافتها
        List responseData = response['data'];
        allStudents!
            .addAll(responseData.map((e) => StudentProfileModel.fromJson(e)));
        // _updateSuggestions(); //
        // if (Get.isRegistered<CompaniesPostsControllerImp>()) {
        //   Get.find<CompaniesPostsControllerImp>().getAllCompaniesPosts();
        // }
      } else {
        // Get.defaultDialog(
        //   title: "warning",
        //   middleText: "email or password is wrong, try again",
        // );
        statusRequest = StatusRequest.failure;
      }
      // End
    } else {}
    update();
    print("************************** *-*-* $statusRequest");
  }

  @override
  getCustomerData() {
    customerModel = controller.customerModel;
    update();
  }

  @override
  logout() {}
}
