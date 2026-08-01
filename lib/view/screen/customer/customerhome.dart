import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hireme/controller/customer/customerhome_controller.dart';
import 'package:hireme/core/constant/color.dart';
import 'package:hireme/data/datasource/static/static.dart';
import 'package:hireme/view/widget/company/sectionheader.dart';
import 'package:hireme/view/widget/customer/customer_post_card.dart';
import 'package:hireme/view/widget/customer/customerdrawer.dart';
import 'package:hireme/view/widget/customer/customerhomeslider.dart';

class CustomerHome extends StatelessWidget {
  const CustomerHome({super.key});

  @override
  Widget build(BuildContext context) {
    CustomerHomeControllerImp controller = Get.put(CustomerHomeControllerImp());
    //--
    return SafeArea(
      child: Scaffold(
        backgroundColor:
            const Color(0xFFF9F9F9), // خلفية رمادية فاتحة جداً لإبراز البوستات
        appBar: AppBar(
          title: const Text("hireMe",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          foregroundColor: AppColor.primaryColor,
          centerTitle: true,
          // backgroundColor: Colors.white,
          backgroundColor: const Color(0xFFF9F9F9),
          elevation: 0,
        ),
        drawer: const CustomerDrawer(),

        body: RefreshIndicator(
          color:
              AppColor.primaryColor, // لتلوين مؤشر التحديث بلون تطبيقك الأساسي
          onRefresh: () async {
            // استدعاء دالة التحديث التي أنشأناها في الـ Controller
            await controller.refreshData();
          },
          child: SingleChildScrollView(
            // هذه الخاصية ضرورية جداً ليتمكن المستخدم من السحب لأسفل حتى لو كانت الصفحة لا تحتوي على عناصر كثيرة
            physics: const AlwaysScrollableScrollPhysics(),
            padding: const EdgeInsets.only(bottom: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),

                // ============ 1. سلايدر الطلاب ============
                // SectionHeader(title: "الطلاب الأعلى تقييما", onSeeAllTap: () {}),
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

                GetBuilder<CustomerHomeControllerImp>(builder: (controller) {
                  return Column(
                    children: [
                      if (controller.myProjects.isEmpty)
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
                      for (int i = 0; i < controller.myProjects.length; i++)
                        CustomerPostCard(
                          index: i,
                          freelancerPostModel: controller.myProjects[i],
                        )
                    ],
                  );
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
