import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:hireme/controller/student/companiesposts_controller.dart';
import 'package:hireme/controller/student/studenthome_controller.dart';
import 'package:hireme/controller/student/studentsuggestions_controller.dart';
import 'package:hireme/core/constant/color.dart';
import 'package:hireme/view/screen/student/studentdrawer.dart';
import 'package:hireme/view/widget/student/buildsectionheader.dart';
import 'package:hireme/view/widget/student/reusable_freelancer_slider.dart';
import 'package:hireme/view/widget/student/reusable_job_slider.dart';
// استيراد الكاردات الخاصة بك
// استيراد الموديلات والقوائم الوهمية
import 'package:hireme/data/model/companiespostmodel.dart';
import 'package:hireme/data/model/freelancerpostmodel.dart';
// import 'package:hireme/data/datasource/static/static.dart';
import 'package:hireme/view/widget/student/suggestionsfreelancerpostcard.dart';
import 'package:hireme/view/widget/student/suggestionspostcard.dart';

class StudentHome extends StatelessWidget {
  const StudentHome({super.key});

  @override
  Widget build(BuildContext context) {
    StudentHomeControllerImp controller = Get.put(StudentHomeControllerImp());
    Get.put(StudentSuggestionsControllerImp());

    return SafeArea(
      child: RefreshIndicator(
        color: AppColor.primaryColor, // لتلوين مؤشر التحديث بلون تطبيقك الأساسي
        onRefresh: () async {
          // استدعاء دالة التحديث التي أنشأناها في الـ Controller
          await controller.refreshData();
        },
        child: Scaffold(
          // backgroundColor: Colors.white,
          backgroundColor: const Color(0xFFF9F9F9),
          appBar: AppBar(
            title: const Text("hireMe",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            foregroundColor: AppColor.primaryColor,
            centerTitle: true,
            // backgroundColor: Colors.white,
            backgroundColor: const Color(0xFFF9F9F9),
            elevation: 0,
          ),
          drawer: const StudentDrawer(),
          body: SingleChildScrollView(
            // هذه الخاصية ضرورية جداً ليتمكن المستخدم من السحب لأسفل حتى لو كانت الصفحة لا تحتوي على عناصر كثيرة
            physics: const AlwaysScrollableScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ================= حقل البحث الجديد =================
                _buildSearchBar(controller),

                const SizedBox(height: 10),

                // ================= القسم الأول: وظائف الشركات =================
                BuildSectionHeader(
                    title: "أحدث إعلانات العمل",
                    onSeeAllTap: () => controller.goToCompaniesPosts()),
                const SizedBox(height: 10),
                const ReusableJobSlider(),

                const SizedBox(height: 25),

                // ================= القسم الثاني: العمل الحر =================
                BuildSectionHeader(
                    title: "أحدث مشاريع العمل الحر",
                    onSeeAllTap: () => controller.goToFreelancerPosts()),
                const SizedBox(height: 10),
                const ReusableFreelancerSlider(),

                const SizedBox(height: 25),

                // ================= القسم الثالث: إعلانات مقترحة لك =================
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Text(
                    "إعلانات مقترحة لك",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                ),

                // عرض القائمة المختلطة
                // نستخدم ListView.builder مع منع التمرير الخاص به لأنه داخل SingleChildScrollView
                // ListView.builder(
                //   shrinkWrap: true,
                //   physics: const NeverScrollableScrollPhysics(),
                //   itemCount: controller1.suggestionsAds.length,
                //   itemBuilder: (context, index) {
                //     final item = controller1.suggestionsAds[index];

                //     // فحص نوع الموديل لعرض الكارد المناسب
                //     if (item is CompaniesPostModel) {
                //       return SuggestionsStudentPostCard(
                //         companiesPostModel: item,
                //         index: index,
                //       );
                //     } else if (item is FreelancerPostModel) {
                //       return SuggestionsStudentFreelancerPostCard(
                //         freelancerPostModel: item,
                //         index: index,
                //       );
                //     }
                //     return const SizedBox.shrink();
                //   },
                // ),
                // داخل StudentHome

                GetBuilder<StudentSuggestionsControllerImp>(
                  builder: (controller1) {
                    if (controller1.suggestionsAds.isEmpty) {
                      return const Center(
                          child: Padding(
                        padding: EdgeInsets.all(20.0),
                        child: Text("جاري تحضير المقترحات..."),
                      ));
                    }
                    return ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: controller1.suggestionsAds.length,
                      itemBuilder: (context, index) {
                        final item = controller1.suggestionsAds[index];
                        if (item is CompaniesPostModel) {
                          return SuggestionsStudentPostCard(
                              companiesPostModel: item, index: index);
                        } else if (item is FreelancerPostModel) {
                          return SuggestionsStudentFreelancerPostCard(
                              freelancerPostModel: item, index: index);
                        }
                        return const SizedBox.shrink();
                      },
                    );
                  },
                ),

                const SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ويجت حقل البحث
  Widget _buildSearchBar(StudentHomeControllerImp controller) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: InkWell(
        onTap: () {
          controller.goToSearchPage(); // الدالة التي ستنقلك لصفحة البحث
        },
        child: Container(
          height: 50,
          padding: const EdgeInsets.symmetric(horizontal: 15),
          decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.grey.shade400),
          ),
          child: Row(
            children: [
              Icon(Icons.search, color: Colors.grey[600]),
              const SizedBox(width: 10),
              Text(
                "ابحث عن عمل/خدمة محددة",
                style: TextStyle(color: Colors.grey[600], fontSize: 14),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
