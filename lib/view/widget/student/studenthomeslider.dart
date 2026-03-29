// import 'package:carousel_slider/carousel_slider.dart';
// import 'package:flutter/material.dart';
// import 'package:hireme/core/constant/color.dart';
// تأكد من مسار ملف الألوان

// class HomeSlider extends StatefulWidget {
//   const HomeSlider({super.key});

//   @override
//   State<HomeSlider> createState() => _HomeSliderState();
// }

// class _HomeSliderState extends State<HomeSlider> {
//   int _currentIndex = 0;

//   // قائمة الصور (يمكنك استبدال الروابط بصور من Assets)
//   final List<String> imgList = [
//     'https://images.unsplash.com/photo-1486312338219-ce68d2c6f44d?q=80&w=1000&auto=format&fit=crop', // صورة لابتوب وعمل
//     'https://images.unsplash.com/photo-1521737604893-d14cc237f11d?q=80&w=1000&auto=format&fit=crop', // صورة اجتماع عمل
//     'https://images.unsplash.com/photo-1600880292203-757bb62b4baf?q=80&w=1000&auto=format&fit=crop', // صورة فريق متعاون
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         // 1. جسم السلايدر
//         CarouselSlider(
//           options: CarouselOptions(
//             height: 180.0, // ارتفاع مناسب للسلايدر
//             autoPlay: true, // التقليب التلقائي
//             enlargeCenterPage: true, // تكبير الصورة التي في الوسط قليلاً
//             aspectRatio: 2.0,
//             autoPlayCurve: Curves.fastOutSlowIn,
//             enableInfiniteScroll: true,
//             autoPlayAnimationDuration: const Duration(milliseconds: 800),
//             viewportFraction:
//                 0.9, // لتظهر حواف الصور الجانبية قليلاً (شكل عصري)
//             onPageChanged: (index, reason) {
//               setState(() {
//                 _currentIndex = index;
//               });
//             },
//           ),
//           items: imgList.map((item) {
//             return Builder(
//               builder: (BuildContext context) {
//                 return Container(
//                   width: MediaQuery.of(context).size.width,
//                   margin: const EdgeInsets.symmetric(horizontal: 5.0),
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(15), // حواف دائرية
//                     image: DecorationImage(
//                       image: NetworkImage(
//                           item), // استخدم AssetImage إذا الصور عندك في المشروع
//                       fit: BoxFit.cover,
//                     ),
//                     boxShadow: [
//                       BoxShadow(
//                         color: Colors.black.withOpacity(0.2),
//                         blurRadius: 5,
//                         offset: const Offset(0, 5),
//                       ),
//                     ],
//                   ),
//                   // (اختياري) إضافة نص فوق الصورة
//                   child: Container(
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(15),
//                       gradient: LinearGradient(
//                         begin: Alignment.bottomCenter,
//                         end: Alignment.topCenter,
//                         colors: [
//                           Colors.black.withOpacity(0.6),
//                           Colors.transparent,
//                         ],
//                       ),
//                     ),
//                     alignment: Alignment.bottomRight,
//                     padding: const EdgeInsets.all(15),
//                     child: const Text(
//                       "اكتشف فرصتك الآن!", // نص تجريبي
//                       style: TextStyle(
//                         color: Colors.white,
//                         fontWeight: FontWeight.bold,
//                         fontSize: 16,
//                       ),
//                     ),
//                   ),
//                 );
//               },
//             );
//           }).toList(),
//         ),

//         const SizedBox(height: 10),

//         // 2. مؤشر النقاط (Dots Indicator)
//         Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: imgList.asMap().entries.map((entry) {
//             return Container(
//               width:
//                   _currentIndex == entry.key ? 12.0 : 8.0, // النقطة النشطة أكبر
//               height: 8.0,
//               margin:
//                   const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
//               decoration: BoxDecoration(
//                 shape: BoxShape.circle,
//                 // إذا كانت النقطة نشطة نستخدم اللون الأخضر، وإلا رمادي
//                 color: _currentIndex == entry.key
//                     ? AppColor.primaryColor
//                     : Colors.grey.withOpacity(0.4),
//               ),
//             );
//           }).toList(),
//         ),
//       ],
//     );
//   }
// }
/////////////// -- 2
// import 'package:carousel_slider/carousel_slider.dart';
// import 'package:flutter/material.dart';
// import 'package:hireme/core/constant/color.dart';

// class HomeSlider extends StatefulWidget {
//   const HomeSlider({super.key});

//   @override
//   State<HomeSlider> createState() => _HomeSliderState();
// }

