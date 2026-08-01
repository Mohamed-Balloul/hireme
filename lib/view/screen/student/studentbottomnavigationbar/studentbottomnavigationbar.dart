import 'package:hireme/controller/student/thebottomnavigationbar/thebottomnavigationbar_controller.dart';
import 'package:hireme/core/constant/color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hireme/view/screen/student/myorders.dart';
import 'package:hireme/view/screen/student/studenthome.dart';
import 'package:hireme/view/screen/student/studentnotifications.dart';
import 'package:hireme/view/screen/student/studentprofile.dart';

class StudentBottomNavigationBarr extends StatelessWidget {
  const StudentBottomNavigationBarr({super.key});

  @override
  Widget build(BuildContext context) {
    // StudentBottomNavigationBarrControllerImp controller =
    Get.put(StudentBottomNavigationBarrControllerImp());
    return GetBuilder<StudentBottomNavigationBarrControllerImp>(
        builder: (controller) {
      // تعريف القائمة داخل الـ GetBuilder لتحديثها عند وصول البيانات
      List<Widget> mainList = [
        const StudentHome(),
        const MyOrders(),
        const StudentNotifications(),
        // فحص: إذا لم تصل البيانات بعد، اعرض Loading بدل البروفايل
        controller.studentModel == null
            ? const Center(child: CircularProgressIndicator())
            : StudentProfile(
                student: controller.studentModel!,
                isMine: true,
                isCompany: false,
              ),
      ];
      return SafeArea(
          child: Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          selectedLabelStyle: TextStyle(fontSize: 10),
          unselectedLabelStyle: TextStyle(fontSize: 10),
          type: BottomNavigationBarType.fixed,
          selectedItemColor: AppColor.primaryColor,
          unselectedItemColor: Colors.grey,
          elevation: 20,

          items: const [
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.home,
                ),
                label: "الرئيسية"),
            BottomNavigationBarItem(
                icon: Icon(
                  // Icons.assignment_outlined,
                  Icons.outbox_outlined,
                ),
                label: "طلباتي"),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.notifications_none,
                ),
                label: "الإشعارات"),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.person,
                ),
                label: "الملف الشخصي"),
          ],
          //
          onTap: (value) {
            controller.onChange(value);
          },
          currentIndex: controller.selectedIndex,
        ),
        body: mainList.elementAt(controller.selectedIndex),
      ));
    });
  }
}
