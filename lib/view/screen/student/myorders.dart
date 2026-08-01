import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hireme/controller/student/myorders_controller.dart';
import 'package:hireme/core/class/statusrequest.dart';
import 'package:hireme/core/constant/color.dart';
// import 'package:hireme/data/datasource/static/static.dart';
import 'package:hireme/view/widget/student/buildmodernrequestcard.dart';

// class MyOrders extends StatelessWidget {
//   const MyOrders({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     print("hi customer and company");
//     /*MyOrdersControllerImp controller = */ Get.put(MyOrdersControllerImp());

//     return GetBuilder<MyOrdersControllerImp>(builder: (controller) {
//       return DefaultTabController(
//         length: 2,
//         child: Scaffold(
//           backgroundColor: const Color(0xFFF8F9FA),
//           body: RefreshIndicator(
//             color: AppColor
//                 .primaryColor, // لتلوين مؤشر التحديث بلون تطبيقك الأساسي
//             onRefresh: () async {
//               // استدعاء دالة التحديث التي أنشأناها في الـ Controller
//               await controller.refreshData();
//             },
//             child: SingleChildScrollView(
//               // هذه الخاصية ضرورية جداً ليتمكن المستخدم من السحب لأسفل حتى لو كانت الصفحة لا تحتوي على عناصر كثيرة
//               physics: const AlwaysScrollableScrollPhysics(),
//               child: SafeArea(
//                 child: Column(
//                   children: [
//                     const SizedBox(height: 20),

//                     // 1. العنوان الرئيسي (بديل الـ AppBar)
//                     // const Text(
//                     //   "طلباتي المرسلة",
//                     //   style: TextStyle(
//                     //     fontSize: 22,
//                     //     fontWeight: FontWeight.bold,
//                     //     color: AppColor.primaryColor, // أو أسود غامق حسب رغبتك
//                     //   ),
//                     // ),

//                     const SizedBox(height: 20),

//                     // 2. التابات بتصميم "Segmented Control" الفاخر
//                     Container(
//                       height: 55, // زدنا الارتفاع قليلاً للراحة
//                       margin: const EdgeInsets.symmetric(horizontal: 20),
//                       padding: const EdgeInsets.all(1), // حشوة داخلية للإطار
//                       decoration: BoxDecoration(
//                         color: Colors
//                             .grey[200], // خلفية رمادية فاتحة جداً للإطار العام
//                         // Color(0xFFF8F9FA),
//                         // Colors.grey[200], // خلفية رمادية فاتحة جداً للإطار العام
//                         borderRadius: BorderRadius.circular(30), // تدوير كامل
//                       ),
//                       child: TabBar(
//                         // إلغاء تأثيرات الضغط المائية
//                         overlayColor:
//                             MaterialStateProperty.all(Colors.transparent),

//                         // تصميم المؤشر (الخلفية البيضاء للتاب المختار - ستايل iOS)
//                         indicator: BoxDecoration(
//                           color: Colors.white, // لون التاب المختار أبيض
//                           borderRadius: BorderRadius.circular(25),
//                           boxShadow: [
//                             BoxShadow(
//                               color: Colors.black
//                                   .withOpacity(0.05), // ظل ناعم جداً
//                               blurRadius: 4,
//                               spreadRadius: 1,
//                               offset: const Offset(0, 2),
//                             ),
//                           ],
//                         ),

//                         // ألوان النصوص والأيقونات
//                         labelColor:
//                             AppColor.primaryColor, // المختار يصبح لونه أخضر
//                         unselectedLabelColor:
//                             Colors.grey[600], // غير المختار رمادي داكن

//                         labelStyle: const TextStyle(
//                           fontWeight: FontWeight.bold,
//                           fontSize: 15,
//                           fontFamily: 'Cairo',
//                         ),

//                         // إخفاء الخط الفاصل
//                         dividerColor: Colors.transparent,

