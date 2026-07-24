import 'package:get/get.dart';
import 'package:hireme/core/class/statusrequest.dart';
import 'package:hireme/core/functions/handlingdatacontroller.dart';
import 'package:hireme/core/services/services.dart';
import 'package:hireme/data/datasource/remote/student/notifications.dart';
import 'package:hireme/data/datasource/static/static.dart';
import 'package:hireme/data/model/studentnotificationmodel.dart';
import 'package:hireme/data/model/studentprofilemodel.dart';
import 'package:hireme/view/screen/student/studentprofile.dart';

abstract class CustomerNotificationsController extends GetxController {
  changeFilter(String newFilter);
  deleteNotification(int id); // النوع المحدد حالياً للفلترة
  goToStudentProfile(String studentName);
  //
  getAllCustomerNotifications();
  markRead(int id);
}

class CustomerNotificationsControllerImp
    extends CustomerNotificationsController {
  //--
  NotificationData notificationData = NotificationData(Get.find());
  MyServices myServices = Get.find();
  StatusRequest statusRequest = StatusRequest.none;
  List<StudentNotificationModel> allNotifications = [];
  //--
  String selectedFilter = "الكل";

  // قائمة الفلاتر
  List<String> filters = ["الكل", "أدمن", "طلاب"];

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
    getAllCustomerNotifications(); // جلب الإشعارات الحقيقية عند فتح الصفحة
    super.onInit();
  }

  @override
  void goToStudentProfile(studentName) {
    // البحث في قائمة بروفايلات الشركات عن الشركة التي تملك نفس الاسم
    StudentProfileModel? studentData = studentProfileList.firstWhere(
      (element) => element.name == studentName,
      orElse: () => studentProfileList[0], // قيمة افتراضية في حال عدم الوجود
    );

    Get.to(() => StudentProfile(
          student: studentData,
          isMine: false, // لأن الزائر طالب وليس صاحب الشركة
          isCompany: false,
        ));
  }

  @override
  getAllCustomerNotifications() async {
    statusRequest = StatusRequest.loading;
    update();
    String token = myServices.sharedPreferences.getString("token")!;
    var response = await notificationData.getNotifications(token);

    statusRequest = handlingData(response);

    if (StatusRequest.success == statusRequest) {
      List responseData = response['data'];
      allNotifications.clear();
      allNotifications.addAll(
          responseData.map((e) => StudentNotificationModel.fromJson(e)));
    }
    update();
  }

  @override
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
}
