import 'package:hireme/controller/student/sendrequesttocustomer_controller.dart';
import 'package:hireme/core/constant/color.dart';
import 'package:hireme/core/functions/validinput.dart';
import 'package:hireme/view/widget/auth/custombuttonauth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hireme/view/widget/company/customtextformwithlabel.dart';
import 'package:hireme/view/widget/customer/SingleFile.dart';

class SendRequestToCustomer extends StatelessWidget {
  const SendRequestToCustomer({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(
      SendRequestToCustomerControllerImp(),
    );

    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: Text(
          "إرسال طلب أداء الخدمة",
          style: TextStyle(),
        ),
        foregroundColor: Colors.white,
        centerTitle: true,
        backgroundColor: AppColor.primaryColor,
      ),
      body: GetBuilder<SendRequestToCustomerControllerImp>(
        builder: (controller) => Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Form(
            key: controller.formState,
            child: ListView(
              children: [
                // const Column(
                //   children: [
                //     Padding(
                //       padding: EdgeInsets.only(
                //         bottom: 8,
                //         top: 40,
                //       ),
                //       child: CustomTextTitleAuth(
                //         text: "إرسال الطلب",
                //       ),
                //     ),
                //   ],
                // ),
                //--
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 30, bottom: 16),
                      child: const Text(
                        "يرجى تعبئة الحقول المطلوبة التالية :",
                        style: TextStyle(
                          // fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    //--

                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("ملف السيرة الذاتية :"),
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
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
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
                        labelText: "الأجر المطلوب مقابل تقديم الخدمة :",
                        hintText: "ادخل المبلغ المطلوب هنا",
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
                      // controller.signUp();
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
