import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hireme/controller/company/companycomingrequests_controller.dart';
import 'package:hireme/core/constant/color.dart';
import 'package:hireme/data/datasource/static/static.dart';
import 'package:hireme/data/model/companypostmodel.dart';
import 'package:hireme/view/widget/checkout/custombutton.dart';

class CompanyComingRequests extends StatelessWidget {
  const CompanyComingRequests({super.key});

  @override
  Widget build(BuildContext context) {
    CompanyComingRequestsControllerImp controller =
        Get.put(CompanyComingRequestsControllerImp());
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: Text(
          "الطلبات الواردة على إعلاناتي",
          style: TextStyle(),
        ),
        foregroundColor: Colors.white,
        centerTitle: true,
        backgroundColor: AppColor.primaryColor,
      ),
      body: Container(
        // color: Colors.grey[100],
        child: ListView.builder(
          itemCount: companiesPostsList.length,
          itemBuilder: (context, i) {
            final CompanyPostModel selectedPost = companiesPostsList[i];
            return Card(
              color: Colors.grey[100],
              margin: const EdgeInsets.only(
                top: 20,
                right: 20,
                left: 20,
              ),
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
                side: const BorderSide(
                    color: AppColor.primaryColor,
                    // color: AppColor.greenblack,
                    width: 1.5), // الإطار الأخضر كما تحب
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        // أيقونة لتمييز النوع بصرياً
                        CircleAvatar(
                          backgroundColor: Colors.blue.shade50,
                          child: Icon(
                            Icons.business,
                            color: Colors.blue,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(companiesPostsList[i].jobTitle!,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 16)),
                            Text("أنا",
                                style: const TextStyle(
                                    color: Colors.grey, fontSize: 12)),
                          ],
                        ),
                        const Spacer(),
                      ],
                    ),
                    const SizedBox(height: 15),
                    // زر الحذف
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.only(
                          top: 10,
                        ),
                        child: CustomButton(
                          text: "رؤية الطلبات الواردة",
                          onPressed: () {
                            controller.goToPostDetails();
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    ));
  }
}
