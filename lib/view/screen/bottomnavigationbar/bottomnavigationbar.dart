// import 'package:hireme/controller/bottomnavigationbar/bottomnavigationbar_controller.dart';
// import 'package:hireme/core/constant/color.dart';
// import 'package:hireme/view/screen/home/homepage.dart';
// import 'package:hireme/view/screen/mycart/mycart.dart';
// import 'package:hireme/view/screen/mywishlist/mywishlist.dart';
// import 'package:hireme/view/screen/profile/profile.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
// import 'package:get/get.dart';

// class BottomNavigationBarr extends StatelessWidget {
//   const BottomNavigationBarr({super.key});

//   @override
//   Widget build(BuildContext context) {
//     Get.put(BottomNavigationBarrControllerImp());
//     List<Widget> mainList = [
//       HomePage(),
//       MyWishList(),
//       MyCart(),
//       Profile(),
//     ];
//     return GetBuilder<BottomNavigationBarrControllerImp>(builder: (controller) {
//       return SafeArea(
//           child: Scaffold(
//         bottomNavigationBar: BottomNavigationBar(
//           showSelectedLabels: false,
//           showUnselectedLabels: false,
//           type: BottomNavigationBarType.fixed,
//           selectedItemColor: AppColor.primaryColor,
//           unselectedItemColor: Colors.grey,
//           elevation: 20,
//           items: [
//             BottomNavigationBarItem(
//                 icon: Icon(
//                   Icons.home,
//                 ),
//                 label: "1"),
//             BottomNavigationBarItem(
//                 icon: Icon(
//                   Icons.favorite,
//                 ),
//                 label: "2"),
//             BottomNavigationBarItem(
//                 icon: Icon(
//                   Icons.shopping_bag,
//                 ),
//                 label: "3"),
//             BottomNavigationBarItem(
//                 icon: Icon(
//                   Icons.person,
//                 ),
//                 label: "4"),
//           ],
//           //
//           onTap: (value) {
//             controller.onChange(value);
//           },
//           currentIndex: controller.selectedIndex,
//         ),
//         body: mainList.elementAt(controller.selectedIndex),
//       ));
//     });
//   }
// }
