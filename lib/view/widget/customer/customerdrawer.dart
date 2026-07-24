import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hireme/controller/customer/customerbottomnavigationbar/customerbottomnavigationbar_controller.dart';
import 'package:hireme/controller/customer/customerhome_controller.dart';
import 'package:hireme/core/class/statusrequest.dart';
import 'package:hireme/core/constant/color.dart';
import 'package:hireme/data/datasource/static/static.dart';
import 'package:hireme/data/model/customerprofilemodel.dart';

class CustomerDrawer extends StatelessWidget {
  const CustomerDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    Get.find<CustomerHomeControllerImp>();
    // نحتاج للوصول لل كنترولر لمعرفة حالة التحميل
    CustomerBottomNavigationBarrControllerImp controller1 =
        Get.find<CustomerBottomNavigationBarrControllerImp>();

    // CompanyProfileModel company = companyProfileList[0];
    return GetBuilder<CustomerHomeControllerImp>(builder: (controller) {
      // 1. حالة التحميل: إذا كانت ال لا تزال تحمل والقائمة فارغة
      if (controller1.statusRequest == StatusRequest.loading &&
          controller.customerModel == null) {
        return const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(color: AppColor.primaryColor),
              SizedBox(height: 15),
              Text("جاري تحميل ...", style: TextStyle(color: Colors.grey)),
            ],
          ),
        );
      }

      // 2. حالة القائمة فارغة (بعد انتهاء التحميل)
      if (controller.customerModel == null) {
        return const Center(child: Text("خطأ في تحميل البيانات"));
      }
      // 3. الحالة الطبيعية: عرض
      CustomerProfileModel customer = controller.customerModel!;

      return Drawer(
        width: MediaQuery.of(context).size.width *
            0.75, // عرض الدراور 75% من الشاشة
        // هذا السطر هو المسؤول عن جعل الزوايا حادة (قائمة)
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.zero,
        ),
        backgroundColor: Colors.white,
        child: Column(
          children: [
            // ================= 1. الهيدر المنحني =================

// داخل كلاس StudentDrawer، استبدل الـ Stack الخاص بالهيدر بهذا:
            Stack(
              children: [
                ClipPath(
                  clipper: HeaderCurveClipper(),
                  child: Container(
                    height: 250,
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.centerRight,
                        end: Alignment.centerLeft,
                        colors: [
                          Color.fromARGB(255, 29, 191, 83),
                          Color.fromARGB(255, 134, 255, 189),
                        ],
                      ),
                    ),
                  ),
                ),
                // الصورة الشخصية والمعلومات (تعديل الإحداثيات لتناسب الموجة)
                Positioned(
                  top: 55,
                  right:
                      11, // إزاحة جهة اليمين ليكون في قلب الجزء المرتفع من المنحنى
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(3.5),
                        decoration: const BoxDecoration(
                          // color: Color.fromARGB(255, 29, 191, 83),
                          color: Color.fromARGB(255, 134, 255, 189),
                          // color: Color.fromARGB(255, 50, 255, 156),
                          shape: BoxShape.circle,
                        ),
                        child: CircleAvatar(
                          radius: 60,
                          backgroundImage: NetworkImage(customer
                                  .image.isNotEmpty
                              ? customer.image
                              : "https://images.unsplash.com/photo-1544005313-94ddf0286df2?q=80&w=1000"),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.only(right: 11),
                        child: Text(
                          customer.name!,
                          style: TextStyle(
                            fontSize: 19,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 11),
                        child: Text(
                          customer.jobLabel!,
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // ================= 2. قائمة العناصر =================
            Expanded(
              child: Directionality(
                textDirection:
                    TextDirection.rtl, // لضمان اتجاه العناصر من اليمين
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Column(
                    children: [
                      _buildMenuItem(
                        title: "ملفي الشخصي",
                        icon: Icons.person_pin_outlined,
                        isSelected: true, // لتمييز العنصر المختار
                        onTap: () {
                          controller.goToMyProfile();
                        },
                      ),
                      _buildMenuItem(
                        title: "البحث عن طالب",
                        icon: Icons.search_rounded,
                        onTap: () {
                          controller.goToSearchPage();
                        },
                      ),
                      _buildMenuItem(
                        title: "الطلاب المحفوظين",
                        icon: Icons.bookmark_outline_rounded,
                        onTap: () {
                          controller.goToSavedStudents();
                        },
                      ),
                      _buildMenuItem(
                        title: "الإعدادات",
                        icon: Icons.settings_outlined,
                        onTap: () {},
                      ),
                      _buildMenuItem(
                        title: "حول التطبيق",
                        icon: Icons.folder_open_outlined,
                        onTap: () {},
                      ),
                      const Spacer(), // يدفع تسجيل الخروج للأسفل
                      const Divider(height: 1, thickness: 1),
                      _buildMenuItem(
                        title: "تسجيل خروج",
                        icon: Icons.logout_rounded,
                        isLogout: true,
                        onTap: () {},
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    });
  }

  // ويجت بناء عناصر القائمة
  Widget _buildMenuItem({
    required String title,
    required IconData icon,
    required VoidCallback onTap,
    bool isSelected = false,
    bool isLogout = false,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      decoration: BoxDecoration(
        // color: isSelected ? const Color(0xFFD5F3E4) : Colors.transparent,
        // color: Colors.transparent,
        color: isLogout ? Colors.transparent : Color(0xFFD5F3E4),
        borderRadius: BorderRadius.circular(10),
      ),
      child: ListTile(
        onTap: onTap,
        visualDensity:
            const VisualDensity(vertical: -2), // لتقليل الارتفاع قليلاً
        leading:
            Icon(icon, color: isLogout ? Colors.red : const Color(0xFF2EAD6B)),
        // color: isLogout
        //     ? Colors.red
        //     : (isSelected ? const Color(0xFF2EAD6B) : Colors.grey[600]),
        // ),
        title: Text(
          title,
          style: TextStyle(
              fontSize: 15,
              fontWeight: isSelected
                  ? /*FontWeight.bold */ FontWeight.w500
                  : FontWeight.w500,
              // color: isLogout
              //     ? Colors.red
              //     : (isSelected ? const Color(0xFF2EAD6B) : Colors.black87),
              color: isLogout
                  ? Colors.red
                  : /* const Color(0xFF2EAD6B)*/ Colors.black87),
          // ),
        ),
      ),
    );
  }
}

class HeaderCurveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height * 0.65); // نقطة البداية من اليسار

    // رسم المنحنى باستخدام نقطتي تحكم (Cubic Curve) لخلق شكل الموجة
    // نقطة التحكم الأولى ترفع المنحنى قليلاً، والثانية تخفضه
    path.cubicTo(
      size.width * 0.25, size.height * 0.95, // نقطة التحكم الأولى (CP1)
      size.width * 0.70, size.height * 0.30, // نقطة التحكم الثانية (CP2)
      size.width, size.height * 0.55, // نقطة النهاية جهة اليمين
    );

    path.lineTo(size.width, 0); // العودة للزاوية العلوية اليمنى
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}
