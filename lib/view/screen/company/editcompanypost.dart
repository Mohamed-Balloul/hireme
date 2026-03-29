import 'package:hireme/controller/company/editcompanypost_controller.dart';
import 'package:hireme/core/constant/color.dart';
import 'package:hireme/core/functions/validinput.dart';
import 'package:hireme/view/widget/auth/custombuttonauth.dart';
import 'package:hireme/view/widget/auth/customtexttitleauth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hireme/view/widget/company/customtextformwithlabel.dart';
import 'package:hireme/view/widget/company/dynamiclist.dart';
import 'package:hireme/view/widget/company/fieldlabel.dart';

class EditCompanyPost extends StatelessWidget {
  const EditCompanyPost({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(
      EditCompanyPostControllerImp(),
    );

    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: const Text(
          "تعديل إعلان",
          style: TextStyle(),
        ),
        foregroundColor: Colors.white,
        centerTitle: true,
        backgroundColor: AppColor.primaryColor,
      ),
      body: GetBuilder<EditCompanyPostControllerImp>(
        builder: (controller) => Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Form(
            key: controller.formState,
            child: ListView(
              children: [
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
                                    controller
                                        .addField(controller.dutiesControllers);
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
                            dynamicList: controller)
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
                              if (controller.requirementsControllers.length < 5)
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
                      controller.signUp();
                    },
                  ),
                ),
                //--
              ],
            ),
          ),
        ),
      ),
    ));
  }
}
// //--------------------------
// import 'package:flutter/material.dart';
// import 'package:hireme/view/widget/company/dynamiclist.dart';
// import 'package:hireme/view/widget/company/fieldlabel.dart';

// class AddJobAdScreen extends StatefulWidget {
//   const AddJobAdScreen({Key? key}) : super(key: key);

//   @override
//   State<AddJobAdScreen> createState() => _AddJobAdScreenState();
// }

// class _AddJobAdScreenState extends State<AddJobAdScreen> {
//   // 1. تعريف المتحكمات للنصوص البسيطة
//   final TextEditingController _titleController = TextEditingController();
//   final TextEditingController _detailsController = TextEditingController();

//   // 2. تعريف قوائم المتحكمات للقوائم المتعددة (المهام، المتطلبات، الميزات)
//   final List<TextEditingController> _dutiesControllers = [TextEditingController()];
//   final List<TextEditingController> _requirementsControllers = [TextEditingController()];
//   final List<TextEditingController> _featuresControllers = [TextEditingController()];

//   // 3. متغيرات للخيارات (Checkboxes)
//   bool _reqCV = false;
//   bool _reqPortfolio = false;
//   bool _reqSamples = false;
//   bool _reqSalary = false;

//   // دالة مساعدة لإضافة حقل جديد للقوائم
//   void _addField(List<TextEditingController> list) {
//     if (list.length < 5) {
//       setState(() {
//         list.add(TextEditingController()); 
//       });
//     }
//   }

//   // دالة مساعدة لحذف حقل من القوائم
//   void _removeField(List<TextEditingController> list, int index) {
//     if (list.length > 1) {
//       setState(() {
//         list[index].dispose(); // تنظيف الذاكرة
//         list.removeAt(index);
//       });
//     }
//   }

//   @override
//   void dispose() {
//     // تنظيف جميع المتحكمات عند إغلاق الشاشة
//     _titleController.dispose();
//     _detailsController.dispose();
//     for (var c in _dutiesControllers) c.dispose();
//     for (var c in _requirementsControllers) c.dispose();
//     for (var c in _featuresControllers) c.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("إضافة إعلان وظيفي"),
//         centerTitle: true,
//       ),
//       // Directionality لضمان اتجاه النص من اليمين لليسار
//       body: Directionality(
//         textDirection: TextDirection.rtl,
//         child: SingleChildScrollView(
//           padding: const EdgeInsets.all(16.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               // --- القسم الأول: المسمى الوظيفي ---
//               _buildSectionLabel("المسمى الوظيفي"),
//               TextField(
//                 controller: _titleController,
//                 decoration: const InputDecoration(
//                   hintText: "مثال: Flutter Developer",
//                   border: OutlineInputBorder(),
//                 ),
//               ),
//               const SizedBox(height: 20),

//               // --- القسم الثاني: المهام الرئيسية (قائمة ديناميكية) ---
//               _buildDynamicListSection(
//                 title: "المهام الرئيسية (بحد أقصى 5)",
//                 controllers: _dutiesControllers,
//                 hint: "أدخل مهمة...",
//               ),

//               // --- القسم الثالث: المتطلبات (قائمة ديناميكية) ---
//               _buildDynamicListSection(
//                 title: "المتطلبات",
//                 controllers: _requirementsControllers,
//                 hint: "أدخل متطلب...",
//               ),

//               // --- القسم الرابع: الميزات (قائمة ديناميكية) ---
//               _buildDynamicListSection(
//                 title: "الميزات",
//                 controllers: _featuresControllers,
//                 hint: "أدخل ميزة...",
//               ),

