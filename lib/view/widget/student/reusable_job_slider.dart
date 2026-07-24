import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hireme/controller/student/studenthome_controller.dart';
import 'package:hireme/core/class/statusrequest.dart';
import 'package:hireme/core/constant/color.dart';
import 'package:hireme/data/datasource/static/static.dart';

class ReusableJobSlider extends StatelessWidget {
  const ReusableJobSlider({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<StudentHomeControllerImp>(builder: (controller) {
      // 1. إذا كانت الحالة هي "تحميل" أو القائمة فارغة تماماً
      if (controller.statusRequest == StatusRequest.loading &&
          controller.allCompaniesAds!.isEmpty) {
        return Container(
          height: 160, // نفس ارتفاع السلايدر لكي لا يتحرك التصميم عند التحميل
          alignment: Alignment.center,
          child: const CircularProgressIndicator(
            color: AppColor.primaryColor,
          ),
        );
      }

      // 2. إذا فشل التحميل وكانت القائمة فارغة (اختياري لكن احترافي)
      if (controller.statusRequest == StatusRequest.serverfailure) {
        return const SizedBox(
          height: 160,
          child: Center(child: Text("فشل تحميل البيانات")),
        );
      }

      // 3. الحالة الطبيعية: عرض السلايدر

      return Stack(
        alignment: Alignment.bottomCenter,
        children: [
          CarouselSlider(
            options: CarouselOptions(
              height: 160.0,
              autoPlay: true,
              autoPlayInterval: const Duration(seconds: 5),
              autoPlayAnimationDuration: const Duration(milliseconds: 1000),
              autoPlayCurve: Curves.fastOutSlowIn,
              viewportFraction: 1.0,
              enlargeCenterPage: false,
              onPageChanged: (index, reason) {
                controller.change(index);
              },
            ),
            items: controller.allCompaniesAds!.map((job) {
              return InkWell(
                onTap: () {
                  controller.goToOneCompanyPost(job);
                },
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 15.0),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      image: DecorationImage(
                        image: NetworkImage(job.image!), // صورة غلاف الإعلان
                        fit: BoxFit.cover,
                      ),
                      boxShadow: const [
                        BoxShadow(
                            color: Colors.black12,
                            blurRadius: 5,
                            offset: Offset(0, 5))
                      ]),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      gradient: LinearGradient(
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                        colors: [
                          Colors.black.withOpacity(0.9),
                          Colors.transparent,
                        ],
                        stops: const [0.0, 0.7],
                      ),
                    ),
                    padding:
                        const EdgeInsets.only(bottom: 35, right: 15, left: 15),
                    alignment: Alignment.bottomRight,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // العنوان (المسمى الوظيفي)
                        Text(
                          job.jobTitle!,
                          style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              height: 1.2,
                              shadows: [
                                Shadow(
                                    blurRadius: 10,
                                    color: Colors.black,
                                    offset: Offset(0, 2))
                              ]),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),

                        const SizedBox(height: 8), // زيادة المسافة قليلاً

                        // --- التعديل الجديد (صورة الناشر + الاسم) ---
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            // دائرة الشعار مع إطار أبيض
                            Container(
                              padding:
                                  const EdgeInsets.all(1), // سمك الإطار الأبيض
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                              ),
                              child: CircleAvatar(
                                radius: 10, // حجم صغير مناسب للنص
                                backgroundColor:
                                    Colors.grey[200], // لون خلفية احتياطي
                                backgroundImage: NetworkImage(
                                    job.logo!), // هنا نضع لوجو الشركة
                                // إذا لم يكن هناك صورة، يمكنك استخدام أيقونة كبديل:
                                child: job.logo == null
                                    ? const Icon(Icons.business,
                                        size: 12, color: Colors.grey)
                                    : null,
                              ),
                            ),

                            const SizedBox(width: 6),

                            Text(
                              job.companyName!,
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 12,
                                  shadows: [
                                    Shadow(
                                        blurRadius: 2,
                                        color: Colors.black45,
                                        offset: Offset(0, 1))
                                  ]),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }).toList(),
          ),

          // نقاط المؤشر
          Positioned(
            bottom: 10,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children:
                  controller.allCompaniesAds!.asMap().entries.map((entry) {
                return AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  width: controller.currentIndex == entry.key ? 20.0 : 6.0,
                  height: 6.0,
                  margin: const EdgeInsets.symmetric(horizontal: 3.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: controller.currentIndex == entry.key
                        ? AppColor.primaryColor
                        : Colors.white.withOpacity(0.5),
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      );
    });
  }
}
