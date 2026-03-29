import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hireme/controller/student/studenthome_controller.dart';
import 'package:hireme/core/constant/color.dart';
import 'package:hireme/data/datasource/static/static.dart';

class ReusableFreelancerSlider extends StatelessWidget {
  const ReusableFreelancerSlider({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<StudentHomeControllerImp>(builder: (controller) {
      return Stack(
        alignment: Alignment.bottomCenter,
        children: [
          CarouselSlider(
            options: CarouselOptions(
              height: 160.0,
              autoPlay: true,
              autoPlayInterval:
                  const Duration(seconds: 7), // التوقيت الخاص بهذا السلايدر
              autoPlayAnimationDuration: const Duration(milliseconds: 1000),
              autoPlayCurve: Curves.fastOutSlowIn,
              viewportFraction: 1.0,
              enlargeCenterPage: false,
              onPageChanged: (index, reason) {
                controller.onChange(index);
              },
            ),
            items: freelancerPostsList.map((job) {
              return InkWell(
                onTap: () {
                  controller.goToOneFreelancerPost(job);
                },
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 15.0),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      image: DecorationImage(
                        image: NetworkImage(job.image!), // صورة المشروع
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
                        // العنوان (عنوان الخدمة المطلوبة)
                        Text(
                          job.serviceTitle!,
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

                        const SizedBox(height: 8), // مسافة مناسبة

                        // --- التعديل: صورة الناشر (Profile) + الاسم ---
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            // 1. الصورة الشخصية للناشر مع إطار أبيض
                            Container(
                              padding: const EdgeInsets.all(1), // الإطار الأبيض
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                              ),
                              child: CircleAvatar(
                                radius: 10, // حجم صغير وأنيق
                                backgroundColor: Colors.grey[300],
                                backgroundImage:
                                    NetworkImage(job.logo!), // صورة الناشر
                              ),
                            ),

                            const SizedBox(width: 6),

                            // 2. اسم الناشر
                            Text(
                              job.publisher!,
                              style: const TextStyle(
                                  color: Colors.white, // أبيض ناصع
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
              children: freelancerPostsList.asMap().entries.map((entry) {
                return AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  width: controller.currentIndx == entry.key ? 20.0 : 6.0,
                  height: 6.0,
                  margin: const EdgeInsets.symmetric(horizontal: 3.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: controller.currentIndx == entry.key
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
