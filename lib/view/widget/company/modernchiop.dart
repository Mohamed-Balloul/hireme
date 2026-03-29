// import 'package:flutter/material.dart';

// class ModernChip extends StatelessWidget {
//   const ModernChip({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Expanded(
//       child: InkWell(
//         onTap: onTap,
//         borderRadius: BorderRadius.circular(8),
//         child: Container(
//           padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
//           decoration: BoxDecoration(
//             color: Colors.white, // خلفية بيضاء
//             border: Border.all(
//                 color: Colors.grey.shade200), // حدود رمادية خفيفة جداً
//             borderRadius: BorderRadius.circular(8),
//           ),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Icon(icon, size: 16, color: color), // اللون فقط للأيقونة
//               const SizedBox(width: 6),
//               Text(
//                 label,
//                 style: TextStyle(
//                     fontSize: 11, // خط صغير
//                     color: Colors.grey[700], // لون نص رمادي غامق
//                     fontWeight: FontWeight.w500),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
