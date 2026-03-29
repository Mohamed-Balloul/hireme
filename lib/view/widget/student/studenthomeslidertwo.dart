import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:hireme/core/constant/color.dart';

class HomeSliderTwo extends StatefulWidget {
  const HomeSliderTwo({super.key});

  @override
  State<HomeSliderTwo> createState() => _HomeSliderState();
}

class _HomeSliderState extends State<HomeSliderTwo> {
  int _currentIndex = 0;

  // قمنا بتحويل القائمة إلى Map لتحاكي البيانات القادمة من الباك إند
  // لاحقاً يمكنك استبدالها بـ List<JobModel>
  final List<Map<String, String>> featuredJobs = [
    {
      "image":
          'https://images.unsplash.com/photo-1486312338219-ce68d2c6f44d?q=80&w=1000&auto=format&fit=crop',
      "title": "بناء متجر الكتروني",
      "company": "Ahmed Ali"
    },
    {
      "image":
          'https://images.unsplash.com/photo-1521737604893-d14cc237f11d?q=80&w=1000&auto=format&fit=crop',
      "title": "بناء تطبيق موبايل",
      "company": "Mohamed Ali"
    },
    {
      "image":
          'https://images.unsplash.com/photo-1600880292203-757bb62b4baf?q=80&w=1000&auto=format&fit=crop',
      "title": "تصميم واجهات  لموقع",
      "company": "Mahmoud Ali"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        CarouselSlider(
          options: CarouselOptions(
            height: 150,
            autoPlay: true,
            viewportFraction: 1.0,
            enlargeCenterPage: false,
            onPageChanged: (index, reason) {
              setState(() {
                _currentIndex = index;
              });
            },
          ),
          items: featuredJobs.map((job) {
            return InkWell(
              // أضفنا InkWell لتتمكن من الضغط على الإعلان لاحقاً
              onTap: () {
                // هنا تضع كود الذهاب لتفاصيل هذا الإعلان
                print("Open details for ${job['title']}");
              },
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 30),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  image: DecorationImage(
                    image: NetworkImage(job['image']!), // الصورة من البيانات
                    fit: BoxFit.cover,
                  ),
                ),
                child: Container(
                  // التدرج اللوني (مهم جداً لقراءة النص)
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      colors: [
                        Colors.black
                            .withOpacity(0.9), // زدنا التعتيم قليلاً في الأسفل
                        Colors.black.withOpacity(0.0),
                      ],
                      stops: const [0.0, 0.6],
                    ),
                  ),
                  // التنسيق والمحاذاة
                  padding: const EdgeInsets.only(
                      bottom: 40,
                      right: 15,
                      left: 15), // رفعنا الـ bottom لـ 40 لترك مكان للنقاط
                  alignment: Alignment.bottomRight, // النص يبدأ من اليمين
                  child: Column(
                    mainAxisSize: MainAxisSize.min, // يأخذ أقل مساحة ممكنة
                    crossAxisAlignment: CrossAxisAlignment
                        .start, // محاذاة النص لليمين (بداية السطر)
                    children: [
                      // 1. المسمى الوظيفي
                      Text(
                        job['title']!,
                        style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            height: 1.2, // تحسين تباعد الأسطر
                            shadows: [
                              Shadow(
                                  blurRadius: 10,
                                  color: Colors.black,
                                  offset: Offset(0, 2))
                            ]),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),

                      const SizedBox(
                          height: 4), // مسافة صغيرة بين العنوان والشركة

                      // 2. اسم الشركة
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(Icons.business,
                              color: Colors.white70, size: 14), // أيقونة صغيرة
                          const SizedBox(width: 5),
                          Text(
                            job['company']!,
                            style: const TextStyle(
                              color: Colors.white70, // لون أفتح قليلاً للتمييز
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                            ),
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

        // 3. نقاط المؤشر
        Positioned(
          bottom: 10, // وضعناها قريبة من الحافة
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: featuredJobs.asMap().entries.map((entry) {
              return AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                width: _currentIndex == entry.key ? 20.0 : 8.0,
                height: 8.0,
                margin:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: _currentIndex == entry.key
                      ? AppColor.primaryColor
                      : Colors.white.withOpacity(0.5),
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}