//               // --- القسم الخامس: تفاصيل إضافية ---
//               _buildSectionLabel("تفاصيل إضافية"),
//               TextField(
//                 controller: _detailsController,
//                 maxLines: 3,
//                 decoration: const InputDecoration(
//                   hintText: "تفاصيل أخرى...",
//                   border: OutlineInputBorder(),
//                 ),
//               ),
//               const SizedBox(height: 20),

//               // --- القسم السادس: المستندات المطلوبة ---
//               const Divider(thickness: 2),
//               const Text(
//                 "يرجى تحديد الملفات والمستندات التي يجب على المتقدم تزويدكم بها:",
//                 style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.grey),
//               ),
//               CheckboxListTile(
//                 title: const Text("السيرة الذاتية (CV)"),
//                 value: _reqCV,
//                 onChanged: (val) => setState(() => _reqCV = val!),
//               ),
//               CheckboxListTile(
//                 title: const Text("رابط GitHub أو Portfolio"),
//                 value: _reqPortfolio,
//                 onChanged: (val) => setState(() => _reqPortfolio = val!),
//               ),
//               CheckboxListTile(
//                 title: const Text("أمثلة على أعمال سابقة"),
//                 value: _reqSamples,
//                 onChanged: (val) => setState(() => _reqSamples = val!),
//               ),
//               CheckboxListTile(
//                 title: const Text("الراتب المتوقع"),
//                 value: _reqSalary,
//                 onChanged: (val) => setState(() => _reqSalary = val!),
//               ),

//               const SizedBox(height: 30),

//               // --- زر النشر ---
//               SizedBox(
//                 width: double.infinity,
//                 child: ElevatedButton(
//                   onPressed: _publishAd,
//                   style: ElevatedButton.styleFrom(
//                     padding: const EdgeInsets.symmetric(vertical: 15),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(20),
//                     ),
//                   ),
//                   child: const Text(
//                     "نشر",
//                     style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   // دالة لبناء الواجهة الخاصة بالقوائم المتكررة (مهام، متطلبات، ميزات)
//   Widget _buildDynamicListSection({
//     required String title,
//     required List<TextEditingController> controllers,
//     required String hint,
//   }) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         _buildSectionLabel(title),
//         ListView.separated(
//           shrinkWrap: true,
//           physics: const NeverScrollableScrollPhysics(),
//           itemCount: controllers.length,
//           separatorBuilder: (context, index) => const SizedBox(height: 8),
//           itemBuilder: (context, index) {
//             return Row(
//               children: [
//                 // الترقيم التلقائي (1، 2، 3...)
//                 Text("${index + 1}- ", style: const TextStyle(fontWeight: FontWeight.bold)),
//                 Expanded(
//                   child: TextField(
//                     controller: controllers[index],
//                     decoration: InputDecoration(
//                       hintText: hint,
//                       contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
//                       border: const OutlineInputBorder(),
//                     ),
//                   ),
//                 ),
//                 // زر الحذف (يظهر فقط إذا كان هناك أكثر من حقل)
//                 if (controllers.length > 1)
//                   IconButton(
//                     icon: const Icon(Icons.remove_circle, color: Colors.red),
//                     onPressed: () => _removeField(controllers, index),
//                   ),
//               ],
//             );
//           },
//         ),
//         // زر الإضافة (يظهر فقط إذا لم نصل للحد الأقصى 5)
//         if (controllers.length < 5)
//           Align(
//             alignment: Alignment.centerLeft,
//             child: TextButton.icon(
//               onPressed: () => _addField(controllers),
//               icon: const Icon(Icons.add),
//               label: const Text("إضافة سطر جديد"),
//             ),
//           ),
//         const SizedBox(height: 20),
//       ],
//     );
//   }

//   // دالة لتنسيق عناوين الأقسام
//   Widget _buildSectionLabel(String text) {
//     return Padding(
//       padding: const EdgeInsets.only(bottom: 8.0),
//       child: Text(
//         text,
//         style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.blueAccent),
//       ),
//     );
//   }

//   // دالة التجميع والنشر (ماذا يحدث عند الضغط على زر نشر)
//   void _publishAd() {
//     // تجميع البيانات لإرسالها لقاعدة البيانات
//     Map<String, dynamic> jobData = {
//       "job_title": _titleController.text,
//       "duties": _dutiesControllers.map((c) => c.text).where((text) => text.isNotEmpty).toList(),
//       "requirements": _requirementsControllers.map((c) => c.text).where((text) => text.isNotEmpty).toList(),
//       "features": _featuresControllers.map((c) => c.text).where((text) => text.isNotEmpty).toList(),
//       "additional_details": _detailsController.text,
//       "required_docs": {
//         "cv": _reqCV,
//         "portfolio": _reqPortfolio,
//         "work_samples": _reqSamples,
//         "salary": _reqSalary,
//       }
//     };

//     print("Data to save: $jobData");
//     // هنا تضع كود الإرسال للـ Backend أو Firebase
//   }
// }