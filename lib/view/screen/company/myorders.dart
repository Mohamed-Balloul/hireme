// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:hireme/controller/student/myorders_controller.dart';
// import 'package:hireme/core/constant/color.dart';
// import 'package:hireme/data/datasource/static/static.dart';
// // import 'package:hireme/data/model/companyordermodel.dart';
// import 'package:hireme/view/widget/checkout/custombutton.dart';

// class MyOrders extends StatelessWidget {
//   const MyOrders({super.key});

//   @override
//   Widget build(BuildContext context) {
//     MyOrdersControllerImp controller = Get.put(MyOrdersControllerImp());
//     return SafeArea(
//         child: Scaffold(
//       body: Container(
//         child: ListView.builder(
//           itemCount: myRequestsToCompaniesList.length,
//           itemBuilder: (context, i) {
//             // final CompanyOrderModel selectedPost = companyOrdersList[i];
//             return Container(
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(8),
//                 color: Colors.grey[100],
//                 border: Border.all(
//                   width: 2,
//                   color: AppColor.primaryColor,
//                 ),
//               ),
//               margin: const EdgeInsets.all(10),
//               padding: const EdgeInsets.all(10),
//               child: Column(
//                 children: [
//                   Padding(
//                     padding: const EdgeInsets.only(
//                       bottom: 10,
//                     ),
//                     child: Row(
//                       children: [
//                         const Text("الناشر: "),
//                         Text(myRequestsToCompaniesList[i].publisher!),
//                       ],
//                     ),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.only(
//                       bottom: 10,
//                     ),
//                     child: Row(
//                       children: [
//                         const Text("المسمى الوظيفي: "),
//                         Text(myRequestsToCompaniesList[i].jobTitle!),
//                       ],
//                     ),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.only(
//                       bottom: 10,
//                     ),
//                     child: Row(
//                       children: [
//                         const Text("حالة الطلب: "),
//                         Text(myRequestsToCompaniesList[i].orderState!),
//                       ],
//                     ),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.only(
//                       top: 10,
//                     ),
//                     child: CustomButton(
//                       text: "حذف الطلب",
//                       onPressed: () {
//                         // controller.goToPostDetails(selectedPost);
//                       },
//                     ),
//                   ),
//                 ],
//               ),
//             );
//           },
//         ),
//       ),
//     ));
//   }
// }
