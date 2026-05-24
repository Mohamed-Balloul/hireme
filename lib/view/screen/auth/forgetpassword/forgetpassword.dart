import 'package:hireme/controller/forgetpassword/forgetpassword_controller.dart';
import 'package:hireme/core/class/handlingdataview.dart';
import 'package:hireme/core/constant/color.dart';
import 'package:hireme/core/functions/validinput.dart';
import 'package:hireme/view/widget/auth/custombuttonauth.dart';
import 'package:hireme/view/widget/auth/customtextbodyauth.dart';
import 'package:hireme/view/widget/auth/customtextformauthwithlabel.dart';
import 'package:hireme/view/widget/auth/customtexttitleauth.dart';
// import 'package:hireme/view/widget/customappbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ForgetPassword extends StatelessWidget {
  const ForgetPassword({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => ForgetPasswordControllerImp());
    return SafeArea(
        child: Scaffold(
      body: GetBuilder<ForgetPasswordControllerImp>(
          builder: (controller) => HandlingDataRequest(
                statusRequest: controller.statusRequest,
                widget: Scaffold(
                  appBar: AppBar(
                    toolbarHeight: 100,
                    actions: [
                      Padding(
                        padding: const EdgeInsets.only(left: 15),
                        child: IconButton(
                          onPressed: () {
                            controller.backToSignIn();
                          },
                          icon: const Icon(
                            size: 40,
                            Icons.arrow_circle_left_outlined,
                            color: AppColor.primaryColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                  body: Container(
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
                                ),
                                child: CustomTextTitleAuth(
                                  text: "نسيان كلمة المرور",
                                ),
                              ),
                              //--
                              CustomTextBodyAuth(
                                text:
                                    "نحن بحاجة الى تأكيد هويتك، من فضلك ادخل بريدك الإلكتروني، سوف نرسل رمز تحقق الى بريدك ",
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          //--
                          Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                  bottom: 20,
                                  top: 40,
                                ),
                                child: CustomTextFormAuthWithLablel(
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
                              Padding(
                                padding: const EdgeInsets.only(
                                  bottom: 25,
                                ),
                                child: CustomButtonAuth(
                                  onPressed: () {
                                    controller.checkEmail();
                                  },
                                  text: "إرسال",
                                ),
                              ),
                            ],
                          ),
                          //--
                        ],
                      ),
                    ),
                  ),
                ),
              )),
    ));
    // return SafeArea(
    //   child: GetBuilder<ForgetPasswordControllerImp>(
    //     builder: (controller) => Scaffold(
    //       appBar: AppBar(
    //         toolbarHeight: 100,
    //         actions: [
    //           Padding(
    //             padding: const EdgeInsets.only(left: 15),
    //             child: IconButton(
    //               onPressed: () {
    //                 controller.backToSignIn();
    //               },
    //               icon: const Icon(
    //                 size: 40,
    //                 Icons.arrow_circle_left_outlined,
    //                 color: AppColor.primaryColor,
    //               ),
    //             ),
    //           ),
    //         ],
    //       ),
    //       body: Container(
    //         padding: const EdgeInsets.symmetric(horizontal: 20),
    //         child: Form(
    //           key: controller.formState,
    //           child: ListView(
    //             children: [
    //               const Column(
    //                 children: [
    //                   Padding(
    //                     padding: EdgeInsets.only(
    //                       bottom: 8,
    //                     ),
    //                     child: CustomTextTitleAuth(
    //                       text: "نسيان كلمة المرور",
    //                     ),
    //                   ),
    //                   //--
    //                   CustomTextBodyAuth(
    //                     text:
    //                         "نحن بحاجة الى تأكيد هويتك، من فضلك ادخل بريدك الإلكتروني، سوف نرسل رمز تحقق الى بريدك ",
    //                   ),
    //                 ],
    //               ),
    //               SizedBox(
    //                 height: 15,
    //               ),
    //               //--
    //               Column(
    //                 children: [
    //                   Padding(
    //                     padding: const EdgeInsets.only(
    //                       bottom: 20,
    //                       top: 40,
    //                     ),
    //                     child: CustomTextFormAuthWithLablel(
    //                       valid: (val) {
    //                         return validInput(val!, 5, 100, "email");
    //                       },
    //                       mycontroller: controller.email,
    //                       labelText: "البريد الإلكتروني",
    //                       hintText: "ادخل بريدك الإلكتروني",
    //                       iconData: Icons.email_outlined,
    //                       isNumber: false,
    //                     ),
    //                   ),

    //                   //--
    //                   Padding(
    //                     padding: const EdgeInsets.only(
    //                       bottom: 25,
    //                     ),
    //                     child: CustomButtonAuth(
    //                       onPressed: () {
    //                         controller.checkEmail();
    //                       },
    //                       text: "إرسال",
    //                     ),
    //                   ),
    //                 ],
    //               ),
    //               //--
    //             ],
    //           ),
    //         ),
    //       ),
    //     ),
    //   ),
    // );
  }
}
