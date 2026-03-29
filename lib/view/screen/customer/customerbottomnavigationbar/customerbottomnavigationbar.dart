import 'package:hireme/controller/customer/customerbottomnavigationbar/customerbottomnavigationbar_controller.dart';
import 'package:hireme/core/constant/color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hireme/data/datasource/static/static.dart';
import 'package:hireme/view/screen/company/myorders.dart';
import 'package:hireme/view/screen/customer/addcustomerpost.dart';
import 'package:hireme/view/screen/customer/customercomingrequests.dart';
import 'package:hireme/view/screen/customer/customerhome.dart';
import 'package:hireme/view/screen/customer/customernotifications.dart';
import 'package:hireme/view/screen/customer/customerpostsdetails.dart';
import 'package:hireme/view/screen/customer/customerprofile.dart';

class CustomerBottomNavigationBarr extends StatelessWidget {
  const CustomerBottomNavigationBarr({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(CustomerBottomNavigationBarrControllerImp());
    List<Widget> mainList = [
      const CustomerHome(),
      // const MyOrders(),
      // const CustomerPostsDetails(),
      const AddCustomerPost(),
      // const CustomerComingRequests(),
      const CustomerNotifications(),
      CustomerProfile(
        customer: customerProfileList[0],
        isMine: true,
      ),
    ];
    return GetBuilder<CustomerBottomNavigationBarrControllerImp>(
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
