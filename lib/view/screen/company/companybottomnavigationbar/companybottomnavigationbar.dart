import 'package:hireme/controller/company/companybottomnavigationbar/companybottomnavigationbar_controller.dart';
import 'package:hireme/core/constant/color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hireme/data/datasource/static/static.dart';
import 'package:hireme/view/screen/Company/myorders.dart';
import 'package:hireme/view/screen/Company/Companyhome.dart';
import 'package:hireme/view/screen/company/addcompanypost.dart';
import 'package:hireme/view/screen/company/companycomingrequests.dart';
import 'package:hireme/view/screen/company/companynotifications.dart';
import 'package:hireme/view/screen/company/companypostdetails.dart';
import 'package:hireme/view/screen/company/companyprofile.dart';

class CompanyBottomNavigationBarr extends StatelessWidget {
  const CompanyBottomNavigationBarr({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(CompanyBottomNavigationBarrControllerImp());
    List<Widget> mainList = [
      const CompanyHome(),
      const AddCompanyPost(),
      // const CompanyPostsDetails(),
      // const CompanyComingRequests(),
      const CompanyNotifications(),
      CompanyProfile(
        company: companyProfileList[0],
        isMine: true,
      ),
    ];
    return GetBuilder<CompanyBottomNavigationBarrControllerImp>(
        builder: (controller) {
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
                  Icons.add,
                ),
                label: "إضافة إعلان"),
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
