import 'package:hireme/controller/company/addcompanypost_controller.dart';
import 'package:hireme/core/class/handlingdataview.dart';
import 'package:hireme/core/constant/color.dart';
import 'package:hireme/core/functions/validinput.dart';
import 'package:hireme/view/widget/auth/custombuttonauth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hireme/view/widget/company/customtextformwithlabel.dart';
import 'package:hireme/view/widget/company/dynamiclist.dart';
import 'package:hireme/view/widget/company/fieldlabel.dart';

class AddCompanyPost extends StatelessWidget {
  const AddCompanyPost({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(
      AddCompanyPostControllerImp(),
    );

    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: const Text(
          "إضافة إعلان",
          style: TextStyle(),
        ),
        foregroundColor: Colors.white,
        centerTitle: true,
        backgroundColor: AppColor.primaryColor,
      ),
      body: GetBuilder<AddCompanyPostControllerImp>(
        builder: (controller) => HandlingDataRequest(
          // أضف هذه الويجت هنا
          statusRequest: controller.statusRequest,
          widget: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Form(
              key: controller.formState,
              child: ListView(
                children: [
                  // const Column(
                  //   children: [
                  //     Padding(
                  //       padding: EdgeInsets.only(
                  //         bottom: 8,
                  //         top: 40,
                  //       ),
                  //       child: CustomTextTitleAuth(
                  //         text: "إضافة إعلان",
                  //       ),
                  //     ),
                  //   ],
                  // ),
                  //--
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                          bottom: 15,
                          top: 15,
                        ),
                        child: CustomTextFormWithLablel(
                          valid: (val) {
                            return validInput(val!, 6, 30, "username");
                          },
                          mycontroller: controller.titleController,
                          labelText: "المسمى الوظيفي",
                          hintText: "ادخل المسمى الوظيفي",
                          iconData: Icons.person_outline,
                          isNumber: false,
                        ),
                      ),
                      //--
                      Padding(
                        padding: const EdgeInsets.only(
                          bottom: 15,
                        ),
                        child: CustomTextFormWithLablel(
                          valid: (val) {
                            return validInput(val!, 6, 150, "username");
                          },
                          mycontroller: controller.descriptionController,
                          labelText: "وصف الإعلان",
                          hintText: "ادخل وصفاً للإعلان",
                          iconData: Icons.description,
                          isNumber: false,
                        ),
                      ),
                      //--

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
                                  label: "المهام الرئيسية",
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
                                        Text("إضافة مهمة جديدة")
                                      ],
                                    ),
                                  )
                              ],
                            ),
                          ),
                          DynamicList(
                            controllers: controller.dutiesControllers,
                            hint: "أدخل المهمة هنا",
                            dynamicList: controller,
                          ),
                        ],
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
                                  label: "المتطلبات",
                                ),
                                // زر الإضافة (يظهر فقط إذا لم نصل للحد الأقصى 5)
                                if (controller.requirementsControllers.length <
                                    5)
                                  InkWell(
                                    onTap: () {
                                      controller.addField(
                                          controller.requirementsControllers);
                                    },
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.add,
                                          size: 15,
                                        ),
                                        Text("إضافة متطلب جديد")
                                      ],
                                    ),
                                  )
                              ],
                            ),
                          ),
                          DynamicList(
                            controllers: controller.requirementsControllers,
                            hint: "أدخل المتطلب هنا",
                            dynamicList: controller,
                          ),
                        ],
                      ),
                      Column(
                        // crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(bottom: 5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                FieldLablel(
                                  label: "الميزات",
                                ),
                                // زر الإضافة (يظهر فقط إذا لم نصل للحد الأقصى 5)
                                if (controller.featuresControllers.length < 5)
                                  InkWell(
                                    onTap: () {
                                      controller.addField(
                                          controller.featuresControllers);
                                    },
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.add,
                                          size: 15,
                                        ),
                                        Text("إضافة ميزة جديد")
                                      ],
                                    ),
                                  )
                              ],
                            ),
                          ),
                          DynamicList(
                            controllers: controller.featuresControllers,
                            hint: "أدخل الميزة هنا",
                            dynamicList: controller,
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          bottom: 15,
                        ),
                        child: CustomTextFormWithLablel(
                          valid: (val) {
                            return validInput(val!, 6, 30, "username");
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
                      const Divider(
                        thickness: 1.5,
                        color: AppColor.greenblack,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8),
                        child: const Text(
                          "يرجى تحديد الملفات والمستندات التي يجب على المتقدم تزويدكم بها:",
                          style: TextStyle(
                            // fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),

                      CheckboxListTile(
                        activeColor: AppColor.primaryColor,
                        // checkColor: AppColor.greenblack,
                        title: const Text("السيرة الذاتية (CV)"),
                        value: controller.reqCVIsChecked,
                        onChanged: (value) {
                          controller.onCvCheck(value);
                        },
                        // onChanged: (val) => setState(() => reqCV = val!),
                      ),
                      CheckboxListTile(
                        activeColor: AppColor.primaryColor,
                        // checkColor: AppColor.greenblack,
                        title: const Text("رابط GitHub أو Portfolio"),
                        value: controller.reqPortfolioIsChecked,
                        onChanged: (value) {
                          controller.onGitHubOrPortfolioCheck(value);
                        },
                        // onChanged: (val) => setState(() => reqPortfolio = val!),
                      ),
                      CheckboxListTile(
                        activeColor: AppColor.primaryColor,
                        // checkColor: AppColor.greenblack,
                        title: const Text("أمثلة على أعمال سابقة"),
                        value: controller.reqSamplesIsChecked,
                        onChanged: (value) {
                          controller.onPreSamplesCheck(value);
                        },
                        // onChanged: (val) => setState(() => reqSamples = val!),
                      ),
                      CheckboxListTile(
                        title: const Text("الراتب المتوقع"),
                        activeColor: AppColor.primaryColor,
                        // checkColor: AppColor.greenblack,
                        value: controller.reqSalaryIsChecked,
                        onChanged: (value) {
                          controller.onSalaryCheck(value);
                        },
                        // onChanged: (val) => setState(() => reqSalary = val!),
                      ),

                      const SizedBox(height: 30),
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
                        controller.createCompanyPost();
                      },
                    ),
                  ),
                  //--
                ],
              ),
            ),
          ),
        ),
      ),
    ));
  }
}
