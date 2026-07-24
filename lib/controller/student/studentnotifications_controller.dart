import 'package:get/get.dart';
import 'package:hireme/core/class/statusrequest.dart';
import 'package:hireme/core/functions/handlingdatacontroller.dart';
import 'package:hireme/core/services/services.dart';
import 'package:hireme/data/datasource/remote/student/notifications.dart';
import 'package:hireme/data/datasource/static/static.dart';
import 'package:hireme/data/model/companyprofilemodel.dart';
import 'package:hireme/data/model/customerprofilemodel.dart';
import 'package:hireme/data/model/studentnotificationmodel.dart';
import 'package:hireme/view/screen/company/companyprofile.dart';
import 'package:hireme/view/screen/customer/customerprofile.dart';

abstract class StudentNotificationsController extends GetxController {
  changeFilter(String newFilter);
  deleteNotification(int id);
  goToCompanyProfile(String companyName);
  goToCustomerProfile(String customerName);
  //
  getAllStudentNotifications();
  markRead(int id);
  delete_Notification(id);
}

class StudentNotificationsControllerImp extends StudentNotificationsController {
  //--ربط
  NotificationData notificationData = NotificationData(Get.find());
  MyServices myServices = Get.find();
  StatusRequest statusRequest = StatusRequest.none;
  List<StudentNotificationModel> allNotifications = [];
  //--
  // النوع المحدد حالياً للفلترة
  String selectedFilter = "الكل";

  // قائمة الفلاتر
  List<String> filters = ["الكل", "أدمن", "شركات", "عملاء"];

  // القائمة التي يتم عرضها بعد الفلترة
  List<StudentNotificationModel> get filteredNotifications {
    if (selectedFilter == "الكل") return allNotifications;
    return allNotifications.where((n) => n.type == selectedFilter).toList();
  }

  @override
  void changeFilter(newFilter) {
    selectedFilter = newFilter;
    update();
  }

  @override
  void deleteNotification(id) {
    allNotifications.removeWhere((element) => element.id == id);
    update();
  }

  @override
  void onInit() {
    getAllStudentNotifications(); // جلب الإشعارات الحقيقية عند فتح الصفحة
    super.onInit();
  }

  @override
  void goToCompanyProfile(companyName) {
    // البحث في قائمة بروفايلات الشركات عن الشركة التي تملك نفس الاسم
    CompanyProfileModel? companyData = companyProfileList.firstWhere(
      (element) => element.name == companyName,
      orElse: () => companyProfileList[0], // قيمة افتراضية في حال عدم الوجود
    );

    Get.to(() => CompanyProfile(
          company: companyData,
          isMine: false, // لأن الزائر طالب وليس صاحب الشركة
        ));
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
  getAllStudentNotifications() async {
    statusRequest = StatusRequest.loading;
    print(
        "=====getAllStudentNotifications=========================-*-Controller $statusRequest ");
    update();
    String token = myServices.sharedPreferences.getString("token")!;
    var response = await notificationData.getNotifications(token);
    print(
        "=====getAllStudentNotifications================ The Response ===========* Controller $response ");
    print(
        "=====getAllStudentNotifications==============================--Controller $statusRequest ");

    statusRequest = handlingData(response);

    if (StatusRequest.success == statusRequest) {
      if (response['data'] != null) {
        List responseData = response['data'];
        allNotifications.clear();
        allNotifications.addAll(
            responseData.map((e) => StudentNotificationModel.fromJson(e)));
      } else {
        statusRequest = StatusRequest.failure;
      }
    } else {}
    update();
    print(
        "****getAllStudentNotifications********************** *-*-* $statusRequest");
  }

  //--

  @override
  // تحديث حالة الإشعار لـ "مقروء" عند الضغط عليه
  markRead(id) async {
    // 1. تحديث الحالة في الواجهة فوراً قبل نداء السيرفر
    int index = allNotifications.indexWhere((element) => element.id == id);
    if (index != -1) {
      // افترضنا أنك أضفت متغير isRead حقيقي في المودل
      allNotifications[index].isRead = true;
      update();
    }

    // 2. إرسال الطلب للسيرفر في الخلفية
    String token = myServices.sharedPreferences.getString("token")!;
    await notificationData.markAsRead(token, id.toString());
  }

  //ربط
  @override
  delete_Notification(id) async {
    statusRequest = StatusRequest.loading;
    print(
        "=====deleteNotification=========================-*-Controller $statusRequest ");
    update();
    // بعد ما ينجح الـ API call
    // await Future.delayed(const Duration(seconds: 5)); // أضف هذا السطر
    // ثم انتقل لصفحة الـ

    var response = await notificationData.getNotifications(
        /*id, */ myServices.sharedPreferences.getString("token")!);

    print(
        "=====deleteNotification=========================* Controller $response ");
    print(
        "=====deleteNotification=========================--Controller $statusRequest ");

    statusRequest = handlingData(response);

    if (StatusRequest.success == statusRequest) {
      // Start backend
      if (response["message"] == "Notification deleted successfully.") {
        getAllStudentNotifications();
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
    print("****deleteNotification********************** *-*-* $statusRequest");
  }
}
