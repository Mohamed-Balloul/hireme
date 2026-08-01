import 'package:hireme/core/class/statusrequest.dart';
import 'package:hireme/core/functions/handlingdatacontroller.dart';
import 'package:hireme/core/services/services.dart';
import 'package:hireme/data/datasource/remote/student/student.dart';
// import 'package:hireme/data/datasource/static/static.dart';
import 'package:hireme/data/model/companypostmodel.dart';
import 'package:get/get.dart';
import 'package:hireme/data/model/companyprofilemodel.dart';
import 'package:hireme/data/model/customerprofilemodel.dart';
import 'package:hireme/data/model/myrequesttocompanymodel.dart';
import 'package:hireme/data/model/myrequesttocustomermodel.dart';
import 'package:hireme/view/screen/company/companyprofile.dart';
import 'package:hireme/view/screen/customer/customerprofile.dart';
// import 'package:hireme/view/screen/student/companypostdetails.dart';

abstract class MyOrdersController extends GetxController {
  goToPostDetails(CompanyPostModel companyPostModel);
  goToCompanyProfile(String companyName);
  goToCustomerProfile(String customerName);
  deleteOrder(int id, bool isCompany);
  printHi();
  //--ربط
  getAllMyAdApplications();
  getAllMyProjectApplications();
  //--
  deleteMyAdApplication(String id);
  deleteMyProjectApplication(String id);

  // الدالة الجديدة هنا
  Future<void> refreshData();
}

class MyOrdersControllerImp extends MyOrdersController {
  //--ربط
  StatusRequest statusRequest = StatusRequest.none;
  MyServices myServices = Get.find();
  StudentData studentData = StudentData(Get.find());
  List<MyRequestToCompanyModel> allMyAdApplications = [];
  List<MyRequestToCustomerModel> allMyProjectApplications = [];
  //--ربط
  // القائمة التي يتم عرضها
  // List<MyRequestToCompanyModel> get myAllRequestsToCompaniesList {
  //   /*if (selectedFilter == "الكل")*/ return myRequestsToCompaniesList;
  //   // return allNotifications.where((n) => n.type == selectedFilter).toList();
  // }

  // القائمة التي يتم عرضها
  // List<MyRequestToCustomerModel> get myAllRequestsToCustomersList {
  //   /*if (selectedFilter == "الكل")*/ return myRequestsToCustomersList;
  //   // return allNotifications.where((n) => n.type == selectedFilter).toList();
  // }
  //ربط
  @override
  Future<void> refreshData() async {
    // await getCompanyData();
    // await getAllStudents();
    await getAllMyAdApplications();
    await getAllMyProjectApplications();
    update(); // تحديث واجهة المستخدم بعد تحديث البيانات
  }
  //ربط

