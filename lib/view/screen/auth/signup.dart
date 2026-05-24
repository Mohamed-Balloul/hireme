import 'package:hireme/controller/auth/signup_controller.dart';
import 'package:hireme/core/class/handlingdataview.dart';
import 'package:hireme/core/class/statusrequest.dart';
import 'package:hireme/core/constant/color.dart';
import 'package:hireme/core/constant/imageassets.dart';
import 'package:hireme/core/functions/validinput.dart';
import 'package:hireme/view/widget/auth/custombuttonauth.dart';
import 'package:hireme/view/widget/auth/customdropdownlist.dart';
import 'package:hireme/view/widget/auth/customtextbodyauth.dart';
import 'package:hireme/view/widget/auth/customtextformauthwithlabel.dart';
import 'package:hireme/view/widget/auth/customtexttitleauth.dart';
import 'package:hireme/view/widget/auth/textsignup.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class SignUp extends StatelessWidget {
  const SignUp({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(
      () => SignUpControllerImp(),
    );

    return SafeArea(
      child: Scaffold(
        body: GetBuilder<SignUpControllerImp>(
            builder: (controller) => HandlingDataRequest(
                  statusRequest: controller.statusRequest,
                  widget: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    // margin: EdgeInsets.symmetric(horizontal: 0),
                    child: Form(
                      key: controller.formState,
                      child: ListView(
                        children: [
                          const Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(
                                  bottom: 8,
                                  top: 40,
                                ),
                                child: CustomTextTitleAuth(
                                  text: "إنشاء حساب",
                                ),
                              ),
                              CustomTextBodyAuth(
                                text: "أهلا بك!",
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          //--
                          Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                  bottom: 15,
                                  top: 15,
                                ),
                                child: CustomTextFormAuthWithLablel(
                                  valid: (val) {
                                    return validInput(val!, 6, 30, "username");
                                  },
                                  mycontroller: controller.name,
                                  labelText: "الاسم",
                                  hintText: "ادخل اسمك",
                                  iconData: Icons.person_outline,
                                  isNumber: false,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 15),
                                child: CustomTextFormAuthWithLablel(
                                  valid: (val) {
                                    return validInput(val!, 5, 100, "email");
                                  },
                                  mycontroller: controller.email,
                                  labelText: "البريد الإالكتروني",
                                  hintText: "ادخل بريدك الإلكتروني",
                                  iconData: Icons.email_outlined,
                                  isNumber: false,
                                ),
                              ),
                              //--
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  GetBuilder<SignUpControllerImp>(
                                    builder: (controller) {
                                      return Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 15),
                                        child: CustomTextFormAuthWithLablel(
                                          onTapIcon: () {
                                            controller.showHidePassword();
                                          },
                                          obscureText:
                                              controller.isPasswordHidden,
                                          valid: (val) {
                                            return validInput(
                                                val!, 5, 30, "password");
                                          },
                                          mycontroller: controller.password,
                                          labelText: "كلمة المرور",
                                          hintText: "ادخل كلمة المرور",
                                          iconData:
                                              controller.isPasswordHidden ==
                                                      true
                                                  ? Icons.visibility_off
                                                  : Icons.visibility,
                                          isNumber: false,
                                        ),
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ],
                          ),

                          Column(
                            children: [
                              const Padding(
                                padding: EdgeInsets.only(
                                    bottom: 0), // إضافة مسافة تحت الحقل
                                child: CustomDropdownList(
                                  labelText: "نوع الحساب",
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 7, bottom: 8),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Checkbox(
                                      activeColor: AppColor.primaryColor,
                                      value: controller.isChecked,
                                      onChanged: (value) {
                                        controller.onCheck(value);
                                      },
                                    ),
                                    // تحويل النص العادي إلى RichText ليصبح جزء منه قابلاً للضغط
                                    Expanded(
                                      child: InkWell(
                                        onTap: () => controller
                                            .goToTerms(), // جعل السطر كاملاً يفتح الشروط أو الكلمة فقط
                                        child: Text.rich(
                                          TextSpan(
                                            children: [
                                              const TextSpan(
                                                  text: 'أوافق على '),
                                              TextSpan(
                                                text: 'شروط الاستخدام',
                                                style: TextStyle(
                                                  color: AppColor.primaryColor,
                                                  fontWeight: FontWeight.bold,
                                                  decoration:
                                                      TextDecoration.underline,
                                                  // وضع خط تحتها للتوحي بالضغط
                                                ),
                                              ),
                                            ],
                                          ),
                                          style: const TextStyle(fontSize: 13),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),

                          //-- تعديل الزر
                          Padding(
                            padding: const EdgeInsets.only(
                              bottom: 25,
                              top: 20,
                            ),
                            child: CustomButtonAuth(
                              text: "إنشاء حساب",
                              // المنطق: إذا لم يوافق على الشروط، نمرر null للـ onPressed ليصبح الزر غير فعال (باهت)
                              onPressed: controller.isChecked
                                  ? () {
                                      controller.signUp();
                                    }
                                  : null,
                            ),
                          ),
                          //*-
                          CustomTextSignUpOrSignIn(
                            textone: "هل لديك حساب بالفعل؟ ",
                            texttwo: " تسجيل الدخول",
                            onTap: () {
                              controller.goToSignIn();
                            },
                          )
                        ],
                      ),
                    ),
                  ),
                )),
      ),
    );
  }
}
