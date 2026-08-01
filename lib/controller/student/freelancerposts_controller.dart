import 'package:get/get.dart';
import 'package:hireme/controller/student/studenthome_controller.dart';
import 'package:hireme/core/class/statusrequest.dart';
import 'package:hireme/core/constant/color.dart';
import 'package:hireme/core/functions/handlingdatacontroller.dart';
import 'package:hireme/core/services/services.dart';
import 'package:hireme/data/datasource/remote/student/student.dart';
// import 'package:hireme/core/class/statusrequest.dart';
// import 'package:hireme/core/constant/routes.dart';
// import 'package:hireme/core/services/services.dart';
// import 'package:hireme/data/datasource/remote/student/student.dart';
// import 'package:hireme/data/datasource/static/static.dart';
import 'package:flutter/material.dart'; // استيراد ويدجت فلاتر الأساسية
import 'package:hireme/data/model/customerprofilemodel.dart';
import 'package:hireme/data/model/freelancerpostmodel.dart';
import 'package:hireme/view/screen/customer/customerprofile.dart';
import 'package:hireme/view/screen/student/freelancerpostdetails.dart';
import 'package:hireme/view/screen/student/sendrequesttocustomer.dart';

abstract class FreelancerPostsController extends GetxController {
  goToPostDetails(FreelancerPostModel freelancerPostModel);
  goToCustomerProfile(String customerId);
  action(int index);
  change(int index);
  goToSendRequestToCustomer(FreelancerPostModel freelancerPostModel);
  //--
  getAllCustomersPosts();
}

class FreelancerPostsControllerImp extends FreelancerPostsController {
  StudentHomeControllerImp homeController =
      Get.find<StudentHomeControllerImp>();
  int currentIndex = 0;
  //--
  List<FreelancerPostModel> allCustomersPosts = [];
  //--
  //--ربط
  StatusRequest statusRequest = StatusRequest.none;
  MyServices myServices = Get.find();
  StudentData studentData = StudentData(Get.find());

  CustomerProfileModel? customerProfileModel;

  //--ربط
  //--

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
  goToSendRequestToCustomer(freelancerPostModel) {
    // Get.toNamed(AppRoute.sendRequestToCustomer);
    Get.to(
        () => SendRequestToCustomer(freelancerPostModel: freelancerPostModel));
    // Get.to(() => SendRequestToCompany(companiesPostModel: companiesPostModel));
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
  void goToCustomerProfile(customerId) async {
    // البحث في قائمة بروفايلات الشركات عن الشركة التي تملك نفس الاسم
    // CustomerProfileModel? customerData = customerProfileList.firstWhere(
    //   (element) => element.name == customerName,
    //   orElse: () => customerProfileList[0], // قيمة افتراضية في حال عدم الوجود
    // );

    // Get.to(() => CustomerProfile(
    //       customer: customerData,
    //       isMine: false, // لأن الزائر طالب وليس صاحب الشركة
    //     ));
    Get.dialog(
      const Center(
        child: Card(
          elevation: 4,
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(16)),
          ),
          child: Padding(
            padding: EdgeInsets.all(24.0),
            child: CircularProgressIndicator(
              color:
                  AppColor.primaryColor, // المؤشر الأخضر الدائري المعتمد لديك
            ),
          ),
        ),
      ),
      barrierDismissible:
          false, // يمنع إغلاق الديالوغ بالضغط خارجاً لضمان عدم مقاطعة العملية
    );

    statusRequest = StatusRequest.loading;
    print(
        "=====goToCustomerProfile=========FreelancerPostsControllerImp================-*-Controller $statusRequest ");
    // update();

    // استدعاء دالة جلب معلومات الشركة بالـ ID الفعلي
    var response = await studentData.getCustomerDataById(
        customerId, myServices.sharedPreferences.getString("token")!);

    print(
        "=====goToCustomerProfile=========FreelancerPostsControllerImp======= The Response ===========* Controller $response ");
    statusRequest = handlingData(response);
    // 3. إغلاق ديالوغ التحميل فوراً عند انتهاء عملية الاتصال بالسيرفر (سواءً نجحت أو فشلت)
    if (Get.isDialogOpen ?? false) {
      Get.back();
    }

    if (StatusRequest.success == statusRequest) {
      if (response['data'] != null) {
        // تعبئة البيانات في الموديل بنجاح وبشكل مباشر
        customerProfileModel = CustomerProfileModel.fromJson(response['data']);

        // الانتقال لصفحة البروفايل وتمرير الموديل
        Get.to(() => CustomerProfile(
              customer: customerProfileModel!,
              isMine: false, // الزائر طالب
            ));
      } else {
        statusRequest = StatusRequest.none;
      }
    } else {
      statusRequest = StatusRequest.none;
      // إظهار رسالة تنبيه سريعة في حال فشل الاتصال بالشبكة
      Get.snackbar(
        "خطأ في الاتصال",
        "تعذر جلب معلومات العميل، يرجى التحقق من الإنترنت وإعادة المحاولة",
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
      statusRequest = StatusRequest.none;
    }
    update();
    print(
        "****goToCustomerProfile****FreelancerPostsControllerImp****************** *-*-* $statusRequest");
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