  @override
  getAllMyAdApplications() async {
    statusRequest = StatusRequest.loading;
    print(
        "=====getAllMyAdApplications============MyOrdersControllerImp=============-*-Controller $statusRequest ");
    update();

    // بعد ما ينجح الـ API call
    // await Future.delayed(const Duration(seconds: 5)); // أضف هذا السطر
    // ثم انتقل لصفحة الـ

    var response = await studentData.getAllMyAdApplications(
        myServices.sharedPreferences.getString("token")!);

    print(
        "=====getAllMyAdApplications=============MyOrdersControllerImp============* Controller $response ");
    print(
        "=====getAllMyAdApplications=============MyOrdersControllerImp============--Controller $statusRequest ");

    statusRequest = handlingData(response);

    if (StatusRequest.success == statusRequest) {
      // Start backend
      if (response["data"] != null) {
        // allCompaniesAds!.add(CompaniesPostModel.fromJson(response['data']));
        // تفريغ القائمة قبل الإضافة لتجنب التكرار عند تحديث الصفحة
        allMyAdApplications!.clear();

        // تحويل القائمة القادمة من السيرفر إلى موديلات وإضافتها
        List responseData = response['data'];
        allMyAdApplications!.addAll(
            responseData.map((e) => MyRequestToCompanyModel.fromJson(e)));
        //--
        //     allMyAdApplications.clear(); // إزالة الـ ! هنا

        // List responseData = response['data'];
        // // تحويل البيانات وإضافتها للقائمة
        // allMyAdApplications.addAll(
        //     responseData.map((e) => MyRequestToCompanyModel.fromJson(e)).toList()
        // );
        //--
        // _updateSuggestions(); // استدعاء دالة تحديث المقترحات
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
        "****getAllMyAdApplications*************MyOrdersControllerImp********* *-*-* $statusRequest");
  }

  //ربط
  @override
  getAllMyProjectApplications() async {
    statusRequest = StatusRequest.loading;
    print(
        "=====getAllMyProjectApplications=========================-*-Controller $statusRequest ");
    update();
    // بعد ما ينجح الـ API call
    // await Future.delayed(const Duration(seconds: 5)); // أضف هذا السطر
    // ثم انتقل لصفحة الـ

    var response = await studentData.getAllMyProjectApplications(
        myServices.sharedPreferences.getString("token")!);

    print(
        "=====getAllMyProjectApplications=========================* Controller $response ");
    print(
        "=====getAllMyProjectApplications=========================--Controller $statusRequest ");

    statusRequest = handlingData(response);

    if (StatusRequest.success == statusRequest) {
      // Start backend
      if (response["data"] != null) {
        // allCompaniesAds!.add(CompaniesPostModel.fromJson(response['data']));
        // تفريغ القائمة قبل الإضافة لتجنب التكرار عند تحديث الصفحة
        allMyProjectApplications!.clear();

        // تحويل القائمة القادمة من السيرفر إلى موديلات وإضافتها
        List responseData = response['data'];
        allMyProjectApplications!.addAll(
            responseData.map((e) => MyRequestToCustomerModel.fromJson(e)));
        // _updateSuggestions(); // استدعاء دالة تحديث المقترحات
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
        "****getAllMyProjectApplications********************** *-*-* $statusRequest");
  }

  //ربط
  @override
  deleteMyAdApplication(id) async {
    statusRequest = StatusRequest.loading;
    print(
        "=====deleteMyAdApplication=========================-*-Controller $statusRequest ");
    update();
    // بعد ما ينجح الـ API call
    // await Future.delayed(const Duration(seconds: 5)); // أضف هذا السطر
    // ثم انتقل لصفحة الـ

    var response = await studentData.deleteMyAdApplication(
        id, myServices.sharedPreferences.getString("token")!);

    print(
        "=====deleteMyAdApplication=========================* Controller $response ");
    print(
        "=====deleteMyAdApplication=========================--Controller $statusRequest ");

    statusRequest = handlingData(response);

    if (StatusRequest.success == statusRequest) {
      // Start backend
      if (response["message"] == "Ad application deleted successfully.") {
        getAllMyAdApplications();
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
        "****deleteMyAdApplication********************** *-*-* $statusRequest");
  }

  //ربط
  @override
  deleteMyProjectApplication(id) async {
    statusRequest = StatusRequest.loading;
    print(
        "===========deleteMyProjectApplication===================-*-Controller $statusRequest ");
    update();
    // بعد ما ينجح الـ API call
    // await Future.delayed(const Duration(seconds: 5)); // أضف هذا السطر
    // ثم انتقل لصفحة الـ

    var response = await studentData.deleteMyProjectApplication(
        id, myServices.sharedPreferences.getString("token")!);

    print(
        "====deleteMyProjectApplication=========================* Controller $response ");
    print(
        "========deleteMyProjectApplication======================--Controller $statusRequest ");

    statusRequest = handlingData(response);

    if (StatusRequest.success == statusRequest) {
      // Start backend
      if (response["message"] == "Project application deleted successfully.") {
        getAllMyProjectApplications();
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
        "****deleteMyProjectApplication********************** *-*-* $statusRequest");
  }

  @override
  void onInit() {
    getAllMyAdApplications();
    getAllMyProjectApplications();
    super.onInit();
  }

  @override
  goToPostDetails(companyPostModel) {}
  @override
  void goToCompanyProfile(companyName) {
    // البحث في قائمة بروفايلات الشركات عن الشركة التي تملك نفس الاسم
    // CompanyProfileModel? companyData = companyProfileList.firstWhere(
    //   (element) => element.name == companyName,
    //   orElse: () => companyProfileList[0], // قيمة افتراضية في حال عدم الوجود
    // );

    // Get.to(() => CompanyProfile(
    //       company: companyData,
    //       isMine: false, // لأن الزائر طالب وليس صاحب الشركة
    //     ));
  }

  @override
  void goToCustomerProfile(customerName) {
    // البحث في قائمة بروفايلات الشركات عن الشركة التي تملك نفس الاسم
    // CustomerProfileModel? customerData = customerProfileList.firstWhere(
    //   (element) => element.name == customerName,
    //   orElse: () => customerProfileList[0], // قيمة افتراضية في حال عدم الوجود
    // );

    // Get.to(() => CustomerProfile(
    //       customer: customerData,
    //       isMine: false, // لأن الزائر طالب وليس صاحب الشركة
    //     ));
  }

  @override
  printHi() {
    print("hi");
  }

  @override
  deleteOrder(id, isCompany) {
    // isCompany
    //     ? myRequestsToCompaniesList.removeWhere((element) => element. == id)
    //     : myRequestsToCustomersList.removeWhere((element) => element.id == id);
    String id1 = id.toString();
    isCompany ? deleteMyAdApplication(id1) : deleteMyProjectApplication(id1);
    printHi();
    update();
  }
}
