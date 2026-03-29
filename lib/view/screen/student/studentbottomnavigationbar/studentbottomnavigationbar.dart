import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:hireme/controller/student/thebottomnavigationbar/thebottomnavigationbar_controller.dart';
import 'package:hireme/core/constant/color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hireme/data/datasource/static/static.dart';
import 'package:hireme/view/screen/student/myorders.dart';
import 'package:hireme/view/screen/student/studenthome.dart';
import 'package:hireme/view/screen/student/studentnotifications.dart';
import 'package:hireme/view/screen/student/studentprofile.dart';

class StudentBottomNavigationBarr extends StatelessWidget {
  const StudentBottomNavigationBarr({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(StudentBottomNavigationBarrControllerImp());
    List<Widget> mainList = [
      const StudentHome(),
      const MyOrders(),
      const StudentNotifications(),
      StudentProfile(
        student: studentProfileList[0],
        isMine: true,
        isCompany: false,
      ),
    ];
    return GetBuilder<StudentBottomNavigationBarrControllerImp>(
        builder: (controller) {
      return SafeArea(
          child: Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          // showSelectedLabels: false,
          // showUnselectedLabels: false,
          selectedLabelStyle: TextStyle(fontSize: 10),
          unselectedLabelStyle: TextStyle(fontSize: 10),
          type: BottomNavigationBarType.fixed,
          selectedItemColor: AppColor.primaryColor,
          unselectedItemColor: Colors.grey,
          elevation: 20,
          // backgroundColor: AppColor.black,

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
