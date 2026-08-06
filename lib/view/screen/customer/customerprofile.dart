import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:hireme/controller/customer/customerprofile_controller.dart';
import 'package:hireme/core/constant/color.dart';
import 'package:hireme/data/datasource/static/static.dart';
import 'package:flutter/material.dart';
import 'package:hireme/data/model/customerprofilemodel.dart';
import 'package:hireme/view/widget/student/buildexperiencecard.dart';
import 'package:hireme/view/widget/student/buildseparator.dart';
import 'package:hireme/view/widget/student/buildsocialbutton.dart';
import 'package:hireme/view/widget/student/buildstateitem.dart';
import 'package:hireme/view/widget/student/profile_dialogs.dart';

class CustomerProfile extends StatelessWidget {
  final CustomerProfileModel customer;
  final bool isMine;

  const CustomerProfile({
    super.key,
    required this.customer,
    this.isMine = true,
  });

  @override
  Widget build(BuildContext context) {
    Get.put(CustomerProfileControllerImp());

    return Scaffold(
      // backgroundColor: const Color(0xFFF8F9FA),
      backgroundColor: Colors.white,
      body: GetBuilder<CustomerProfileControllerImp>(builder: (controller) {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ================= 1. الهيدر (صورة الغلاف + الشخصية) =================
                SizedBox(
                  height: 200,
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      // أ. صورة الغلاف
                      Container(
                        height: 160,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          // المنطق الجديد هنا:
                          gradient: (controller.tempCoverFile == null)
                              ? LinearGradient(
                                  begin: Alignment.bottomCenter,
                                  end: Alignment.topCenter,
                                  colors: [
                                    Colors.black.withOpacity(0.5),
                                    Colors.transparent,
                                  ],
                                  stops: const [0.0, 1],
                                )
                              : null, // لا يوجد تدرج إذا وجدت صورة
                          image: (controller.tempCoverFile != null)
                              ? DecorationImage(
                                  image: FileImage(controller.tempCoverFile!),
                                  fit: BoxFit.cover,
                                )
                              : null,
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                            // طبقة شفافة لزيادة التباين مع الأيقونات البيضاء
                            color: Colors.black.withOpacity(0.2),
                          ),
                        ),
                      ),
                      if (isMine) ...[
                        // --- الزر الجديد: تعديل صورة الغلاف ---
                        Positioned(
                          bottom: 50,
                          left: 10,
                          child: InkWell(
                            onTap: () {
                              if (controller.tempCoverFile == null) {
                                controller.pickCoverImage();
                              } else {
                                ProfileDialogs.showOptionsDialog(
                                  title: "صورة الغلاف",
                                  addLabel: "تعيين صورة غلاف جديدة",
                                  deleteLabel: "حذف صورة الغلاف الحالية",
                                  onAdd: () => controller.pickCoverImage(),
                                  onDelete: () =>
                                      ProfileDialogs.showConfirmDialog(
                                    title:
                                        "هل أنت متأكد أنك تريد حذف صورة الغلاف الحالية؟",
                                    onConfirm: () =>
                                        controller.deleteCoverImage(),
                                  ),
                                );
                              }
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.8),
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Row(
                                children: [
                                  Icon(Icons.camera_alt,
                                      size: 14, color: Colors.black87),
                                  SizedBox(width: 5),
                                  Text(
                                      controller.tempCoverFile != null
                                          ? "تعديل صورة الغلاف"
                                          : "إضافة صورة غلاف",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 9)),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 10,
                          left: 10,
                          child: InkWell(
                            onTap: () {
                              controller
                                  .goToEditCustomerProfileInfo(); //حاليا الواجهة فارغة
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(
                                // color: Colors.grey.withOpacity(0.8),
                                color: Colors.black.withOpacity(0.4),
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.edit,
                                    size: 14,
                                    color: Colors.white,
                                    // color: Colors.black87,
                                  ),
                                  SizedBox(width: 5),
                                  Text(
                                    "تعديل المعلومات",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                      fontSize: 9,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],

                      // ج. الصورة الشخصية
                      Positioned(
                        bottom: 0,
                        right: 20,
                        child: Stack(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                                //
                                gradient: LinearGradient(
                                  begin: Alignment.bottomCenter,
                                  end: Alignment.topCenter,
                                  colors: [
                                    Colors.black.withOpacity(0.5),
                                    Colors.transparent,
                                  ],
                                  stops: const [0.0, 1],
                                ),
                                //
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.15),
                                    blurRadius: 10,
                                    offset: const Offset(0, 5),
                                  ),
                                ],
                              ),
                              child: CircleAvatar(
                                radius: 50,
                                backgroundColor: Colors.grey[50],
                                // backgroundColor: Colors.white,
                                backgroundImage: (controller.tempPersonalFile !=
                                        null)
                                    ? FileImage(controller.tempPersonalFile!)
                                    : null,
                                child: (controller.tempPersonalFile == null)
                                    ? Icon(
                                        Icons.person,
                                        color: Colors.black54,
                                        size: 50,
                                      )
                                    : null,
                              ),
                            ),
                            if (isMine) ...[
                              Positioned(
                                bottom: 6,
                                left: 3,
                                child: InkWell(
                                  onTap: () {
                                    if (controller.tempPersonalFile == null) {
                                      controller.pickPersonalImage();
                                    } else {
                                      ProfileDialogs.showOptionsDialog(
                                        title: "الصورة الشخصية",
                                        addLabel: "تعيين صورة شخصية جديدة",
                                        deleteLabel:
                                            "حذف الصورة الشخصية الحالية",
                                        onAdd: () =>
                                            controller.pickPersonalImage(),
                                        onDelete: () =>
                                            ProfileDialogs.showConfirmDialog(
                                          title:
                                              "هل أنت متأكد أنك تريد حذف الصورة الشخصية الحالية؟",
                                          onConfirm: () =>
                                              controller.deletePersonalImage(),
                                        ),
                                      );
                                    }
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(100),
                                      border: Border.all(
                                        width: 1.6,
                                        color: AppColor.black,
                                      ),
                                    ),
                                    child: CircleAvatar(
                                      radius: 11,
                                      backgroundColor:
                                          Colors.white.withOpacity(1),
                                      child: const Icon(
                                        Icons.camera_alt,
                                        color: Colors.black87,
                                        size: 14,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 10),

                // ================= 2. المعلومات الأساسية والملخص =================
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // الاسم
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        child: Text(
                          customer.name!,
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w800,
                            color: Colors.black87,
                          ),
                        ),
                      ),

                      const SizedBox(height: 2),

                      // المسمى الوظيفي
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        child: Text(
                          customer.jobLabel!,
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.grey[600],
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),

                      const SizedBox(height: 30),

                      // ---------------------------------------------
                      // التعديل الجديد: قسم الإحصائيات (3 أعمدة متساوية)
                      // ---------------------------------------------

                      // Row(
                      //   children: [
                      //     // العمود 1: الموقع
                      //     BuildStateItem(
                      //       icon: Icons.location_on_outlined,
                      //       value: customer.city!,
                      //       label: "مكان الإقامة",
                      //       color: Colors.grey,
                      //     ),

                      //     BuildSeparator(),

                      //     // العمود 2: الراتب
                      //     BuildStateItem(
                      //       icon: Icons.monetization_on_outlined,
                      //       value: "\$${customer.hourlySalary!}",
                      //       label: "أجر ساعة واحدة",
                      //       color: Colors.green,
                      //     ),

                      //     BuildSeparator(),

                      //     // العمود 3: الخبرة
                      //     BuildStateItem(
                      //       icon: Icons.work_history_outlined,
                      //       value: "${customer.experienceYears!} سنوات",
                      //       label: "سنوات الخبرة",
                      //       color: Colors.blue,
                      //     ),
                      //   ],
                      // ),
                      // ),

                      // const SizedBox(height: 20),

                      Row(
                        children: [
                          // Expanded(
                          //   child: Column(
                          //     children: [
                          //       // 4. المهارات (أول 3 مهارات)
                          //       Wrap(
                          //         spacing: 4, // مسافة أفقية بين الكبسولات
                          //         runSpacing: 4, // مسافة عمودية
                          //         children: (customer.skils! as List<String>)
                          //             .take(3) // نأخذ أول 3 فقط
                          //             .map((skill) {
                          //           return Container(
                          //             padding: const EdgeInsets.symmetric(
                          //                 horizontal: 6, vertical: 3),
                          //             decoration: BoxDecoration(
                          //                 color: Colors.grey[100],
                          //                 borderRadius:
                          //                     BorderRadius.circular(4),
                          //                 border: Border.all(
                          //                     color: Colors.grey.shade300)),
                          //             child: Text(
                          //               skill,
                          //               style: TextStyle(
                          //                   fontSize: 9,
                          //                   color: Colors.grey[800]),
                          //             ),
                          //           );
                          //         }).toList(),
                          //       ),
                          //       const SizedBox(height: 8), // مسافة صغيرة
                          //       // العنوان التوضيحي في السطر الثاني
                          //       Text(
                          //         "أبرز المهارات",
                          //         style: TextStyle(
                          //           fontSize: 10,
                          //           color: Colors.grey[500],
                          //           fontWeight: FontWeight.w500,
                          //         ),
                          //         textAlign: TextAlign.center,
                          //       ),
                          //     ],
                          //   ),
                          // ),
                          //     // العمود 1: الموقع
                          Expanded(
                            child: BuildStateItem(
                              icon: Icons.location_on_outlined,
                              value: customer.city!,
                              label: "مكان الإقامة",
                              color: Colors.grey,
                            ),
                          ),
                          BuildSeparator(),
                          Expanded(
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const SizedBox(width: 8),
                                    // زر لينكد إن
                                    BuildSocialButton(
                                      label: "LinkedIn",
                                      icon: SvgPicture.asset(
                                        "assets/icons/linkedin.svg",
                                        width: 16,
                                        height: 16,
                                      ),
                                      color: const Color(
                                          0xFF0A66C2), // لون لينكد إن
                                      onTap: () async {
                                        await controller
                                            .openUrl(customer.linkedIn!);
                                      },
                                    ),
                                    const SizedBox(width: 8),
                                    // زر غيت هاب
                                    BuildSocialButton(
                                      label: "GitHub",
                                      icon: SvgPicture.asset(
                                        "assets/icons/github.svg",
                                        width: 16,
                                        height: 16,
                                      ),

                                      color: const Color(
                                          0xFF181717), // لون غيت هاب
                                      onTap: () async {
                                        await controller
                                            .openUrl(customer.github!);
                                      },
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 8), // مسافة صغيرة
                                // العنوان التوضيحي في السطر الثاني
                                Text(
                                  "منصات أخرى",
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: Colors.grey[500],
                                    // color: Colors.black,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 25),

                // ================= القسم الجديد: نبذة عني =================
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 25,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            isMine ? "نبذة عني" : "نبذة عن ${customer.name!}",
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text(
                        customer.bio!,
                        style: const TextStyle(
                          fontSize: 13,
                          // color: Colors.black87, // لون أسود هادئ وواضح
                          color: Colors.black54, // لون أسود هادئ وواضح
                          height: 1.6, // تباعد أسطر مريح للقراءة
                          fontWeight: FontWeight.w400, // خط ناعم (ليس بولد)
                        ),
                        textAlign: TextAlign
                            .justify, // محاذاة النص ليكون مرتباً من الطرفين
                      ),
                      const SizedBox(height: 10),
                      // تفاصيل التعليم
                      Row(
                        children: [
                          Icon(Icons.school_outlined,
                              color: AppColor.primaryColor, size: 17),
                          const SizedBox(width: 5),
                          Text(
                            "${customer.educationInfo!['isGraduated'] ? "تخرج من" : "يدرس في"} ${customer.educationInfo!['college']}",
                            style: const TextStyle(
                              fontSize: 12,
                              color: Colors.black45,
                              height: 1.5,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 0),
                      // ايميل
                      Row(
                        children: [
                          Icon(Icons.mail_outline_sharp,
                              color: AppColor.primaryColor, size: 15),
                          const SizedBox(width: 5),
                          Text(
                            customer.email!,
                            style: const TextStyle(
                              fontSize: 12,
                              color: Colors.black45,
                              height: 1.5,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 0),
                      // موبايل
                      Row(
                        children: [
                          Icon(Icons.phone_android_sharp,
                              color: AppColor.primaryColor, size: 15),
                          const SizedBox(width: 5),
                          Text(
                            customer.phone!,
                            style: const TextStyle(
                              fontSize: 12,
                              color: Colors.black45,
                              height: 1.5,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                //*
                // const SizedBox(height: 25),

                // // // ================= 3. قسم الخبرة المهنية (الجزء الجديد) =================
                // Padding(
                //   padding: const EdgeInsets.symmetric(horizontal: 25),
                //   child: Column(
                //     crossAxisAlignment: CrossAxisAlignment.start,
                //     children: [
                //       const Text(
                //         "الخبرة المهنية",
                //         style: TextStyle(
                //           fontSize: 16,
                //           fontWeight: FontWeight.bold,
                //           color: Colors.black87,
                //         ),
                //       ),
                //       const SizedBox(height: 10),

                //       // عرض قائمة الخبرات
                //       ...customer.workExperiences!
                //           .map((exp) => BuildExperienceCard(
                //                 exp: exp,
                //               ))
                //           .toList(),
                //     ],
                //   ),
                // ),
                //-

                const SizedBox(height: 30), // مسافة في نهاية الصفحة
              ],
            ),
          ),
        );
      }),
    );
  }
}
