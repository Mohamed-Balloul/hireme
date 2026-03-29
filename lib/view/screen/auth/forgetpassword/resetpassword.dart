import 'package:hireme/controller/auth/resetpassword_controller.dart';
// import 'package:hireme/core/constant/color.dart';
import 'package:hireme/core/functions/validinput.dart';
import 'package:hireme/view/widget/auth/custombuttonauth.dart';
import 'package:hireme/view/widget/auth/customtextbodyauth.dart';
import 'package:hireme/view/widget/auth/customtextformauthwithlabel.dart';
import 'package:hireme/view/widget/auth/customtexttitleauth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ResetPassword extends StatelessWidget {
  const ResetPassword({super.key});

  @override
  Widget build(BuildContext context) {
    // ResetPasswordControllerImp controller =
    //     Get.put(ResetPasswordControllerImp());
    Get.lazyPut(() => ResetPasswordControllerImp());
    return SafeArea(child: Scaffold(
      body: GetBuilder<ResetPasswordControllerImp>(builder: (controller) {
        return Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
          ),
          child: Form(
            key: controller.formState,
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
                        text: "تعيين كلمة مرور جديدة",
                      ),
                    ),
                    //--
                    CustomTextBodyAuth(
                      text:
                          "كلمة المرور الجديدة يجب أن تكون مختلفة عن الكلمة السابقة",
                    ),
                  ],
                ),
                //--
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                        bottom: 20,
                        top: 50,
                      ),
                      child: GetBuilder<ResetPasswordControllerImp>(
                        builder: (controller) {
                          return CustomTextFormAuthWithLablel(
                            onTapIcon: () {
                              controller.showHidePassword();
                            },
                            obscureText: controller.isPasswordHidden,
                            valid: (val) {
                              return validInput(val!, 5, 30, "password");
                            },
                            mycontroller: controller.password,
                            labelText: "كلمة المرور الجديدة",
                            hintText: "ادخل كلمة المرور الجديدة",
                            iconData: controller.isPasswordHidden == true
                                ? Icons.visibility_off
                                : Icons.visibility,
                            isNumber: false,
                          );
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        bottom: 20,
                      ),
                      child: GetBuilder<ResetPasswordControllerImp>(
                        builder: (controller) {
                          return CustomTextFormAuthWithLablel(
                            onTapIcon: () {
                              controller.showHidePassword();
                            },
                            obscureText: controller.isPasswordHidden,
                            valid: (val) {
                              return validInput(val!, 5, 30, "password");
                            },
                            mycontroller: controller.confirmPassword,
                            labelText: "تأكيد كلمة المرور",
                            hintText: "ادخل كلمة المرور الجديدة",
                            iconData: controller.isPasswordHidden == true
                                ? Icons.visibility_off
                                : Icons.visibility,
                            isNumber: false,
                          );
                        },
                      ),
                    ),
                    // controller.confirmPassword.text == controller.password.text
                    //     ? Container()
                    //     : Text("hi"),
                    controller.checkPasswords(),
                    //--
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 20,
                      ),
                      child: CustomButtonAuth(
                        onPressed: () {
                          controller.goToSuccessResetPassword();
                        },
                        text: "تأكيد",
                      ),
                    ),
                  ],
                ),
                //--
              ],
            ),
          ),
        );
      }),
    ));
  }
}
