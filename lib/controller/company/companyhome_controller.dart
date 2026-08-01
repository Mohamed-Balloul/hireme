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
import 'package:hireme/data/model/companiespostmodel.dart';
import 'package:hireme/data/model/companyprofilemodel.dart';
import 'package:hireme/data/model/studentprofilemodel.dart';
import 'package:hireme/view/screen/company/companyprofile.dart';
import 'package:hireme/view/screen/company/companysearch.dart';
import 'package:hireme/view/screen/company/savedstudents.dart';
import 'package:hireme/view/screen/student/studentprofile.dart';

abstract class CompanyHomeController extends GetxController {
  goToCompanyPosts();
  goToStudentProfile();
  goToIncomingRequests(int adId);
  // goToComingRequests();
  action(int index);
  onChange(int index);
  goToSearchPage();
  goToMyProfile();
  goToSavedStudents();
  deleteMyPost(int index);
  //--ربط
  logout();
  getCompanyData();
  getAllStudents();
  //--
  getMyAds();
  // الدالة الجديدة هنا
  Future<void> refreshData();
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
  List<CompaniesPostModel> myAds = [];
  int selectedAdId =
      0; // لتحديد الإعلان المختار عند الانتقال لصفحة الطلبات الواردة
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

  @override
  Future<void> refreshData() async {
    // await getCompanyData();
    // await getAllStudents();
    await getMyAds();
    update(); // تحديث واجهة المستخدم بعد تحديث البيانات
  }

  // @override
  // goToProfile() {
  //   Get.toNamed(AppRoute.CompanyProfile);
  // }

  @override
  void onInit() {
    getCompanyData();
    getAllStudents();
    getMyAds();
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
  goToIncomingRequests(adId) {
    selectedAdId = adId;
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
      // confirmTextColor: Colors.white,
      // buttonColor: const Color(0xFF1DBF53), // لون الزر الأخضر المعتمد لديك
      onConfirm: () async {
        // 1. إغلاق دايلوج التأكيد فوراً لتجنب النقر المتعدد وإظهار شاشة التحميل بوضوح
        Get.back();

        statusRequest = StatusRequest.loading;
        print(
            "=====logout========CompanyHomeControllerImp=================-*-Controller $statusRequest ");
        update();

        // 2. جلب البيانات المحلية
        String token = myServices.sharedPreferences.getString("token") ?? "";
        String? deviceId =
            myServices.sharedPreferences.getString("device_record_id");

        // 3. الخطوة الأولى: حذف جهاز الإشعارات بشكل محمي تماماً
        if (deviceId != null) {
          try {
            await notificationData.deleteDevice(token, deviceId);
          } catch (e) {
            print("--- خطأ غير مؤثر في حذف توكن الإشعارات: $e");
          }
        }

        // 4. الخطوة الثانية: تسجيل الخروج الرسمي من السيرفر
        var response = await logoutData.postData(token);

        print(
            "===logout=======CompanyHomeControllerImp====================* Response: $response ");
        statusRequest = handlingData(response);

        if (StatusRequest.success == statusRequest) {
          if (response['message'] == "Logged out successfully.") {
            // نجاح كامل: مسح البيانات محلياً والتحويل لصفحة تسجيل الدخول
            myServices.sharedPreferences.clear();
            Get.offAllNamed(AppRoute.login);
          } else {
            // رد غير متوقع من السيرفر: نسجل الخروج محلياً كإجراء دفاعي آمن
            print(
                "رد غير متوقع من السيرفر: نسجل الخروج محلياً كإجراء دفاعي آمن");
            // myServices.sharedPreferences.clear();
            // Get.offAllNamed(AppRoute.login);
          }
        } else {
          // في حال فشل السيرفر أو انقطاع الإنترنت، نقوم بالتنظيف محلياً لضمان خروج العميل وتفادي احتجازه
          print("--- فشل الاتصال بالسيرفر، يتم تسجيل الخروج محلياً الآن.");
          // myServices.sharedPreferences.clear();
          // Get.offAllNamed(AppRoute.login);
        }

        statusRequest = StatusRequest.none;
        update();
        print(
            "****logout******CompanyHomeControllerImp****************** *-*-* $statusRequest");
      },
    );
  }

  @override
  getAllStudents() async {
    statusRequest = StatusRequest.loading;
    print(
        "=========getAllStudents==========CompanyHomeControllerImp===========-*-Controller $statusRequest ");
    update();

    String token = myServices.sharedPreferences.getString("token") ?? "";
    var response = await companyData.getAllStudents(token);

    print(
        "=========getAllStudents=======CompanyHomeControllerImp==============* Controller $response ");
    print(
        "========getAllStudents=========CompanyHomeControllerImp=============--Controller $statusRequest ");

    statusRequest = handlingData(response);

    if (StatusRequest.success == statusRequest) {
      // Start backend
      if (response["data"] != null) {
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
    print(
        "*******getAllStudents*********CompanyHomeControllerImp********** *-*-* $statusRequest");
  }

  //ربط
  @override
  getMyAds() async {
    statusRequest = StatusRequest.loading;
    print(
        "=========getMyAds==========CompanyHomeControllerImp===========-*-Controller $statusRequest ");
    update();

    String token = myServices.sharedPreferences.getString("token") ?? "";
    var response = await companyData.getMyAds(token);

    print(
        "=========getMyAds=======CompanyHomeControllerImp==============* Controller $response ");
    print(
        "========getMyAds=========CompanyHomeControllerImp=============--Controller $statusRequest ");

    statusRequest = handlingData(response);

    if (StatusRequest.success == statusRequest) {
      // Start backend
      if (response["data"] != null) {
        // تفريغ القائمة قبل الإضافة لتجنب التكرار عند تحديث الصفحة
        myAds!.clear();

        // تحويل القائمة القادمة من السيرفر إلى موديلات وإضافتها
        List responseData = response['data'];
        myAds!.addAll(responseData.map((e) => CompaniesPostModel.fromJson(e)));
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
    print(
        "*******getMyAds*********CompanyHomeControllerImp********** *-*-* $statusRequest");
  }
  //ربط
}
