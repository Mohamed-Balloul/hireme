import 'package:hireme/core/constant/color.dart';
import 'package:flutter/material.dart';

class CustomTextFormWithoutLablel extends StatelessWidget {
  final String hintText;
  final IconData iconData;
  // final TextEditingController? mycontroller;
  // final String? Function(String?) valid;
  final void Function()? onTapIcon;

  const CustomTextFormWithoutLablel({
    this.onTapIcon,
    super.key,
    required this.hintText,
    required this.iconData,
    // required this.mycontroller,
    // required this.valid,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      // validator: valid,
      // controller: mycontroller,
      decoration: InputDecoration(
        hintStyle: const TextStyle(fontSize: 14),
        contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 20),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(7),
          borderSide: const BorderSide(
              color: Color.fromARGB(255, 203, 202, 202), width: 2),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(7),
          borderSide: const BorderSide(color: AppColor.primaryColor, width: 2),
        ),
        // suffixIcon: InkWell(
        //   child: Icon(
        //     iconData,
        //     color: AppColor.grey,
        //   ),
        //   onTap: onTapIcon,
        // ),

        hintText: hintText,
      ),
    );
  }
}
