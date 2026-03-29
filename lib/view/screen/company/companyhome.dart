import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hireme/controller/company/companyhome_controller.dart';
import 'package:hireme/core/constant/color.dart';
import 'package:hireme/data/datasource/static/static.dart';
import 'package:hireme/view/screen/student/studentdrawer.dart';
// تأكد من استيراد الويدجت الجديد
import 'package:hireme/view/widget/company/company_post_card.dart';
import 'package:hireme/view/widget/company/companydrawer.dart';
import 'package:hireme/view/widget/company/companyhomeslider.dart';
import 'package:hireme/view/widget/company/sectionheader.dart';

class CompanyHome extends StatelessWidget {
  const CompanyHome({super.key});

  @override
  Widget build(BuildContext context) {
    CompanyHomeControllerImp controller = Get.put(CompanyHomeControllerImp());

    return SafeArea(
      child: Scaffold(
        backgroundColor:
            const Color(0xFFF9F9F9), // خلفية رمادية فاتحة جداً لإبراز البوستات
        appBar: AppBar(
          title: const Text("hireMe",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          foregroundColor: AppColor.primaryColor,
          centerTitle: true,
          backgroundColor: const Color(0xFFF9F9F9),
          // backgroundColor:
          //     const Color.fromRGBO(29, 191, 115, 1).withOpacity(0.1),
          elevation: 0,
        ),
        drawer: const CompanyDrawer(),

        body: SingleChildScrollView(
          padding: const EdgeInsets.only(bottom: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),

              // ============ 1. سلايدر الطلاب ============
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SectionHeader(
                      title: "الطلاب الأعلى تقييما", onSeeAllTap: () {}),
                  Padding(
                    padding: const EdgeInsets.only(left: 25),
                    child: InkWell(
                      onTap: () {
                        controller
                            .goToSearchPage(); // الدالة التي ستنقلك لصفحة البحث
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 7, vertical: 4),
                        decoration: BoxDecoration(
                          color: const Color.fromRGBO(29, 191, 115, 1)
                              .withOpacity(0.1),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: AppColor.primaryColor),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.search,
                              color: AppColor.primaryColor,
                              size: 21,
                            ),
                            const SizedBox(width: 2),
                            Text(
                              "ابحث عن طالب",
                              style: TextStyle(
                                  color: AppColor.primaryColor,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 10),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),

              const SizedBox(height: 10),

              const HomeSlider(),

              const SizedBox(height: 30),

              // ============ 2. إعلاناتي (البوستات) ============
              SectionHeader(
                  title: "إعلاناتي المنشورة",
                  onSeeAllTap: () {
                    // الانتقال لصفحة أرشيف الإعلانات
                  }),

              const SizedBox(height: 15),

              GetBuilder<CompanyHomeControllerImp>(builder: (controller) {
                return Column(
                  children: [
                    if (companyPosts.isEmpty)
                      const Center(
                          child: Padding(
                        padding: EdgeInsets.only(top: 130),
                        child: Text(
                          "لم تقم بعد بنشر أي إعلان",
                          style: TextStyle(
                            color: Colors.black54,
                          ),
                        ),
                      )),
                    for (int i = 0; i < companyPosts.length; i++)
                      CompanyPostCard(
                        index: i,
                        companyPostInCompanyHomeModel: companyPosts[i],
                      )
                  ],
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
