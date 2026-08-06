import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hireme/controller/customer/customersearch_controller.dart';
import 'package:hireme/controller/customer/customersavedstudents_controller.dart';
import 'package:hireme/core/constant/color.dart';
import 'package:hireme/data/model/studentprofilemodel.dart';
import 'package:hireme/view/widget/company/infoitem.dart';
import 'package:hireme/view/widget/company/separator.dart';

class StudentCard extends StatelessWidget {
  final StudentProfileModel studentProfileModel;
  final int ind;
  const StudentCard(
      {super.key, required this.studentProfileModel, required this.ind});

  @override
  Widget build(BuildContext context) {
    // استخدم Get.find بدلاً من put لضمان استخدام نفس النسخة الموجودة في الذاكرة
    CustomerSearchControllerImp controller =
        Get.find<CustomerSearchControllerImp>();

    return Container(
      height: 155, // <<< إضافة ارتفاع ثابت للبطاقة يحل المشكلة فوراً
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.15),
            spreadRadius: 2,
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: Row(
          children: [
            // === الجزء الأول: الصورة (يمين) ===
            Expanded(
              flex: 4,
              child: Stack(
                children: [
                  Positioned.fill(
                    child: Image.network(
                      studentProfileModel.image!,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      height: 60,
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                        colors: [
                          Colors.black.withOpacity(0.6),
                          Colors.transparent
                        ],
                      )),
                    ),
                  )
                ],
              ),
            ),

            // === الجزء الثاني: المعلومات (يسار) ===
            Expanded(
              flex: 6,
              child: Padding(
                // padding: const EdgeInsets.all(12),
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            const Icon(Icons.star,
                                color: Colors.amber, size: 14),
                            const SizedBox(width: 2),
                            Text(
                              "${studentProfileModel.rating!}",
                              style: const TextStyle(
                                  fontSize: 12, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        // _buildCircleBtn(Icons.bookmark_border, AppColor.grey),
                        // يمكنك إضافة حالة "نشط" هنا مثلاً
                        IconButton(
                          icon:
                              const Icon(Icons.more_horiz, color: Colors.grey),
                          onPressed: () {
                            // فتح قائمة تعديل أو حذف البوست
                            Get.bottomSheet(
                              Container(
                                color: Colors.white,
                                child: Wrap(
                                  children: [
                                    ListTile(
                                      leading: Get.find<
                                                  CustomerSavedStudentsControllerImp>()
                                              .isSaved(studentProfileModel)
                                          ? const Icon(
                                              Icons.bookmark_remove_outlined)
                                          : const Icon(
                                              Icons.bookmark_add_outlined),
                                      title: Get.find<
                                                  CustomerSavedStudentsControllerImp>()
                                              .isSaved(studentProfileModel)
                                          ? const Text(
                                              "إزالة من الطلاب المحفوظين")
                                          : const Text(
                                              "إضافة إلى الطلاب المحفوظين"),
                                      onTap: () {
                                        Get.back(); // إغلاق القائمة
                                        Get.find<
                                                CustomerSavedStudentsControllerImp>()
                                            .toggleSave(studentProfileModel);
                                      },
                                    ),
                                    // خيارات أخرى...
                                  ],
                                ),
                              ),
                            );
                          },
                        )
                      ],
                    ),

                    const SizedBox(height: 5),

                    Text(
                      studentProfileModel.name!,
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      studentProfileModel.jobLabel!,
                      style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),

                    const SizedBox(height: 10),

                    FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Row(
                        children: [
                          InfoItem(
                              icon: Icons.location_on_outlined,
                              text: studentProfileModel.city!,
                              color: Colors.grey),
                          const Separator(),
                          InfoItem(
                              icon: Icons.monetization_on_outlined,
                              text: "\$${studentProfileModel.hourlySalary!}",
                              color: Colors.green),
                          const Separator(),
                          InfoItem(
                              icon: Icons.work_history_outlined,
                              text:
                                  "${studentProfileModel.experienceYears!} سنة",
                              color: Colors.blue),
                        ],
                      ),
                    ),

                    const Spacer(), // الآن سيعمل الـ Spacer لأن الارتفاع محدد

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            // _buildCircleBtn(
                            // Icons.bookmark_border,
                            // _buildCircleBtn(Icons.chat_bubble_outline,
                            // AppColor.primaryColor),
                            // AppColor.grey),
                            // const SizedBox(width: 8),
                            // _buildCircleBtn(Icons.bookmark_border, Colors.grey),
                          ],
                        ),
                        // زر عرض الملف
                        InkWell(
                          onTap: () {
                            controller.goToStudentProfile(studentProfileModel.id
                                .toString()); // تمرير معرف الطالب إلى الدالة
                          },
                          child: Row(
                            children: const [
                              Text("عرض الملف",
                                  style: TextStyle(
                                      fontSize: 10, // تصغير الخط قليلاً ليناسب
                                      color: AppColor.primaryColor,
                                      fontWeight: FontWeight.bold)),
                              Icon(Icons.arrow_forward_ios,
                                  size: 10, color: AppColor.primaryColor),
                            ],
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCircleBtn(IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color.withOpacity(0.1),
      ),
      child: Icon(icon, size: 16, color: color),
    );
  }
}
