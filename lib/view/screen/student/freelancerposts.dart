import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hireme/controller/student/freelancerposts_controller.dart';
import 'package:hireme/core/constant/color.dart';
import 'package:hireme/data/datasource/static/static.dart';
import 'package:hireme/view/widget/student/studentfreelancerpostcard.dart';

class FreelancerPosts extends StatelessWidget {
  const FreelancerPosts({super.key});

  @override
  Widget build(BuildContext context) {
    FreelancerPostsControllerImp controller =
        Get.put(FreelancerPostsControllerImp());
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: Text(
          "إعلانات العمل الحر",
          style: TextStyle(),
        ),
        foregroundColor: Colors.white,
        centerTitle: true,
        backgroundColor: AppColor.primaryColor,
      ),
      body: Container(
        padding: EdgeInsets.only(top: 15),
        child: ListView.builder(
          itemCount: freelancerPostsList.length,
          itemBuilder: (context, i) {
            return StudentFreelancerPostCard(
              freelancerPostModel: freelancerPostsList[i],
              index: i,
            );
          },
        ),
      ),
    ));
  }
}
