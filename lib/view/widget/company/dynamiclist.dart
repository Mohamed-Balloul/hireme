import 'package:flutter/material.dart';
import 'package:hireme/core/constant/color.dart';
import 'package:hireme/interfaces/dynamiclist_interface.dart';

class DynamicList extends StatelessWidget {
  final List<TextEditingController> controllers;
  final String hint;
  final DynamicListInterface
      dynamicList; // هنا السحر! نستقبل الانترفيس بدلاً من المتحكم
  const DynamicList(
      {super.key,
      required this.controllers,
      required this.hint,
      required this.dynamicList});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: controllers.length,
          separatorBuilder: (context, index) => const SizedBox(height: 8),
          itemBuilder: (context, index) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // // الترقيم التلقائي (1، 2، 3...)
                // Text("${index + 1}- ",
                //     style: const TextStyle(fontWeight: FontWeight.bold)),
                Expanded(
                  flex: 8,
                  child: TextField(
                    maxLines: null,
                    keyboardType: TextInputType.multiline,
                    controller: controllers[index],
                    decoration: InputDecoration(
                      hintStyle: const TextStyle(fontSize: 14),
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 0, horizontal: 25),
                      border: OutlineInputBorder(
                        // borderRadius: BorderRadius.circular(30),
                        borderSide:
                            const BorderSide(color: AppColor.grey, width: 2),
                      ),
                      focusedBorder: OutlineInputBorder(
                        // borderRadius: BorderRadius.circular(30),
                        borderSide: const BorderSide(
                            color: AppColor.primaryColor, width: 2),
                      ),
                      suffixIcon: InkWell(
                        // onTap: onTapIcon,
                        child: Icon(
                          // iconData,
                          Icons.task,
                          color: AppColor.grey,
                        ),
                      ),
                      hintText: hint,
                    ),
                    // decoration: InputDecoration(
                    //   hintText: hint,
                    //   contentPadding: const EdgeInsets.symmetric(
                    //       horizontal: 10, vertical: 5),
                    //   border: const OutlineInputBorder(),
                    // ),
                  ),
                ),
                // زر الحذف (يظهر فقط إذا كان هناك أكثر من حقل)
                if (controllers.length > 1)
                  Expanded(
                    child: IconButton(
                      icon: const Icon(
                        Icons.delete,
                        // color: Colors.red,
                        size: 18,
                      ),
                      onPressed: () =>
                          dynamicList.removeField(controllers, index),
                    ),
                  ),
              ],
            );
          },
        ),
        // // زر الإضافة (يظهر فقط إذا لم نصل للحد الأقصى 5)
        // if (controllers.length < 5)
        //   Align(
        //     alignment: Alignment.centerLeft,
        //     child: TextButton.icon(
        //       onPressed: () => controller.addField(controllers),
        //       icon: const Icon(Icons.add),
        //       label: const Text("إضافة سطر جديد"),
        //     ),
        //   ),
        const SizedBox(height: 20),
      ],
    );
    ;
  }
}
