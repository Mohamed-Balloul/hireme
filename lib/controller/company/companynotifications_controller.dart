import 'package:get/get.dart';
import 'package:hireme/data/datasource/static/static.dart';
import 'package:hireme/data/model/studentnotificationmodel.dart';
import 'package:hireme/data/model/studentprofilemodel.dart';
import 'package:hireme/view/screen/student/studentprofile.dart';

abstract class CompanyNotificationsController extends GetxController {
  changeFilter(String newFilter);
  deleteNotification(int id); // النوع المحدد حالياً للفلترة
  goToStudentProfile(String studentName);
}

class CompanyNotificationsControllerImp extends CompanyNotificationsController {
  String selectedFilter = "الكل";

  // قائمة الفلاتر
  List<String> filters = ["الكل", "أدمن", "طلاب"];

  // القائمة التي يتم عرضها بعد الفلترة
  List<StudentNotificationModel> get filteredNotifications {
    if (selectedFilter == "الكل") return allCompanyNotifications;
    return allCompanyNotifications
        .where((n) => n.type == selectedFilter)
        .toList();
  }

  @override
  void changeFilter(newFilter) {
    selectedFilter = newFilter;
    update();
  }

  @override
  void deleteNotification(id) {
    allCompanyNotifications.removeWhere((element) => element.id == id);
    update();
  }

  @override
  void onInit() {
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
          isCompany: true,
        ));
  }
}
