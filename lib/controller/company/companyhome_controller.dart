import 'package:hireme/controller/company/companybottomnavigationbar/companybottomnavigationbar_controller.dart';
import 'package:hireme/core/class/statusrequest.dart';
import 'package:hireme/core/constant/routes.dart';
import 'package:get/get.dart';
import 'package:hireme/core/functions/handlingdatacontroller.dart';
import 'package:hireme/core/services/services.dart';
import 'package:hireme/data/datasource/remote/auth/logout.dart';
import 'package:hireme/data/datasource/remote/company/company.dart';
import 'package:hireme/data/datasource/remote/student/notifications.dart';
import 'package:hireme/data/datasource/static/static.dart';
import 'package:hireme/data/model/companyprofilemodel.dart';
import 'package:hireme/data/model/studentprofilemodel.dart';
import 'package:hireme/view/screen/company/companyprofile.dart';
import 'package:hireme/view/screen/company/companysearch.dart';
import 'package:hireme/view/screen/company/savedstudents.dart';
import 'package:hireme/view/screen/student/studentprofile.dart';

abstract class CompanyHomeController extends GetxController {
  goToCompanyPosts();
  goToStudentProfile();
  goToIncomingRequests();
  goToComingRequests();
  action(int index);
  onChange(int index);
  goToSearchPage();
  goToMyProfile();
  goToSavedStudents();
  deleteMyPost(int index);
  //--
  logout();
  getCompanyData();
  getAllStudents();
}

class CompanyHomeControllerImp extends CompanyHomeController {
  //--ربط
  StatusRequest statusRequest = StatusRequest.none;
  MyServices myServices = Get.find();
  LogoutData logoutData = LogoutData(Get.find());
  CompanyData companyData = CompanyData(Get.find());
  NotificationData notificationData = NotificationData(Get.find());
  CompanyProfileModel? companyModel;
  CompanyBottomNavigationBarrControllerImp controller =
      Get.find<CompanyBottomNavigationBarrControllerImp>();
  List<StudentProfileModel> allStudents = [];
  //--ربط
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
    getCompanyData();
    getAllStudents();
    super.onInit();
    for (int i = 0; i < companyPosts.length; i++) {
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
    Get.toNamed(AppRoute.incomingApplicationsScreen);
  }

  @override
  onChange(index) {
    currentIndex = index;
    update();
  }

  @override
  goToStudentProfile() {
    Get.to(() => StudentProfile(
          // student: bestStudents[currentIndex], // الطالب المختار من السلايدر
          student: allStudents[currentIndex],
          isMine: false, // الزائر شركة، لذا لا تظهر أزرار التعديل
          isCompany: true,
        ));
  }

  @override
  goToSearchPage() {
    Get.to(() => CompanySearch());
  }

  @override
  goToMyProfile() {
    Get.to(() => CompanyProfile(
          company: companyProfileList[0],
          isMine: true,
        ));
  }

  @override
  goToSavedStudents() {
    Get.to(() => SavedStudents());
  }

  @override
  deleteMyPost(index) {
    companyPosts.removeAt(index);
    printHi();
    update();
  }

  void printHi() {
    print("hi");
  }

  @override
  getCompanyData() {
    companyModel = controller.companyModel;
    update();
  }

  //ربط
  @override
  logout() {
    Get.defaultDialog(
      title: "تأكيد تسجيل الخروج",
      middleText: "هل أنت متأكد أنك تريد تسجيل الخروج؟",
      textCancel: "إلغاء",
      textConfirm: "تأكيد",
      onConfirm: () async {
        // هنا يمكنك استدعاء دالة تسجيل الخروج من الـ Controller الخاص بك
        // مثلاً:
        // authController.logout();
        // Get.offAllNamed(AppRoute.login);
        statusRequest = StatusRequest.loading;
        print("==============================-*-Controller $statusRequest ");
        update();
        // 1. جلب التوكن من الـ SharedPreferences
        String token = myServices.sharedPreferences.getString("token") ?? "";
        String? deviceId =
            myServices.sharedPreferences.getString("device_record_id");

        // بعد ما ينجح الـ API call
        await Future.delayed(const Duration(seconds: 5)); // أضف هذا السطر
        // الخطوة 1: حذف الجهاز من السيرفر (Push Notification Cleanup)
        if (deviceId != null) {
          await notificationData.deleteDevice(token, deviceId);
        }
        // ثم انتقل لصفحة الـ
        // الخطوة 2: تسجيل الخروج الرسمي من الحساب

        var response = await logoutData.postData(token);

        print("==============================* Controller $response ");
        print("==============================--Controller $statusRequest ");

        statusRequest = handlingData(response);

        if (StatusRequest.success == statusRequest) {
          // Start backend
          // if (response['status'] == "success") {
          if (response['message'] != null) {
            // data.addAll(response['data']);
            // Get.offNamed(AppRoute.verfiyCodeSignUp,
            //     arguments: {"email": email.text});
            // 3. الخطوة الأهم: حذف البيانات محلياً
            myServices.sharedPreferences
                .clear(); // أو احذف فقط التوكن والـ step
            // 4. الانتقال لصفحة تسجيل الدخول ومنع الرجوع للخلف
            Get.offAllNamed(AppRoute.login);
          } else {
            Get.defaultDialog(
              title: "warning",
              middleText: "wrong logout",
            );
            statusRequest = StatusRequest.failure;
          }
          // End
        } else {
          // حتى لو فشل السيرفر، يفضل تسجيل الخروج محلياً لضمان تجربة مستخدم جيدة
          myServices.sharedPreferences.clear();
          Get.offAllNamed(AppRoute.login);
        }
        // update();
        print("************************** *-*-* $statusRequest");
      },
    );
  }

  @override
  getAllStudents() async {
    statusRequest = StatusRequest.loading;
    print("==============================-*-Controller $statusRequest ");
    update();

    String token = myServices.sharedPreferences.getString("token") ?? "";
    var response = await companyData.getAllStudents(token);

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
  //ربط
}
