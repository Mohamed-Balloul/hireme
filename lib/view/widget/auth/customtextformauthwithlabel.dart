import 'package:get/get.dart';
import 'package:hireme/controller/auth/signup_controller.dart';
import 'package:hireme/core/constant/color.dart';
import 'package:flutter/material.dart';

class CustomTextFormAuthWithLablel extends StatelessWidget {
  final String labelText;
  final String hintText;
  final IconData iconData;
  final TextEditingController? mycontroller;
  final String? Function(String?) valid;
  final bool isNumber;
  final bool? obscureText;
  final void Function()? onTapIcon;

  const CustomTextFormAuthWithLablel({
    this.obscureText,
    this.onTapIcon,
    super.key,
    required this.labelText,
    required this.hintText,
    required this.iconData,
    required this.mycontroller,
    required this.valid,
    required this.isNumber,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 5),
          child: Text(
            labelText,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        TextFormField(
          obscureText:
              obscureText == null || obscureText == false ? false : true,
          validator: valid,
          controller: mycontroller,
          keyboardType: isNumber
              ? const TextInputType.numberWithOptions(decimal: true)
              : TextInputType.text,
          decoration: InputDecoration(
            hintStyle: const TextStyle(fontSize: 14),
            contentPadding:
                const EdgeInsets.symmetric(vertical: 0, horizontal: 25),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: const BorderSide(color: AppColor.grey, width: 2),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide:
                  const BorderSide(color: AppColor.primaryColor, width: 2),
            ),
            suffixIcon: InkWell(
              onTap: onTapIcon,
              child: Icon(iconData,
                  color: /* controller.isIamSelected[id!]*/
                      /*?*/ AppColor.primaryColor
                  /*: AppColor.grey,*/
                  ),
            ),
            hintText: hintText,
          ),
        ),
      ],
    );
  }
}
