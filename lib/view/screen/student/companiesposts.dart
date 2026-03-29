import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hireme/controller/student/companiesposts_controller.dart';
import 'package:hireme/core/constant/color.dart';
import 'package:hireme/data/datasource/static/static.dart';
import 'package:hireme/view/widget/student/studentpostcard.dart';

class CompaniesPosts extends StatelessWidget {
  const CompaniesPosts({super.key});

  @override
  Widget build(BuildContext context) {
    CompaniesPostsControllerImp controller =
        Get.put(CompaniesPostsControllerImp());
    return SafeArea(
        child: Scaffold(
      backgroundColor:
          const Color(0xFFF9F9F9), // خلفية رمادية فاتحة جداً لإبراز البوستات
      appBar: AppBar(
        title: Text(
          "إعلانات العمل",
          style: TextStyle(
              color: AppColor.primaryColor,
              fontSize: 18,
              fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black87),
      ),
      body: Container(
        padding: EdgeInsets.only(top: 15),
        // color: Colors.grey[100],
        child: ListView.builder(
          itemCount: allcompaniesPosts.length,
          itemBuilder: (context, i) {
            return StudentPostCard(
              companiesPostModel: allcompaniesPosts[i],
              index: i,
            );
          },
        ),
      ),
    ));
  }
}
