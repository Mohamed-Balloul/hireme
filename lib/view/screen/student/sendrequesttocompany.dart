import 'package:hireme/controller/student/sendrequesttocompany_controller.dart';
import 'package:hireme/core/constant/color.dart';
import 'package:hireme/core/functions/validinput.dart';
import 'package:hireme/data/model/companiespostmodel.dart';
import 'package:hireme/view/widget/auth/custombuttonauth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hireme/view/widget/company/customtextformwithlabel.dart';
import 'package:hireme/view/widget/customer/SingleFile.dart';

class SendRequestToCompany extends StatelessWidget {
  final CompaniesPostModel companiesPostModel;
  const SendRequestToCompany({super.key, required this.companiesPostModel});

  @override
  Widget build(BuildContext context) {
    Get.put(
      SendRequestToCompanyControllerImp(),
    );

    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: Text(
          "إرسال طلب العمل",
          style: TextStyle(),
        ),
        foregroundColor: Colors.white,
        centerTitle: true,
        backgroundColor: AppColor.primaryColor,
      ),
      body: GetBuilder<SendRequestToCompanyControllerImp>(
        builder: (controller) => Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Form(
            key: controller.formState,
            child: ListView(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 30, bottom: 16),
                      child: const Text(
                        "يرجى تعبئة الحقول المطلوبة التالية :",
                        style: TextStyle(
                            // fontSize: 14,
                            // fontWeight: FontWeight.bold,
                            ),
                      ),
                    ),
                    //--
                    if (companiesPostModel.isCvRequired!)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "ملف السيرة الذاتية :",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          controller.cvFile != null
                              ? SingleFile(
                                  singleFile: controller.cvFile,
                                  fileHandler: controller,
                                )
                              : InkWell(
                                  onTap: () {
                                    controller.pickAndAddCvFile();
                                  },
                                  child: Container(
                                    margin: EdgeInsets.symmetric(vertical: 20),
                                    width: 80,
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            width: 1,
                                            color: AppColor.primaryColor),
                                        borderRadius: BorderRadius.circular(5)),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.add,
                                          size: 15,
                                        ),
                                        Text("إضافة")
                                      ],
                                    ),
                                  ),
                                ),
                        ],
                      ),
                    //--
                    if (companiesPostModel.isGitHubOrPortfolioRequired!)
                      Padding(
                        padding: const EdgeInsets.only(
                          bottom: 15,
                          top: 40,
                        ),
                        child: CustomTextFormWithLablel(
                          valid: (val) {
                            return validInput(val!, 6, 30, "username");
                          },
                          mycontroller: controller.githubLinkController,
                          labelText: "رابط حسابك على Git Hub :",
                          hintText: "ادخل الرابط هنا",
                          iconData: Icons.link,
                          isNumber: false,
                        ),
                      ),
                    //--
                    if (companiesPostModel.isSalaryRequired!)
                      Padding(
                        padding: const EdgeInsets.only(
                          bottom: 15,
                          top: 30,
                        ),
                        child: CustomTextFormWithLablel(
                          valid: (val) {
                            return validInput(val!, 6, 30, "username");
                          },
                          mycontroller: controller.expectedSalaryController,
                          labelText: "الراتب المتوقع :",
                          hintText: "ادخل الراتب المتوقع هنا",
                          iconData: Icons.attach_money,
                          isNumber: false,
                        ),
                      ),
                    const SizedBox(height: 30),
                  ],
                ),

                //--
                Padding(
                  padding: const EdgeInsets.only(
                    bottom: 25,
                  ),
                  child: CustomButtonAuth(
                    text: "إرسال",
                    onPressed: () {
                      controller.createAndSendApplicationToCompany(
                          companiesPostModel.id!);
                    },
                  ),
                ),
                //--
              ],
            ),
          ),
        ),
      ),
    ));
  }
}
