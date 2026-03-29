// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:hireme/controller/company/companiesposts_controller.dart';
// import 'package:hireme/core/constant/color.dart';
// import 'package:hireme/data/datasource/static/static.dart';
// import 'package:hireme/data/model/companypostmodel.dart';
// import 'package:hireme/view/widget/checkout/custombutton.dart';

// class CompanyPosts extends StatelessWidget {
//   const CompanyPosts({super.key});

//   @override
//   Widget build(BuildContext context) {
//     CompanyPostsControllerImp controller = Get.put(CompanyPostsControllerImp());
//     return SafeArea(
//         child: Scaffold(
//       body: Container(
//         child: ListView.builder(
//           itemCount: companyPostsList.length,
//           itemBuilder: (context, i) {
//             final CompanyPostModel selectedPost = companyPostsList[i];
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
//                         Text(companyPostsList[i].publisher!),
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
//                         Text(companyPostsList[i].jobTitle!),
//                       ],
//                     ),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.only(
//                       top: 10,
//                     ),
//                     child: CustomButton(
//                       text: "رؤية كامل التفاصيل",
//                       onPressed: () {
//                         controller.goToPostDetails(selectedPost);
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
