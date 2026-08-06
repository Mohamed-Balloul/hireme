import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hireme/controller/company/editcompanyprofileinfo_controller.dart';
import 'package:hireme/core/class/handlingdataview.dart';
import 'package:hireme/core/constant/color.dart';
import 'package:hireme/core/functions/validinput.dart';
import 'package:hireme/view/widget/student/buildsectioncard.dart';
import 'package:hireme/view/widget/student/buildtextfield.dart';

class EditCompanyProfileInfo extends StatelessWidget {
  const EditCompanyProfileInfo({super.key});

  @override
  Widget build(BuildContext context) {
    //
    EditCompanyProfileControllerImp controller =
        Get.put(EditCompanyProfileControllerImp());

    return Scaffold(
        backgroundColor: const Color(0xFFF9F9F9),
        appBar: AppBar(
          title: const Text("تعديل معلومات البروفايل",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          centerTitle: true,
          backgroundColor: Colors.white,
          elevation: 0.5,
          foregroundColor: Colors.black,
          actions: [
            TextButton(
              onPressed: () => controller.saveAll(),
              child: const Text("حفظ",
                  style: TextStyle(
                      color: AppColor.primaryColor,
                      fontWeight: FontWeight.bold)),
            )
          ],
        ),
        body: GetBuilder<EditCompanyProfileControllerImp>(
          builder: (controller) => HandlingDataRequest(
            statusRequest: controller.statusRequest,
            widget: Form(
              key: controller.formState,
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    // 1. القسم الأول: المعلومات العامة
                    BuildSectionCard(
                      title: "المعلومات العامة",
                      icon: Icons.person_outline,
                      children: [
                        BuildTextField(
                          valid: (val) {
                            return validInput(val!, 1, 30, "all");
                          },
                          label: "اسم الشركة",
                          controller: controller.nameController,
                          icon: Icons.person,
                          keyboardType: TextInputType.text,
                        ),
                        BuildTextField(
                          valid: (val) {
                            return validInput(val!, 1, 100, "all");
                          },
                          label: "مجال الشركة",
                          controller: controller.industryController,
                          icon: Icons.work_outline,
                          keyboardType: TextInputType.text,
                        ),
                        BuildTextField(
                          valid: (val) {
                            return validInput(val!, 1, 1000, "all");
                          },
                          label: "النبذة التعريفية",
                          controller: controller.bioController,
                          icon: Icons.description,
                          // maxLines: 3

                          keyboardType: TextInputType.text,
                        ),
                        // BuildTextField(
                        //     valid: (val) {
                        //       return validInput(val!, 10, 100, "email");
                        //     },
                        //     label: "البريد الإلكتروني",
                        //     controller: controller.emailController,
                        //     icon: Icons.email_outlined,
                        //     keyboardType: TextInputType.emailAddress),
                        BuildTextField(
                            valid: (val) {
                              return validInput(val!, 10, 20, "phone");
                            },
                            label: "رقم الهاتف",
                            controller: controller.phoneController,
                            icon: Icons.phone_android,
                            keyboardType: TextInputType.phone),
                        // BuildTextField(
                        //   valid: (val) {
                        //     return validInput(val!, 1, 100, "all");
                        //   },
                        //   label: "مقر الشركة",
                        //   controller: controller.headquartersController,
                        //   icon: Icons.location_on_outlined,
                        //   keyboardType: TextInputType.text,
                        // ),
                      ],
                    ),

                    // 2. القسم الثاني: الإحصائيات والروابط
                    BuildSectionCard(
                      title: "المزيد عن الشركة",
                      icon: Icons.bar_chart,
                      children: [
                        BuildTextField(
                            valid: (val) {
                              return validInput(val!, 1, 100, "all");
                            },
                            label: "عدد الموظفين",
                            controller: controller.companySizeController,
                            icon: Icons.monetization_on_outlined,
                            keyboardType: TextInputType.number),
                        BuildTextField(
                            valid: (val) {
                              return validInput(val!, 4, 4, "all");
                            },
                            label: "سنة التأسيس",
                            controller: controller.foundedYearController,
                            icon: Icons.work_history_outlined,
                            keyboardType: TextInputType.number),
                      ],
                    ),

                    // 3. القسم الثالث: المهارات (إضافة وحذف)
                    BuildSectionCard(
                      title: "التقنيات المستخدمة",
                      icon: Icons.psychology_outlined,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: BuildTextField(
                                valid: (val) {
                                  if (val == null || val.trim().isEmpty) {
                                    return null; // يسمح بحفظ البيانات إذا تُرك الحقل فارغاً
                                  }
                                  return validInput(val!, 1, 30, "all");
                                },
                                label: "أضف مهارة جديدة",
                                controller: controller.skillInputController,
                                icon: Icons.star_border,
                                keyboardType: TextInputType.text,
                              ),
                            ),
                            IconButton(
                              onPressed: () => controller.addSkill(),
                              icon: const Icon(Icons.add_circle,
                                  color: AppColor.primaryColor, size: 30),
                            )
                          ],
                        ),
                        GetBuilder<EditCompanyProfileControllerImp>(
                            builder: (_) {
                          return Wrap(
                            spacing: 8,
                            children:
                                controller.skills.asMap().entries.map((entry) {
                              return Chip(
                                label: Text(entry.value,
                                    style: const TextStyle(fontSize: 12)),
                                onDeleted: () =>
                                    controller.removeSkill(entry.key),
                                backgroundColor: Colors.blue.withOpacity(0.1),
                                deleteIconColor: Colors.red,
                              );
                            }).toList(),
                          );
                        }),
                      ],
                    ),

                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
