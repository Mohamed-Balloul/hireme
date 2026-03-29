// import 'package:hireme/core/constant/color.dart';
// import 'package:flutter/material.dart';

// class CustomButtonAuth extends StatelessWidget {
//   final String text;
//   final void Function()? onPressed;
//   const CustomButtonAuth({super.key, required this.text, this.onPressed});

//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//       onTap: onPressed,
//       child: Container(
//         width: double.infinity,
//         padding: const EdgeInsets.symmetric(vertical: 14),
//         decoration: BoxDecoration(
//             color: AppColor.primaryColor,
//             borderRadius: BorderRadius.circular(10)),
//         child: Text(
//           text,
//           textAlign: TextAlign.center,
//           style: const TextStyle(
//             fontSize: 15,
//             color: Colors.white,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:hireme/core/constant/color.dart';
import 'package:flutter/material.dart';

class CustomButtonAuth extends StatelessWidget {
  final String text;
  final void Function()? onPressed;

  const CustomButtonAuth({super.key, required this.text, this.onPressed});

  @override
  Widget build(BuildContext context) {
    // نحدد إذا كان الزر معطلاً أم لا
    bool isDisabled = onPressed == null;

    return InkWell(
      // إذا كان معطلاً، نجعل onTap تساوي null لمنع تأثير النبضة (Ripple Effect)
      onTap: onPressed,
      borderRadius:
          BorderRadius.circular(10), // لكي يكون تأثير الضغط متناسقاً مع الحواف
      child: AnimatedContainer(
        // استخدام AnimatedContainer يعطي نعومة عند تغيير اللون
        duration: const Duration(milliseconds: 300),
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 14),
        decoration: BoxDecoration(
          // التعديل هنا: إذا كان معطلاً نستخدم لوناً باهتاً، وإلا نستخدم اللون الأساسي
          color: isDisabled
              // ? AppColor.primaryColor.withOpacity(0.2)
              ? Color.fromARGB(248, 237, 237, 237)
              : AppColor.primaryColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 15,
            // التعديل هنا: تخفيف لون النص أيضاً عند التعطيل ليعطي طابعاً احترافياً
            // color: isDisabled ? Colors.white70 : Colors.white,
            color: isDisabled
                ? const Color.fromARGB(255, 185, 185, 185)
                : Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
