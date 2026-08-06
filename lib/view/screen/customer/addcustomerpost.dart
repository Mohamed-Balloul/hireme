import 'package:hireme/controller/customer/addcustomerpost_controller.dart';
import 'package:hireme/core/class/handlingdataview.dart';
import 'package:hireme/core/constant/color.dart';
import 'package:hireme/core/functions/validinput.dart';
import 'package:hireme/view/widget/auth/custombuttonauth.dart';
import 'package:hireme/view/widget/auth/customtexttitleauth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hireme/view/widget/company/customtextformwithlabel.dart';
import 'package:hireme/view/widget/customer/dynamicfileslist.dart';
import 'package:hireme/view/widget/customer/dynamiclist.dart';
import 'package:hireme/view/widget/company/fieldlabel.dart';

class AddCustomerPost extends StatelessWidget {
  const AddCustomerPost({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(
      AddCustomerPostControllerImp(),
    );

    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: const Text(
          "إضافة إعلان",
        ),
        foregroundColor: Colors.white,
        centerTitle: true,
        backgroundColor: AppColor.primaryColor,
      ),
      body: GetBuilder<AddCustomerPostControllerImp>(
        builder: (controller) =>
            //--
            HandlingDataRequest(
          // أضف هذه الويجت هنا
          statusRequest: controller.statusRequest,
          widget: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Form(
              key: controller.formState,
              child: ListView(
                children: [
                  //--
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                          bottom: 15,
                          top: 15,
                        ),
                        child: CustomTextFormWithLablel(
                          valid: (val) {
                            return validInput(val!, 1, 100, "description");
                          },
                          mycontroller: controller.titleController,
                          labelText: "اسم الخدمة المطلوبة",
                          hintText: "ادخل المسمى هنا",
                          iconData: Icons.person_outline,
                          isNumber: false,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          bottom: 15,
                        ),
                        child: CustomTextFormWithLablel(
                          valid: (val) {
                            return validInput(val!, 6, 1000, "description");
                          },
                          mycontroller: controller.descriptionController,
                          labelText: "وصف الخدمة",
                          hintText: "ادخل الوصف هنا",
                          iconData: Icons.description,
                          isNumber: false,
                        ),
                      ),

                      //--
                      Column(
                        // crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(bottom: 5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                FieldLablel(
                                  label: "الأدوات المطلوب استخدامها",
                                ),
                                // زر الإضافة (يظهر فقط إذا لم نصل للحد الأقصى 5)
                                if (controller.dutiesControllers.length < 5)
                                  InkWell(
                                    onTap: () {
                                      controller.addField(
                                          controller.dutiesControllers);
                                    },
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.add,
                                          size: 15,
                                        ),
                                        Text("إضافة أداة جديدة")
                                      ],
                                    ),
                                  )
                              ],
                            ),
                          ),
                          DynamicList(
                              controllers: controller.dutiesControllers,
                              hint: "أدخل المسمى هنا"),
                        ],
                      ),

                      Padding(
                        padding: const EdgeInsets.only(
                          bottom: 15,
                        ),
                        child: CustomTextFormWithLablel(
                          valid: (val) {
                            return validInput(val!, 6, 100, "description");
                          },
                          mycontroller: controller.detailsController,
                          labelText: "تفاصيل إضافية",
                          hintText: "ادخل التفاصيل هنا",
                          iconData: Icons.description,
                          isNumber: false,
                        ),
                      ),
                      //--
                      // --- القسم السادس: المستندات المطلوبة ---
                      // const Divider(
                      //   thickness: 1.5,
                      //   color: AppColor.greenblack,
                      // ),

                      // Column(
                      //   // crossAxisAlignment: CrossAxisAlignment.start,
                      //   children: [
                      //     Padding(
                      //       padding: const EdgeInsets.only(bottom: 5),
                      //       child: Row(
                      //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //         children: [
                      //           FieldLablel(
                      //             label: "الملفات المرفقة:",
                      //           ),
                      //           // زر الإضافة (يظهر فقط إذا لم نصل للحد الأقصى 5)
                      //           if (controller.attachedFiles.length < 5)
                      //             InkWell(
                      //               onTap: () {
                      //                 controller.pickAndAddFile();
                      //               },
                      //               child: Row(
                      //                 children: [
                      //                   Icon(
                      //                     Icons.add,
                      //                     size: 15,
                      //                   ),
                      //                   Text("إضافة ملف جديد")
                      //                 ],
                      //               ),
                      //             )
                      //         ],
                      //       ),
                      //     ),
                      //     DynamicFilesList(
                      //         controllers: controller.attachedFiles,
                      //         hint: "أدخل وصف للملف"),
                      //   ],
                      // ),
                      const SizedBox(height: 30),
                      //--

                      //--
                    ],
                  ),

                  //--
                  Padding(
                    padding: const EdgeInsets.only(
                      bottom: 25,
                    ),
                    child: CustomButtonAuth(
                      text: "نشر",
                      onPressed: () {
                        controller.createCustomerPost();
                      },
                    ),
                  ),
                  //--
                ],
              ),
            ),
          ),
        ),
        //--
      ),
    ));
  }
}
