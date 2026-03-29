import 'package:get/get.dart';

abstract class CustomerSendNotificationToStudentController
    extends GetxController {}

class CustomerSendNotificationToStudentControllerImp
    extends CustomerSendNotificationToStudentController {
  // قائمة الـ IDs للإعلانات المختارة
  var selectedAdIds = <String>[].obs;

  void toggleSelection(String id) {
    if (selectedAdIds.contains(id)) {
      selectedAdIds.remove(id);
    } else {
      selectedAdIds.add(id);
    }
  }

  bool isSelected(String id) => selectedAdIds.contains(id);

  void sendNotification() {
    if (selectedAdIds.isNotEmpty) {
      Get.back();
      Get.snackbar("نجاح", "تم إرسال الإشعار للطالب بنجاح",
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void dispose() {
    super.dispose();
  }
}
