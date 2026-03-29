import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hireme/controller/company/editcompanyprofileinfo_controller.dart';
import 'package:hireme/core/constant/color.dart';
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
                    color: AppColor.primaryColor, fontWeight: FontWeight.bold)),
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // 1. القسم الأول: المعلومات العامة
            BuildSectionCard(
              title: "المعلومات العامة",
              icon: Icons.person_outline,
              children: [
                BuildTextField(
                  label: "اسم الشركة",
                  controller: controller.nameController,
                  icon: Icons.person,
                  keyboardType: TextInputType.text,
                ),
                BuildTextField(
                  label: "مجال الشركة",
                  controller: controller.industryController,
                  icon: Icons.work_outline,
                  keyboardType: TextInputType.text,
                ),
                BuildTextField(
                  label: "النبذة التعريفية",
                  controller: controller.bioController,
                  icon: Icons.description,
                  // maxLines: 3

                  keyboardType: TextInputType.text,
                ),
                BuildTextField(
                    label: "البريد الإلكتروني",
                    controller: controller.emailController,
                    icon: Icons.email_outlined,
                    keyboardType: TextInputType.emailAddress),
                BuildTextField(
                    label: "رقم الهاتف",
                    controller: controller.phoneController,
                    icon: Icons.phone_android,
                    keyboardType: TextInputType.phone),
                BuildTextField(
                  label: "مقر الشركة",
                  controller: controller.headquartersController,
                  icon: Icons.location_on_outlined,
                  keyboardType: TextInputType.text,
                ),
              ],
            ),

            // 2. القسم الثاني: الإحصائيات والروابط
            BuildSectionCard(
              title: "المزيد عن الشركة",
              icon: Icons.bar_chart,
              children: [
                BuildTextField(
                    label: "عدد الموظفين",
                    controller: controller.companySizeController,
                    icon: Icons.monetization_on_outlined,
                    keyboardType: TextInputType.number),
                BuildTextField(
                    label: "سنة التأسيس",
                    controller: controller.foundedYearController,
                    icon: Icons.work_history_outlined,
                    keyboardType: TextInputType.number),
                // BuildTextField(
                //     label: "رابط GitHub",
                //     controller: controller.githubController,
                //     keyboardType: TextInputType.text,
                //     icon: Icons.code),
                // BuildTextField(
                //     label: "رابط LinkedIn",
                //     controller: controller.linkedinController,
                //     keyboardType: TextInputType.text,
                //     icon: Icons.link),
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
                GetBuilder<EditCompanyProfileControllerImp>(builder: (_) {
                  return Wrap(
                    spacing: 8,
                    children: controller.skills.asMap().entries.map((entry) {
                      return Chip(
                        label: Text(entry.value,
                            style: const TextStyle(fontSize: 12)),
                        onDeleted: () => controller.removeSkill(entry.key),
                        backgroundColor: Colors.blue.withOpacity(0.1),
                        deleteIconColor: Colors.red,
                      );
                    }).toList(),
                  );
                }),
              ],
            ),

            // 4. القسم الرابع: التعليم
            // BuildSectionCard(
            //   title: "التعليم",
            //   icon: Icons.school_outlined,
            //   children: [
            //     GetBuilder<EditCompanyProfileControllerImp>(builder: (_) {
            //       return SwitchListTile(
            //         title:
            //             const Text("هل تخرجت؟", style: TextStyle(fontSize: 14)),
            //         value: controller.isGraduated,
            //         activeColor: AppColor.primaryColor,
            //         onChanged: (val) {
            //           controller.isGraduated = val;
            //           controller.update();
            //         },
            //       );
            //     }),
            //     BuildTextField(
            //       label: "اسم الكلية",
            //       controller: controller.collegeController,
            //       icon: Icons.account_balance,
            //       keyboardType: TextInputType.text,
            //     ),
            //     BuildTextField(
            //         label: "اسم الجامعة",
            //         controller: controller.uniController,
            //         keyboardType: TextInputType.text,
            //         icon: Icons.location_city),
            //   ],
            // ),

            // const SizedBox(height: 20),
            // استبدل ListTile القديم الخاص بالخبرة المهنية بهذا القسم:

            // BuildSectionCard(
            //   title: "الخبرة المهنية",
            //   icon: Icons.business_center_outlined,
            //   children: [
            //     // 1. قائمة الخبرات المضافة حالياً
            //     GetBuilder<EditCompanyProfileControllerImp>(
            //         builder: (controller) {
            //       return Column(
            //         children:
            //             controller.workExperiences.asMap().entries.map((entry) {
            //           int idx = entry.key;
            //           var exp = entry.value;
            //           return Stack(
            //             children: [
            //               BuildExperienceCard(exp: exp),
            //               // _buildExperiencePreview(
            //               //     exp), // دالة بناء شكل الكارد (مشابهة للأصلية)
            //               Positioned(
            //                 left: -5,
            //                 bottom: 8,
            //                 child: IconButton(
            //                   icon: const Icon(Icons.delete_forever,
            //                       size: 19, color: Colors.black26),
            //                   // onPressed: () => controller.removeExperience(idx),
            //                   onPressed: () {
            //                     ProfileDialogs.showConfirmDialog(
            //                       title:
            //                           "هل أنت متأكد أنك تريد حذف هذه التجربة؟",
            //                       onConfirm: () =>
            //                           controller.removeExperience(idx),
            //                     );
            //                   },
            //                 ),
            //               ),
            //             ],
            //           );
            //         }).toList(),
            //       );
            //     }),

            //     const Divider(height: 40, thickness: 1),
            //     const Text("إضافة تجربة جديدة",
            //         style: TextStyle(
            //             fontWeight: FontWeight.bold,
            //             fontSize: 13,
            //             color: AppColor.primaryColor)),
            //     const SizedBox(height: 15),

            //     // 2. نموذج إضافة تجربة جديدة
            //     GetBuilder<EditCompanyProfileControllerImp>(
            //         builder: (controller) {
            //       return Center(
            //         child: Stack(
            //           children: [
            //             Container(
            //               width: 80,
            //               height: 80,
            //               decoration: BoxDecoration(
            //                 color: Colors.grey[100],
            //                 borderRadius: BorderRadius.circular(15),
            //                 border: Border.all(color: Colors.grey.shade300),
            //               ),
            //               child: controller.tempExperienceLogo != null
            //                   ? ClipRRect(
            //                       borderRadius: BorderRadius.circular(15),
            //                       child: Image.file(
            //                           controller.tempExperienceLogo!,
            //                           fit: BoxFit.cover))
            //                   : const Icon(Icons.business,
            //                       size: 40, color: Colors.grey),
            //             ),
            //             if (controller.tempExperienceLogo != null)
            //               Positioned(
            //                 top: 0,
            //                 right: 0,
            //                 child: InkWell(
            //                   onTap: () {
            //                     ProfileDialogs.showConfirmDialog(
            //                       title: "هل أنت متأكد أنك تريد حذف الصورة؟",
            //                       onConfirm: () =>
            //                           controller.deleteExperienceLogo(),
            //                     );
            //                   },
            //                   child: CircleAvatar(
            //                     radius: 12,
            //                     backgroundColor: AppColor.primaryColor,
            //                     child: const Icon(Icons.close,
            //                         size: 14, color: Colors.white),
            //                   ),
            //                 ),
            //               ),
            //             Positioned(
            //               bottom: 0,
            //               left: 0,
            //               child: InkWell(
            //                 onTap: () => controller.pickExperienceLogo(),
            //                 child: CircleAvatar(
            //                   radius: 12,
            //                   backgroundColor: AppColor.primaryColor,
            //                   child: const Icon(Icons.camera_alt,
            //                       size: 14, color: Colors.white),
            //                 ),
            //               ),
            //             )
            //           ],
            //         ),
            //       );
            //     }),
            //     const SizedBox(height: 20),
            //     BuildTextField(
            //         label: "اسم الشركة / Freelancer",
            //         controller: controller.companyController,
            //         keyboardType: TextInputType.text,
            //         icon: Icons.apartment),
            //     GetBuilder<EditCompanyProfileControllerImp>(
            //         builder: (controller) {
            //       return CheckboxListTile(
            //         title: const Text("Freelancer Work",
            //             style: TextStyle(fontSize: 12)),
            //         value: controller.isFreelancer,
            //         onChanged: (val) {
            //           controller.isFreelancer = val!;
            //           controller.update();
            //         },
            //         controlAffinity: ListTileControlAffinity.leading,
            //         contentPadding: EdgeInsets.zero,
            //       );
            //     }),
            //     BuildTextField(
            //       label: "المسمى الوظيفي",
            //       controller: controller.jobTitleController,
            //       icon: Icons.badge_outlined,
            //       keyboardType: TextInputType.text,
            //     ),

            //     // اختيار التواريخ
            //     Row(
            //       children: [
            //         Expanded(
            //           child: GetBuilder<EditCompanyProfileControllerImp>(
            //               builder: (controller) {
            //             return BuildDateTile(
            //               label: "تاريخ بدء العمل",
            //               date: controller.startDate,
            //               onTap: () => controller.selectDate(context, true),
            //             );
            //           }),
            //         ),
            //         const SizedBox(width: 10),
            //         Expanded(
            //           child: GetBuilder<EditCompanyProfileControllerImp>(
            //               builder: (_) {
            //             return controller.isCurrentWork
            //                 ? Container(
            //                     height: 55,
            //                     decoration: BoxDecoration(
            //                         color: Colors.grey[50],
            //                         borderRadius: BorderRadius.circular(12)),
            //                     child: const Center(
            //                         child: Text("حتى الآن",
            //                             style: TextStyle(color: Colors.grey))),
            //                   )
            //                 : BuildDateTile(
            //                     label: "تاريخ نهاية العمل",
            //                     date: controller.endDate,
            //                     onTap: () =>
            //                         controller.selectDate(context, false),
            //                   );
            //           }),
            //         ),
            //       ],
            //     ),
            //     GetBuilder<EditCompanyProfileControllerImp>(builder: (_) {
            //       return CheckboxListTile(
            //         title: const Text("أعمل هنا حالياً",
            //             style: TextStyle(fontSize: 12)),
            //         value: controller.isCurrentWork,
            //         onChanged: (val) {
            //           controller.isCurrentWork = val!;
            //           controller.update();
            //         },
            //         controlAffinity: ListTileControlAffinity.leading,
            //         contentPadding: EdgeInsets.zero,
            //       );
            //     }),

            //     const SizedBox(height: 10),
            //     GetBuilder<EditCompanyProfileControllerImp>(builder: (_) {
            //       return SizedBox(
            //         width: double.infinity,
            //         child: ElevatedButton(
            //           onPressed: controller.isExperienceValid
            //               ? () => controller.addExperience()
            //               : null,
            //           style: ElevatedButton.styleFrom(
            //             backgroundColor: AppColor.primaryColor,
            //             disabledBackgroundColor: Colors.grey[300],
            //             shape: RoundedRectangleBorder(
            //                 borderRadius: BorderRadius.circular(10)),
            //           ),
            //           child: const Text("إضافة التجربة للقائمة",
            //               style: TextStyle(color: Colors.white)),
            //         ),
            //       );
            //     }),
            //   ],
            // ),
            const SizedBox(height: 20),
          ],
        ),
      ),
      // ),
    );
  }
}
