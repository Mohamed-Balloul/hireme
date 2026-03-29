// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:hireme/controller/customer/addcustomerpost_controller.dart';
// import 'package:hireme/core/constant/color.dart';

// class PickFileWidget extends StatelessWidget {
//   const PickFileWidget({
//     super.key,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return GetBuilder<AddCustomerPostControllerImp>(builder: (controller) {
//       if (controller.pickedFile == null) {
//         return Stack(
//           alignment: Alignment.bottomRight,
//           children: [
//             Container(
//               decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(100),
//                   border: Border.all(
//                     width: 2.5,
//                     // color: AppColor.primaryColor,
//                     color: AppColor.greenblack,
//                   )),
//               child: CircleAvatar(
//                 radius: 50,
//                 backgroundColor: Colors.grey[300],
//                 child: const Icon(
//                   Icons.person,
//                   size: 40,
//                 ),
//               ),
//             ),
//             Container(
//               decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(100),
//                   border: Border.all(
//                     width: 2.5,
//                     color: Colors.white,
//                   )),
//               child: CircleAvatar(
//                 radius: 12.5,
//                 backgroundColor: AppColor.primaryColor,
//                 child: InkWell(
//                   onTap: () {
//                     // ImagePicker()
//                     //     .pickImage(source: ImageSource.gallery)
//                     //     .then((value) => controller.uploadProfilePic(value!));
//                     controller.pickAndAddFile();
//                   },
//                   child: const Icon(
//                     Icons.edit,
//                     color: Colors.white,
//                     size: 13,
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         );
//       } else {
//         return Stack(
//           alignment: Alignment.bottomRight,
//           children: [
//             Container(
//               decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(100),
//                   border: Border.all(
//                     width: 3,
//                     // color: AppColor.black,
//                     color: AppColor.greenblack,
//                     // color: AppColor.primaryColor,
//                   )),
//               child: CircleAvatar(
//                 radius: 50,
//                 backgroundColor: Colors.grey[300],
//                 // backgroundImage: FileImage(File(controller.pickedFile!.path)),
//               ),
//             ),
//             Container(
//               decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(100),
//                   border: Border.all(
//                     width: 2.5,
//                     color: Colors.white,
//                   )),
//               child: CircleAvatar(
//                 radius: 12.5,
//                 backgroundColor: AppColor.primaryColor,
//                 child: InkWell(
//                   onTap: () {
//                     // ImagePicker()
//                     //     .pickImage(source: ImageSource.gallery)
//                     //     .then((value) => controller.uploadProfilePic(value!));
//                     controller.pickAndAddFile();
//                   },
//                   child: const Icon(
//                     Icons.edit,
//                     color: Colors.white,
//                     size: 13,
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         );
//       }
//     });
//   }
// }
