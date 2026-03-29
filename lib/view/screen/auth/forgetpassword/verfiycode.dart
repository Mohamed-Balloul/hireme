import 'package:hireme/controller/auth/verfiycode_controller.dart';
import 'package:hireme/core/constant/color.dart';

import 'package:hireme/view/widget/auth/customtextbodyauth.dart';

import 'package:hireme/view/widget/auth/customtexttitleauth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:get/get.dart';

class VerfiyCode extends StatelessWidget {
  const VerfiyCode({super.key});

  @override
  Widget build(BuildContext context) {
    VerfiyCodeControllerImp controller = Get.put(VerfiyCodeControllerImp());
    return SafeArea(
        child: Scaffold(
      body: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
        ),
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
                  text: "من فضلك ادخل رمز التحقق الذي أرسلناه للتو الى بريدك",
                ),
              ],
            ),

            // --
            Padding(
              padding: const EdgeInsets.only(
                bottom: 25,
                top: 30,
              ),
              child: Directionality(
                textDirection: TextDirection.ltr,
                child: OtpTextField(
                  fieldWidth: 50,
                  borderRadius: BorderRadius.circular(20),
                  numberOfFields: 5,
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
                    controller.goToResetPassword();
                  }, // end onSubmit
                ),
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