// class _HomeSliderState extends State<HomeSlider> {
//   int _currentIndex = 0;
//   final List<String> imgList = [
//     'https://images.unsplash.com/photo-1486312338219-ce68d2c6f44d?q=80&w=1000&auto=format&fit=crop',
//     'https://images.unsplash.com/photo-1521737604893-d14cc237f11d?q=80&w=1000&auto=format&fit=crop',
//     'https://images.unsplash.com/photo-1600880292203-757bb62b4baf?q=80&w=1000&auto=format&fit=crop',
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//       // 1. استخدمنا Stack لدمج النقاط مع الصورة
//       alignment: Alignment.bottomCenter,
//       children: [
//         CarouselSlider(
//           options: CarouselOptions(
//             height: 180.0,
//             autoPlay: true,
//             viewportFraction:
//                 1.0, // اجعله 1.0 ليملأ العرض، أو 0.9 لإظهار الحواف
//             enlargeCenterPage:
//                 false, // جرب إلغاء التكبير لتصميم مسطح وعريض (Banner style)
//             onPageChanged: (index, reason) {
//               setState(() {
//                 _currentIndex = index;
//               });
//             },
//           ),
//           items: imgList.map((item) {
//             return Container(
//               margin: const EdgeInsets.symmetric(
//                   horizontal: 15.0), // هوامش جانبية صغيرة
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(15),
//                 image: DecorationImage(
//                   image: NetworkImage(item),
//                   fit: BoxFit.cover,
//                 ),
//               ),
//               child: Container(
//                 // 2. تدرج لوني أنعم للنص
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(15),
//                   gradient: LinearGradient(
//                     begin: Alignment.bottomCenter,
//                     end: Alignment.topCenter,
//                     colors: [
//                       Colors.black.withOpacity(0.8), // أسود أغمق في الأسفل
//                       Colors.black.withOpacity(0.0), // شفاف تماماً في الأعلى
//                     ],
//                     stops: const [0.0, 0.5], // التدرج ينتهي عند منتصف الصورة
//                   ),
//                 ),
//                 padding:
//                     // const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
//                     const EdgeInsets.only(bottom: 30, right: 15),
//                 alignment: Alignment.bottomRight, // محاذاة النص
//                 child: const Text(
//                   "اكتشف فرصتك الآن!",
//                   style: TextStyle(
//                       color: Colors.white,
//                       fontWeight: FontWeight.bold,
//                       fontSize: 18, // تكبير الخط قليلاً
//                       shadows: [
//                         Shadow(
//                             blurRadius: 10,
//                             color: Colors.black,
//                             offset: Offset(0, 2))
//                       ]),
//                 ),
//               ),
//             );
//           }).toList(),
//         ),

//         // 3. النقاط (Dots) أصبحت الآن فوق الصورة في الأسفل
//         Positioned(
//           bottom: 1,
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: imgList.asMap().entries.map((entry) {
//               return AnimatedContainer(
//                 duration: const Duration(milliseconds: 300),
//                 width: _currentIndex == entry.key
//                     ? 20.0
//                     : 8.0, // تأثير التمدد للنقطة النشطة
//                 height: 8.0,
//                 margin:
//                     const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
//                 decoration: BoxDecoration(
//                   borderRadius:
//                       BorderRadius.circular(5), // شكل كبسولة بدلاً من دائرة
//                   color: _currentIndex == entry.key
//                       ? AppColor.primaryColor // اللون الأخضر
//                       : Colors.white
//                           .withOpacity(0.5), // أبيض شفاف للنقاط غير النشطة
//                 ),
//               );
//             }).toList(),
//           ),
//         ),
//       ],
//     );
//   }
// }
//---------------------------------3
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:hireme/core/constant/color.dart';

class HomeSlider extends StatefulWidget {
  const HomeSlider({super.key});

  @override
  State<HomeSlider> createState() => _HomeSliderState();
}

class _HomeSliderState extends State<HomeSlider> {
  int _currentIndex = 0;

  // قمنا بتحويل القائمة إلى Map لتحاكي البيانات القادمة من الباك إند
  // لاحقاً يمكنك استبدالها بـ List<JobModel>
  final List<Map<String, String>> featuredJobs = [
    {
      "image":
          'https://images.unsplash.com/photo-1486312338219-ce68d2c6f44d?q=80&w=1000&auto=format&fit=crop',
      "title": "Flutter Developer",
      "company": "Google Inc"
    },
    {
      "image":
          'https://images.unsplash.com/photo-1521737604893-d14cc237f11d?q=80&w=1000&auto=format&fit=crop',
      "title": "UI/UX Designer",
      "company": "Amazon"
    },
    {
      "image":
          'https://images.unsplash.com/photo-1600880292203-757bb62b4baf?q=80&w=1000&auto=format&fit=crop',
      "title": "Backend Engineer",
      "company": "Microsoft"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        CarouselSlider(
          options: CarouselOptions(
            height: 150.0,
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
