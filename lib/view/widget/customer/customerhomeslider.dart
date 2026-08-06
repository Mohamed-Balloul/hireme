import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:hireme/controller/company/companyhome_controller.dart';
import 'package:hireme/controller/customer/customerhome_controller.dart';
import 'package:hireme/controller/customer/customersavedstudents_controller.dart';
import 'package:hireme/core/class/statusrequest.dart';
import 'package:hireme/core/constant/color.dart';
// import 'package:hireme/data/datasource/static/static.dart';
import 'package:hireme/view/widget/company/infoitem.dart';
import 'package:hireme/view/widget/company/separator.dart';

class HomeSlider extends StatelessWidget {
  const HomeSlider({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CustomerHomeControllerImp>(builder: (controller) {
      //
      // 1. إذا كانت الحالة هي "تحميل" أو القائمة فارغة تماماً
      if (controller.statusRequest == StatusRequest.loading &&
          controller.allStudents!.isEmpty) {
        return Container(
          height: 185, // نفس ارتفاع السلايدر لكي لا يتحرك التصميم عند التحميل
          alignment: Alignment.center,
          child: const CircularProgressIndicator(
            color: AppColor.primaryColor,
          ),
        );
      }

      // 2. إذا فشل التحميل وكانت القائمة فارغة (اختياري لكن احترافي)
      if (controller.statusRequest == StatusRequest.serverfailure) {
        return const SizedBox(
          height: 185,
          child: Center(child: Text("فشل تحميل البيانات")),
        );
      }

      // 3. الحالة الطبيعية: عرض السلايدر

      return Column(
        children: [
          CarouselSlider(
            options: CarouselOptions(
              height: 185,
              autoPlay: true,
              autoPlayInterval: const Duration(seconds: 5),
              enlargeCenterPage: true,
              viewportFraction: 0.9,
              onPageChanged: (index, reason) {
                controller.onChange(index);
              },
            ),
            items: controller.allStudents.map((student) {
              return Container(
                margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
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
                                student.image!,
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
                                    Colors.black.withOpacity(0.5),
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
                          padding: const EdgeInsets.fromLTRB(
                              10, 0, 10, 8), // هوامش متوازنة
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // 1. الهيدر: الحالة + التقييم
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  // Container(
                                  //   padding: const EdgeInsets.symmetric(
                                  //       horizontal: 6, vertical: 2),
                                  //   decoration: BoxDecoration(
                                  //     color: student.isAvailable!
                                  //         ? Colors.green.withOpacity(0.1)
                                  //         : Colors.red.withOpacity(0.1),
                                  //     borderRadius: BorderRadius.circular(4),
                                  //   ),
                                  //   child: Text(
                                  //     student.isAvailable! ? "متاح" : "مشغول",
                                  //     style: TextStyle(
                                  //       fontSize: 10,
                                  //       fontWeight: FontWeight.bold,
                                  //       color: student.isAvailable!
                                  //           ? Colors.green
                                  //           : Colors.red,
                                  //     ),
                                  //   ),
                                  // ),
                                  Row(
                                    children: [
                                      const Icon(Icons.star,
                                          color: Colors.amber, size: 14),
                                      const SizedBox(width: 2),
                                      Text(
                                        "${student.rating!}",
                                        style: const TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                  /*/**/ */
                                  IconButton(
                                    icon: const Icon(Icons.more_horiz,
                                        color: Colors.grey),
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
                                                        .isSaved(student)
                                                    ? const Icon(Icons
                                                        .bookmark_remove_outlined)
                                                    : const Icon(Icons
                                                        .bookmark_add_outlined),
                                                title: Get.find<
                                                            CustomerSavedStudentsControllerImp>()
                                                        .isSaved(student)
                                                    ? const Text(
                                                        "إزالة من الطلاب المحفوظين")
                                                    : const Text(
                                                        "إضافة إلى الطلاب المحفوظين"),
                                                onTap: () {
                                                  Get.back(); // إغلاق القائمة
                                                  Get.find<
                                                          CustomerSavedStudentsControllerImp>()
                                                      .toggleSave(student);
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

                              // const SizedBox(height: 6), // مسافة صغيرة

                              // 2. الاسم والمسمى
                              Text(
                                student.name!,
                                style: const TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black87,
                                    height: 1.1),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              Text(
                                student.jobLabel!,
                                style: TextStyle(
                                  fontSize: 11,
                                  color: Colors.grey[600],
                                  fontWeight: FontWeight.w500,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),

                              const SizedBox(height: 8),

                              // 3. السطر المدمج (الموقع | السعر | الخبرة)
                              // استخدمنا FittedBox لضمان عدم خروج النص عن الحواف
                              FittedBox(
                                fit: BoxFit.scaleDown,
                                alignment: Alignment.centerRight,
                                child: Row(
                                  children: [
                                    InfoItem(
                                        icon: Icons.location_on_outlined,
                                        text: student.city!,
                                        color: Colors.grey),
                                    Separator(),
                                    InfoItem(
                                        icon: Icons.monetization_on_outlined,
                                        text: "\$${student.hourlySalary!}",
                                        color: Colors.green),
                                    Separator(),
                                    InfoItem(
                                        icon: Icons.work_history_outlined,
                                        text:
                                            "${student.experienceYears!} سنوات",
                                        color: Colors.blue),
                                  ],
                                ),
                              ),

                              const SizedBox(height: 8),

                              // 4. المهارات (أول 3 مهارات)
                              Wrap(
                                spacing: 4, // مسافة أفقية بين الكبسولات
                                runSpacing: 4, // مسافة عمودية
                                children: (student.skils! as List<String>)
                                    .take(3) // نأخذ أول 3 فقط
                                    .map((skill) {
                                  return Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 6, vertical: 3),
                                    decoration: BoxDecoration(
                                        color: Colors.grey[100],
                                        borderRadius: BorderRadius.circular(4),
                                        border: Border.all(
                                            color: Colors.grey.shade300)),
                                    child: Text(
                                      skill,
                                      style: TextStyle(
                                          fontSize: 9, color: Colors.grey[800]),
                                    ),
                                  );
                                }).toList(),
                              ),

                              const Spacer(), // يدفع الأزرار للأسفل

                              // 5. منطقة الإجراءات السفلية
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  // أزرار الإجراءات السريعة
                                  Row(
                                    children: [
                                      // InkWell(
                                      //   onTap: () {},
                                      //   child: Container(
                                      //     padding: const EdgeInsets.all(
                                      //         5), // تصغير البادينغ قليلاً
                                      //     decoration: BoxDecoration(
                                      //         shape: BoxShape.circle,
                                      //         border: Border.all(
                                      //             color: Colors.grey.shade300)),
                                      //     child: const Icon(
                                      //         Icons.bookmark_border,
                                      //         size: 16,
                                      //         color: Colors.grey),
                                      //   ),
                                      // ),
                                      // const SizedBox(width: 8),
                                      // InkWell(
                                      //   onTap: () {},
                                      //   child: Container(
                                      //     padding: const EdgeInsets.all(5),
                                      //     decoration: BoxDecoration(
                                      //       shape: BoxShape.circle,
                                      //       color: AppColor.primaryColor
                                      //           .withOpacity(0.1),
                                      //     ),
                                      //     child: const Icon(
                                      //         Icons.chat_bubble_outline,
                                      //         size: 16,
                                      //         color: AppColor.primaryColor),
                                      //   ),
                                      // ),
                                    ],
                                  ),

                                  // زر عرض الملف
                                  InkWell(
                                    onTap: () {
                                      // i nee index here
                                      controller.goToStudentProfile(
                                          student.id.toString()); /******* */
                                    },
                                    child: Row(
                                      children: const [
                                        Text("عرض الملف",
                                            style: TextStyle(
                                                fontSize:
                                                    10, // تصغير الخط قليلاً ليناسب
                                                color: AppColor.primaryColor,
                                                fontWeight: FontWeight.bold)),
                                        Icon(Icons.arrow_forward_ios,
                                            size: 10,
                                            color: AppColor.primaryColor),
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
            }).toList(),
          ),

          const SizedBox(height: 10),

          // النقاط
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: controller.allStudents.asMap().entries.map((entry) {
              return AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                width: controller.currentIndex == entry.key ? 20.0 : 8.0,
                height: 8.0,
                margin: const EdgeInsets.symmetric(horizontal: 3.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: controller.currentIndex == entry.key
                      ? AppColor.primaryColor
                      : Colors.grey.withOpacity(0.3),
                ),
              );
            }).toList(),
          ),
        ],
      );
    });
  }
}
