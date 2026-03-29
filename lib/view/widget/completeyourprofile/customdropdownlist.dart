import 'package:hireme/controller/completeyourprofile/completeyourfile_controller.dart';
import 'package:hireme/core/constant/color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// class CustomDropdownList extends StatelessWidget {
class CustomDropdownList extends GetView<CompleteYourProfileControllerImp> {
  final String labelText;
  final String? selectedGender;

  const CustomDropdownList(
      {super.key, required this.labelText, this.selectedGender});

  @override
  Widget build(BuildContext context) {
    // return GetBuilder<CompleteYourProfileControllerImp>(builder: (controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 2),
          child: Text(
            labelText,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        Container(
          padding: const EdgeInsets.only(
            top: 0,
            bottom: 0,
            right: 10,
            left: 25,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            border: Border.all(color: AppColor.grey),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: controller.selectedGender, //
              icon: const Icon(Icons.keyboard_arrow_down_outlined),
              isExpanded: true,
              onChanged: (value) {
                controller.select(value!);
              },
              items: ['Male', 'Female']
                  .map((gender) => DropdownMenuItem(
                        value: gender,
                        child: Text(
                          gender,
                          style: const TextStyle(
                            fontWeight: FontWeight.normal,
                            fontSize: 15,
                          ),
                        ),
                      ))
                  .toList(),
            ),
          ),
        ),
      ],
      // );
      // },
    );
  }
}
