import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hireme/controller/customer/editcustomerpost_controller.dart';
import 'package:hireme/core/constant/color.dart';
import 'package:hireme/data/model/attachedfileitemmodel.dart';

class DynamicFilesList extends StatelessWidget {
  final List<AttachedFileItemModel> controllers;
  final String hint;
  const DynamicFilesList(
      {super.key, required this.controllers, required this.hint});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<EditCustomerPostControllerImp>(builder: (controller) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: controllers.length,
            separatorBuilder: (context, index) => const SizedBox(height: 8),
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(top: 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      flex: 1,
                      child: Column(
                        children: [
                          controller
                              .getFileIcon(controllers[index].file.extension),
                          Text(
                            controllers[index].file.name,
                            textAlign: TextAlign.center,
                            maxLines: 1, // سطر واحد فقط
                            overflow: TextOverflow
                                .ellipsis, // وضع نقاط (...) إذا كان الاسم طويلاً
                            style: const TextStyle(
                                fontSize: 10, color: Colors.grey),
                          )
                        ],
                      ),
                    ),
                    // // الترقيم التلقائي (1، 2، 3...)
                    // Text("${index + 1}- ",
                    //     style: const TextStyle(fontWeight: FontWeight.bold)),
                    Expanded(
                      flex: 3,
                      child: TextField(
                        maxLines: null,
                        keyboardType: TextInputType.multiline,
                        controller: controllers[index].descriptionController,
                        decoration: InputDecoration(
                          hintStyle: const TextStyle(fontSize: 14),
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 0, horizontal: 25),
                          border: OutlineInputBorder(
                            // borderRadius: BorderRadius.circular(30),
                            borderSide: const BorderSide(
                                color: AppColor.grey, width: 2),
                          ),
                          focusedBorder: OutlineInputBorder(
                            // borderRadius: BorderRadius.circular(30),
                            borderSide: const BorderSide(
                                color: AppColor.primaryColor, width: 2),
                          ),
                          // suffixIcon: InkWell(
                          //   // onTap: onTapIcon,
                          //   child: Icon(
                          //     // iconData,
                          //     Icons.task,
                          //     color: AppColor.grey,
                          //   ),
                          // ),
                          hintText: hint,
                        ),
                      ),
                    ),
                    // زر الحذف (يظهر فقط إذا كان هناك أكثر من حقل)
                    if (controllers.length > 0)
                      Expanded(
                        child: IconButton(
                            icon: const Icon(
                              Icons.delete,
                              // color: Colors.red,
                              size: 18,
                            ),
                            onPressed: () =>
                                // controller.removeField(controllers, index),
                                controller.removeFile(index)),
                      ),
                  ],
                ),
              );
            },
          ),
          const SizedBox(height: 20),
        ],
      );
    });
  }
}
