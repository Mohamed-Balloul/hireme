import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hireme/core/constant/color.dart';
import 'package:hireme/view/widget/auth/custombuttonauth.dart';

class TermsAndConditions extends StatelessWidget {
  const TermsAndConditions({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            "شروط الاستخدام",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
          backgroundColor: Colors.white,
          foregroundColor: AppColor.primaryColor,
        ),
        body: Column(
          children: [
            Divider(
              color: AppColor.primaryColor,
              height: 1,
              thickness: 1.5,
            ),
            SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Directionality(
                textDirection: TextDirection.rtl,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "سياسة الاستخدام والخصوصية",
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: AppColor.primaryColor),
                    ),
                    const SizedBox(height: 15),
                    const Text(
                      "1. مقدمة: باستخدامك لتطبيق hireMe، فإنك توافق على الالتزام بالشروط التالية...\n\n"
                      "2. الحسابات: يجب أن تكون المعلومات المقدمة عند إنشاء الحساب دقيقة وكاملة...\n\n"
                      "3. السلوك: يلتزم المستخدم بعدم استخدام المنصة لأي أغراض غير قانونية...\n\n"
                      "4. الخصوصية: نحن نحترم خصوصيتك ونلتزم بحماية بياناتك الشخصية وفقاً للمعايير الدولية...",
                      style: TextStyle(
                          fontSize: 15, height: 1.6, color: Colors.black87),
                    ),
                    const SizedBox(height: 30),
                    // Center(
                    //   child: MaterialButton(
                    //     color: AppColor.primaryColor,
                    //     textColor: Colors.white,
                    //     onPressed: () => Get.back(),
                    //     child: const Text("فهمت ذلك"),
                    //   ),
                    // )
                    Padding(
                      padding: const EdgeInsets.only(
                        bottom: 25,
                        top: 20,
                      ),
                      child: CustomButtonAuth(
                        text: "تم",
                        // المنطق: إذا لم يوافق على الشروط، نمرر null للـ onPressed ليصبح الزر غير فعال (باهت)
                        onPressed: () {
                          Get.back();
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
