import 'package:hireme/controller/auth/VerfiyCodeSignUp_controller.dart';
import 'package:hireme/core/class/handlingdataview.dart';
import 'package:hireme/core/class/statusrequest.dart';
import 'package:hireme/core/constant/color.dart';
import 'package:hireme/view/widget/auth/customtextbodyauth.dart';
import 'package:hireme/view/widget/auth/customtexttitleauth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:get/get.dart';

class VerfiyCodeSignUp extends StatelessWidget {
  const VerfiyCodeSignUp({super.key});

  @override
  Widget build(BuildContext context) {
    // VerfiyCodeSignUpControllerImp controller =
    Get.put(VerfiyCodeSignUpControllerImp());
    return SafeArea(
      child: Scaffold(
        body: GetBuilder<VerfiyCodeSignUpControllerImp>(
            builder: (controller) => HandlingDataRequest(
                  statusRequest: controller.statusRequest,
                  widget: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: ListView(
                      children: [
                        const Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(
                                bottom: 8,
                                top: 60,
                              ),
                              child: CustomTextTitleAuth(
                                text: "تأكيد البريد الإلكتروني",
                              ),
                            ),
                            //--
                            CustomTextBodyAuth(
                              text:
                                  "من فضلك ادخل رمز التحقق الذي أرسلناه للتو الى بريدك الإلكتروني",
                            ),
                          ],
                        ),

                        //--
                        Padding(
                          padding: const EdgeInsets.only(
                            bottom: 25,
                            top: 30,
                          ),
                          child: Directionality(
                            textDirection: TextDirection.ltr,
                            child: OtpTextField(
                              fieldWidth: 45,
                              borderRadius: BorderRadius.circular(20),
                              numberOfFields: 6,
                              borderColor: AppColor.primaryColor,
                              cursorColor: AppColor.primaryColor,
                              focusedBorderColor: AppColor.primaryColor,
                              //set to true to show as box or false to show as dash
                              showFieldAsBox: true,
                              //runs when a code is typed in
                              onCodeChanged: (String code) {
                                //handle validation or checks here
                              },
                              //runs when every textfield is filled
                              onSubmit: (String verificationCode) {
                                controller.goToSuccessSignUp(verificationCode);
                              }, // end onSubmit
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )),
      ),
    );
    // return SafeArea(
    //   child: Scaffold(
    //     body: GetBuilder<VerfiyCodeSignUpControllerImp>(
    //       builder: (controller) => controller.statusRequest ==
    //               StatusRequest.loading
    //           ? Center(
    //               child: Text("loading..."),
    //             )
    //           : Container(
    //               padding: const EdgeInsets.symmetric(horizontal: 20),
    //               child: ListView(
    //                 children: [
    //                   const Column(
    //                     children: [
    //                       Padding(
    //                         padding: EdgeInsets.only(
    //                           bottom: 8,
    //                           top: 60,
    //                         ),
    //                         child: CustomTextTitleAuth(
    //                           text: "تأكيد البريد الإلكتروني",
    //                         ),
    //                       ),
    //                       //--
    //                       CustomTextBodyAuth(
    //                         text:
    //                             "من فضلك ادخل رمز التحقق الذي أرسلناه للتو الى بريدك الإلكتروني",
    //                       ),
    //                     ],
    //                   ),

    //                   //--
    //                   Padding(
    //                     padding: const EdgeInsets.only(
    //                       bottom: 25,
    //                       top: 30,
    //                     ),
    //                     child: Directionality(
    //                       textDirection: TextDirection.ltr,
    //                       child: OtpTextField(
    //                         fieldWidth: 45,
    //                         borderRadius: BorderRadius.circular(20),
    //                         numberOfFields: 6,
    //                         borderColor: AppColor.primaryColor,
    //                         cursorColor: AppColor.primaryColor,
    //                         focusedBorderColor: AppColor.primaryColor,
    //                         //set to true to show as box or false to show as dash
    //                         showFieldAsBox: true,
    //                         //runs when a code is typed in
    //                         onCodeChanged: (String code) {
    //                           //handle validation or checks here
    //                         },
    //                         //runs when every textfield is filled
    //                         onSubmit: (String verificationCode) {
    //                           controller.goToSuccessSignUp(verificationCode);
    //                         }, // end onSubmit
    //                       ),
    //                     ),
    //                   ),
    //                 ],
    //               ),
    //             ),
    //     ),
    //   ),
    // );
  }
}
