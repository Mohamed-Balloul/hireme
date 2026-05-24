import 'package:hireme/controller/auth/login_controller.dart';
import 'package:hireme/core/class/handlingdataview.dart';
import 'package:hireme/core/class/statusrequest.dart';
import 'package:hireme/core/constant/color.dart';
import 'package:hireme/core/functions/validinput.dart';
import 'package:hireme/view/widget/auth/custombuttonauth.dart';
import 'package:hireme/view/widget/auth/customtextbodyauth.dart';
import 'package:hireme/view/widget/auth/customtextformauthwithlabel.dart';
import 'package:hireme/view/widget/auth/customtexttitleauth.dart';
import 'package:hireme/view/widget/auth/textsignup.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => LoginControllerImp());

    return SafeArea(
        child: Scaffold(
      body: GetBuilder<LoginControllerImp>(
          builder: (controller) => HandlingDataRequest(
                statusRequest: controller.statusRequest,
                widget: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
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
                                text: "تسجيل الدخول",
                              ),
                            ),
                            //--
                            CustomTextBodyAuth(
                              text: "مرحبا بك من جديد!",
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        //--
                        //--
                        Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                bottom: 20,
                                top: 30,
                              ),
                              child: CustomTextFormAuthWithLablel(
                                obscureText: false,
                                valid: (val) {
                                  return validInput(val!, 5, 100, "email");
                                },
                                mycontroller: controller.email,
                                labelText: "البريد الإلكتروني",
                                hintText: "ادخل بريدك الإلكتروني",
                                iconData: Icons.email_outlined,
                                isNumber: false,
                              ),
                            ),
                            //--
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                GetBuilder<LoginControllerImp>(
                                  builder: (controller) {
                                    return CustomTextFormAuthWithLablel(
                                      onTapIcon: () {
                                        controller.showHidePassword();
                                      },
                                      obscureText: controller.isPasswordHidden,
                                      valid: (val) {
                                        return validInput(
                                            val!, 5, 30, "password");
                                      },
                                      mycontroller: controller.password,
                                      labelText: "كلمة المرور",
                                      hintText: "ادخل كلمة المرور",
                                      iconData:
                                          controller.isPasswordHidden == true
                                              ? Icons.visibility_off
                                              : Icons.visibility,
                                      isNumber: false,
                                    );
                                  },
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                    top: 3,
                                    bottom: 30,
                                  ),
                                  child: InkWell(
                                    onTap: () {
                                      controller.goToForgetPassword();
                                    },
                                    child: const Text(
                                      "هل نسيت كلمة المرور؟",
                                      style: TextStyle(
                                        decoration: TextDecoration.underline,
                                        color: AppColor.primaryColor,
                                        fontWeight: FontWeight.w500,
                                        // fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        //--
                        Padding(
                          padding: const EdgeInsets.only(bottom: 25, top: 20),
                          child: CustomButtonAuth(
                            text: "تسجيل الدخول",
                            onPressed: () {
                              controller.login();
                            },
                          ),
                        ),
                        //--
                        CustomTextSignUpOrSignIn(
                          textone: "أليس لديك حساب؟  ",
                          texttwo: "إنشاء حساب",
                          onTap: () {
                            controller.goToSignUp();
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              )),
    ));
  }
}
