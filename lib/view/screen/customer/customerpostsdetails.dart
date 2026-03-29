import 'package:hireme/controller/customer/customerpostsdetails_controller.dart';
import 'package:hireme/core/constant/color.dart';
import 'package:hireme/data/datasource/static/static.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hireme/view/widget/checkout/custombutton.dart';

class CustomerPostsDetails extends StatelessWidget {
  const CustomerPostsDetails({super.key});

  @override
  Widget build(BuildContext context) {
    CustomerPostsDetailsControllerImp controller =
        Get.put(CustomerPostsDetailsControllerImp());
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            "hireMe",
            style: TextStyle(
              fontSize: 30,
            ),
          ),
          foregroundColor: Colors.white,
          centerTitle: true,
          backgroundColor: AppColor.primaryColor,
        ),
        // -- drawer

        // -- end drawer

        floatingActionButton: FloatingActionButton(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(100),
              side: BorderSide(
                width: 2,
                color: AppColor.primaryColor,
              )),
          // backgroundColor: AppColor.litegrey,
          backgroundColor: AppColor.primaryColor,
          onPressed: () {
            controller.goToAddCustomerPost();
          },
          child: Icon(
            Icons.add,
            // color: AppColor.primaryColor,
            color: Colors.white,
          ),
        ),
        body: Container(
          child: ListView.builder(
            itemCount: freelancerPostsList.length,
            itemBuilder: (context, i) {
              // final CompanyPostModel selectedPost = companyPostsList[i];
              return Padding(
                padding: const EdgeInsets.all(15),
                child: Card(
                  elevation: 5,
                  child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                            bottom: 15,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    Icons.layers_outlined,
                                    color: AppColor.primaryColor,
                                    // Icons.work_outline,
                                    size: 18,
                                  ),
                                  const Text(
                                    " اسم الخدمة المطلوبة :",
                                    style: TextStyle(
                                      color: AppColor.primaryColor,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              Text(freelancerPostsList[i].serviceTitle!),
                            ],
                          ),
                        ),
                        // Divider(),
                        Padding(
                          padding: const EdgeInsets.only(
                            bottom: 15,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    Icons.handyman_outlined,
                                    color: AppColor.primaryColor,
                                    // Icons.assignment_outlined,
                                    size: 18,
                                  ),
                                  const Text(
                                    " الأدوات المطلوب استخدامها لإنجاز الخدمة :",
                                    style: TextStyle(
                                      color: AppColor.primaryColor,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              ...List.generate(
                                  freelancerPostsList[i].tools!.length, (j) {
                                return Text("${j + 1}) " +
                                    freelancerPostsList[i].tools![j]);
                              }),
                            ],
                          ),
                        ),
                        //
                        Padding(
                          padding: const EdgeInsets.only(
                            bottom: 15,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    Icons.description_outlined,
                                    color: AppColor.primaryColor,
                                    // Icons.edit_note,
                                    // Icons.delete_outline,
                                    size: 18,
                                  ),
                                  const Text(
                                    " وصف الخدمة :",
                                    style: TextStyle(
                                      color: AppColor.primaryColor,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              Text(freelancerPostsList[i].description!),
                            ],
                          ),
                        ),

                        //
                        Padding(
                          padding: const EdgeInsets.only(
                            bottom: 15,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    // Icons.info_outline,
                                    Icons.attach_file,
                                    color: AppColor.primaryColor,
                                    // Icons.edit_note,
                                    // Icons.delete_outline,
                                    size: 18,
                                  ),
                                  const Text(
                                    " تفاصيل إضافية :",
                                    style: TextStyle(
                                      color: AppColor.primaryColor,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              Text(freelancerPostsList[i].files!),
                            ],
                          ),
                        ),

                        //
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                top: 20,
                                left: 20,
                              ),
                              child: Center(
                                child: CustomButton(
                                  text: "تعديل ",
                                  onPressed: () {
                                    controller.goToEditPost();
                                  },
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                top: 20,
                              ),
                              child: Center(
                                child: CustomButton(
                                  text: "حذف",
                                  onPressed: () {},
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