//                         // التابات
//                         tabs: const [
//                           Tab(
//                             child: Row(
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               children: [
//                                 Icon(Icons.business_rounded,
//                                     size: 22), // تصغير الأيقونة قليلاً
//                                 SizedBox(width: 8),
//                                 Text("الشركات"),
//                               ],
//                             ),
//                           ),
//                           Tab(
//                             child: Row(
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               children: [
//                                 Icon(Icons.person_rounded, size: 22),
//                                 SizedBox(width: 8),
//                                 Text("العمل الحر"),
//                               ],
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),

//                     // const SizedBox(height: 15), // زيادة المسافة قليلاً بعد التابات

//                     const SizedBox(height: 10),

//                     // 3. المحتوى (القوائم)
//                     Expanded(
//                       child: TabBarView(
//                         children: [
//                           MyRequestsToCompaniesList(),
//                           MyRequestsToCustomersList(),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ),
//       );
//     });
//   }
// }

// // ... (باقي الكلاسات MyRequestsToCompaniesList و MyRequestsToCustomersList تبقى كما هي)
// class MyRequestsToCompaniesList extends StatelessWidget {
//   const MyRequestsToCompaniesList({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     MyOrdersControllerImp controller = Get.find<MyOrdersControllerImp>();
//     // فحص حالة التحميل أولاً
//     if (controller.statusRequest == StatusRequest.loading) {
//       return const Center(child: CircularProgressIndicator());
//     }
//     print("hi company");
//     return controller.allMyAdApplications.isEmpty
//         ? const Center(child: Text("لم ترسل بعد أي طلب الى أية شركة"))
//         : ListView.builder(
//             padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
//             itemCount: /*controller.*/ controller.allMyAdApplications.length,
//             itemBuilder: (context, i) {
//               final request = controller.allMyAdApplications[i];
//               return BuildModernRequestCard(
//                 id: request.id!,
//                 title: request.jobTitle ?? "عنوان غير متوفر",
//                 publisher: request.publisher ?? "ناشر غير معروف",
//                 imageUrl: request.logo ?? "",
//                 status: request.orderState == 1
//                     ? "تمت الموافقة"
//                     : request.orderState == 0
//                         ? "قيد الأنتظار"
//                         : "تم الرفض",
//                 statusColor: request.orderState == 1
//                     ? Colors.green
//                     : request.orderState == 0
//                         ? Colors.orange
//                         : Colors.red,
//                 timeAgo: "تم الإرسال منذ يومين",
//                 statusIconData: request.orderState == 1
//                     ? Icons.check
//                     : request.orderState == 0
//                         ? Icons.access_time_filled
//                         : Icons.cancel,
//                 isCompany: true,
//               );
//             },
//           );
//   }
// }

// class MyRequestsToCustomersList extends StatelessWidget {
//   const MyRequestsToCustomersList({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     MyOrdersControllerImp controller = Get.find<MyOrdersControllerImp>();
//     // فحص حالة التحميل أولاً
//     if (controller.statusRequest == StatusRequest.loading) {
//       return const Center(child: CircularProgressIndicator());
//     }
//     print("hi customer");
//     return controller.allMyProjectApplications.isEmpty
//         ? const Center(child: Text("لم ترسل بعد أي طلب الى أي عميل"))
//         : ListView.builder(
//             padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
//             itemCount: /*controller.*/
//                 controller.allMyProjectApplications.length,
//             itemBuilder: (context, i) {
//               final request = controller.allMyProjectApplications[i];
//               return BuildModernRequestCard(
//                 id: request.id!,
//                 title: request.serviceTitle ?? "عنوان غير متوفر",
//                 publisher: request.publisher ?? "ناشر غير معروف",
//                 imageUrl: request.image!,
//                 status: request.requestState == 1
//                     ? "تمت الموافقة"
//                     : request.requestState == 0
//                         ? "قيد الأنتظار"
//                         : "تم الرفض",
//                 statusColor: request.requestState == 1
//                     ? Colors.green
//                     : request.requestState == 0
//                         ? Colors.orange
//                         : Colors.red,
//                 timeAgo: "تم الإرسال منذ 5 ساعات",
//                 statusIconData: request.requestState == 1
//                     ? Icons.check
//                     : request.requestState == 0
//                         ? Icons.access_time_filled
//                         : Icons.cancel,
//                 isCompany: false,
//               );
//             },
//           );
//   }
// }

//-----------------
// ملف الشاشة الرئيسية MyOrders: تم إلغاء عناصر التمرير الخارجية لتقييد الأبعاد برمجياً ومنع الكراش

class MyOrders extends StatelessWidget {
  const MyOrders({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print("hi customer and company");
    Get.put(MyOrdersControllerImp());

    return GetBuilder<MyOrdersControllerImp>(builder: (controller) {
      return DefaultTabController(
        length: 2,
        child: Scaffold(
          backgroundColor: const Color(0xFFF8F9FA),
          body: SafeArea(
            // تمت إزالة SingleChildScrollView والـ RefreshIndicator الخارجي هنا
            child: Column(
              children: [
                const SizedBox(height: 20),

                // 1. التابات بتصميم "Segmented Control" الفاخر
                Container(
                  height: 55,
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  padding: const EdgeInsets.all(1),
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: TabBar(
                    overlayColor: MaterialStateProperty.all(Colors.transparent),
                    indicator: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(25),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 4,
                          spreadRadius: 1,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    labelColor: AppColor.primaryColor,
                    unselectedLabelColor: Colors.grey[600],
                    labelStyle: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                      fontFamily: 'Cairo',
                    ),
                    dividerColor: Colors.transparent,
                    tabs: const [
                      Tab(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.business_rounded, size: 22),
                            SizedBox(width: 8),
                            Text("الشركات"),
                          ],
                        ),
                      ),
                      Tab(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.person_rounded, size: 22),
                            SizedBox(width: 8),
                            Text("العمل الحر"),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 10),

                // 2. المحتوى (القوائم) - يعمل هنا بأمان تام لأن العمود الأب Column مقيد الارتفاع بالشاشة
                Expanded(
                  child: TabBarView(
                    children: [
                      MyRequestsToCompaniesList(),
                      MyRequestsToCustomersList(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
// دمج السحب للتحديث المستقل مع حماية القائمة الفارغة لتقبل السحب أيضاً

class MyRequestsToCompaniesList extends StatelessWidget {
  const MyRequestsToCompaniesList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MyOrdersControllerImp controller = Get.find<MyOrdersControllerImp>();
    //  فحص حالة التحميل أولاً
    if (controller.statusRequest == StatusRequest.loading) {
      return const Center(child: CircularProgressIndicator());
    }

    print("hi company");

    return RefreshIndicator(
      color: AppColor.primaryColor,
      onRefresh: () async {
        await controller
            .getAllMyAdApplications(); // تحديث قائمة الشركات فقط عند السحب
      },
      child: controller.allMyAdApplications.isEmpty
          ? ListView(
              // تم استخدام ListView هنا لضمان عمل السحب للتحديث حتى والقائمة فارغة
              physics: const AlwaysScrollableScrollPhysics(),
              children: [
                SizedBox(height: MediaQuery.of(context).size.height * 0.25),
                const Center(
                  child: Text(
                    "لم ترسل بعد أي طلب الى أية شركة",
                    style: TextStyle(
                        color: Colors.grey, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            )
          : ListView.builder(
              // تفعيل فيزياء السحب دائماً
              physics: const AlwaysScrollableScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
              itemCount: controller.allMyAdApplications.length,
              itemBuilder: (context, i) {
                final request = controller.allMyAdApplications[i];
                return BuildModernRequestCard(
                  id: request.id!,
                  title: request.jobTitle ?? "عنوان غير متوفر",
                  publisher: request.publisher ?? "ناشر غير معروف",
                  imageUrl: request.logo ?? "",
                  status: request.orderState == 1
                      ? "تمت الموافقة"
                      : request.orderState == 0
                          ? "قيد الأنتظار"
                          : "تم الرفض",
                  statusColor: request.orderState == 1
                      ? Colors.green
                      : request.orderState == 0
                          ? Colors.orange
                          : Colors.red,
                  timeAgo: "تم الإرسال منذ يومين",
                  statusIconData: request.orderState == 1
                      ? Icons.check
                      : request.orderState == 0
                          ? Icons.access_time_filled
                          : Icons.cancel,
                  isCompany: true,
                );
              },
            ),
    );
  }
}
// دمج السحب للتحديث المستقل مع حماية القائمة الفارغة للعملاء

class MyRequestsToCustomersList extends StatelessWidget {
  const MyRequestsToCustomersList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MyOrdersControllerImp controller = Get.find<MyOrdersControllerImp>();
    //  فحص حالة التحميل أولاً
    if (controller.statusRequest == StatusRequest.loading) {
      return const Center(child: CircularProgressIndicator());
    }
    print("hi customer");

    return RefreshIndicator(
      color: AppColor.primaryColor,
      onRefresh: () async {
        await controller
            .getAllMyProjectApplications(); // تحديث قائمة المشاريع فقط عند السحب
      },
      child: controller.allMyProjectApplications.isEmpty
          ? ListView(
              physics: const AlwaysScrollableScrollPhysics(),
              children: [
                SizedBox(height: MediaQuery.of(context).size.height * 0.25),
                const Center(
                  child: Text(
                    "لم ترسل بعد أي طلب الى أي عميل",
                    style: TextStyle(
                        color: Colors.grey, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            )
          : ListView.builder(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
              itemCount: controller.allMyProjectApplications.length,
              itemBuilder: (context, i) {
                final request = controller.allMyProjectApplications[i];
                return BuildModernRequestCard(
                  id: request.id!,
                  title: request.serviceTitle ?? "عنوان غير متوفر",
                  publisher: request.publisher ?? "ناشر غير معروف",
                  imageUrl: request.image!,
                  status: request.requestState == 1
                      ? "تمت الموافقة"
                      : request.requestState == 0
                          ? "قيد الأنتظار"
                          : "تم الرفض",
                  statusColor: request.requestState == 1
                      ? Colors.green
                      : request.requestState == 0
                          ? Colors.orange
                          : Colors.red,
                  timeAgo: "تم الإرسال منذ 5 ساعات",
                  statusIconData: request.requestState == 1
                      ? Icons.check
                      : request.requestState == 0
                          ? Icons.access_time_filled
                          : Icons.cancel,
                  isCompany: false,
                );
              },
            ),
    );
  }
}
