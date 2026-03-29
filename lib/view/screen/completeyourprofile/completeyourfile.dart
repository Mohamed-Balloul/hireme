import 'package:hireme/controller/completeyourprofile/completeyourfile_controller.dart';
import 'package:hireme/core/functions/validinput.dart';
import 'package:hireme/view/widget/auth/custombuttonauth.dart';
import 'package:hireme/view/widget/auth/customtextbodyauth.dart';
import 'package:hireme/view/widget/auth/customtextformauthwithlabel.dart';
import 'package:hireme/view/widget/auth/customtexttitleauth.dart';
import 'package:hireme/view/widget/completeyourprofile/customdropdownlist.dart';
import 'package:hireme/view/widget/completeyourprofile/customstackprofilephoto.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CompleteYourProfile extends StatelessWidget {
  const CompleteYourProfile({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(
      () => CompleteYourProfileControllerImp(),
    );
    return SafeArea(
        child: Scaffold(
      body: GetBuilder<CompleteYourProfileControllerImp>(
        builder: (controller) => Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Form(
            key: controller.formState,
            child: ListView(
              children: [
                Column(
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(
                        bottom: 8,
                        top: 60,
                      ),
                      child: CustomTextTitleAuth(
                        text: "Complete Your Profile",
                      ),
                    ),
                    //--
                    const CustomTextBodyAuth(
                      text:
                          "Don't worry, No one else will be able to see your personal data",
                    ),
                    // Custom Profile Photo
                    CustomStackProfilePhoto(),
                  ],
                ),
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
                            return validInput(val!, 5, 100, "phone");
                          },
                          mycontroller: controller.phoneNumber,
                          labelText: "Phone Number",
                          hintText: "Enter your phone number",
                          iconData: Icons.phone_android,
                          isNumber: true),
                    ),
                    CustomDropdownList(
                      labelText: "Gender",
                    ),
                  ],
                ),
                //--
                Padding(
                  padding: const EdgeInsets.only(
                    top: 40,
                  ),
                  child: CustomButtonAuth(
                    text: "Complete Profile",
                    onPressed: () {
                      controller.completeYourProfile();
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
