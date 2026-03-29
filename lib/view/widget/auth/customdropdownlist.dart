// import 'package:hireme/controller/auth/signup_controller.dart';
// import 'package:hireme/core/constant/color.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// class CustomDropdownList extends GetView<SignUpControllerImp> {
//   final String labelText;
//   final String? selectedType;

//   const CustomDropdownList(
//       {super.key, required this.labelText, this.selectedType});

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Padding(
//           padding: const EdgeInsets.only(bottom: 5),
//           child: Text(
//             labelText,
//             style: const TextStyle(fontWeight: FontWeight.bold),
//           ),
//         ),
//         GetBuilder<SignUpControllerImp>(builder: (controller) {
//           return Container(
//             padding: const EdgeInsets.only(
//               top: 0,
//               bottom: 0,
//               right: 27,
//               left: 10,
//             ),
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(30),
//               border: Border.all(color: AppColor.grey),
//             ),
//             child: DropdownButtonHideUnderline(
//               child: DropdownButton<String>(
//                 value: controller.selectedType, //
//                 icon: const Icon(Icons.keyboard_arrow_down_outlined),
//                 isExpanded: true,
//                 onChanged: (value) {
//                   controller.selectType(value!);
//                 },
//                 items: ['طالب/خريج', 'شركة', 'عميل']
//                     .map((type) => DropdownMenuItem(
//                           value: type,
//                           child: Text(
//                             type,
//                             style: const TextStyle(
//                               fontWeight: FontWeight.normal,
//                               fontSize: 15,
//                             ),
//                           ),
//                         ))
//                     .toList(),
//               ),
//             ),
//           );
//         }),
//       ],
//       // );
//       // },
//     );
//   }
// }
import 'package:hireme/controller/auth/signup_controller.dart';
import 'package:hireme/core/constant/color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomDropdownList extends GetView<SignUpControllerImp> {
  final String labelText;

  const CustomDropdownList({
    super.key,
    required this.labelText,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SignUpControllerImp>(
      builder: (controller) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // العنوان الصغير فوق الحقل
            Padding(
              padding: const EdgeInsets.only(bottom: 5),
              child: Text(
                labelText,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            // استخدام DropdownButtonFormField يضمن التناسق التام مع TextFormField
            DropdownButtonFormField<String>(
              value: controller.selectedType,
              icon: const Icon(Icons.keyboard_arrow_down,
                  color: AppColor.primaryColor),
              style: const TextStyle(
                fontSize: 15,
                color: Colors.black87, /*fontFamily: "sans"*/
              ),
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.only(right: 30, left: 12),
                filled: true,
                fillColor: const Color(0xFFFDFDFD), // لون فاتح متناسق

                border: OutlineInputBorder(
                  borderRadius:
                      BorderRadius.circular(30), // نفس انحناء الزر والحقول
                  borderSide: const BorderSide(color: AppColor.grey),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide(color: AppColor.grey),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: const BorderSide(
                    color: AppColor
                        .grey /*color: AppColor.primaryColor*/, /*width: 2*/
                  ),
                ),
              ),
              items: ['طالب/خريج', 'شركة', 'عميل']
                  .map((type) => DropdownMenuItem(
                        value: type,
                        child: Text(type),
                      ))
                  .toList(),
              onChanged: (value) {
                controller.selectType(value!);
              },
              // لجعل القائمة المنبثقة ناعمة وذات حواف دائرية
              borderRadius: BorderRadius.circular(20),
              dropdownColor: Colors.white,
            ),
          ],
        );
      },
    );
  }
}
