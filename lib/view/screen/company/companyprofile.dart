import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:hireme/controller/company/companyprofile_controller.dart';
import 'package:hireme/core/constant/color.dart';
import 'package:hireme/data/datasource/static/static.dart';
import 'package:flutter/material.dart';
import 'package:hireme/data/model/companyprofilemodel.dart';
import 'package:hireme/view/widget/student/buildseparator.dart';
import 'package:hireme/view/widget/student/buildsocialbutton.dart';
import 'package:hireme/view/widget/student/buildstateitem.dart';
import 'package:hireme/view/widget/student/profile_dialogs.dart';

class CompanyProfile extends StatelessWidget {
  final CompanyProfileModel company;
  final bool isMine;

  const CompanyProfile({
    super.key,
    required this.company,
    this.isMine = true,
  });

  @override
  Widget build(BuildContext context) {
    Get.put(CompanyProfileControllerImp());

    return Scaffold(
      // backgroundColor: const Color(0xFFF8F9FA),
      backgroundColor: Colors.white,
      body: GetBuilder<CompanyProfileControllerImp>(builder: (controller) {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ================= 1. الهيدر (صورة الغلاف + الشخصية) =================
                SizedBox(
                  height: 225,
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
                          bottom: 70,
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
                                          ? "تعديل الغلاف"
                                          : "إضافة غلاف",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 9)),
                                ],
                              ),
                            ),
                          ),
                        ),

                        Positioned(
                          top: 10,
                          left: 10,
                          child: InkWell(
                            onTap: () {
                              controller
                                  .goToEditCompanyProfileInfo(); //حاليا الواجهة فارغة
                            },
                            child: Container(
                              padding: const EdgeInsets.all(6),
                              decoration: BoxDecoration(
                                // color: Colors.grey.withOpacity(0.8),
                                // color: Colors.black.withOpacity(0.4),
                                color: Colors.white.withOpacity(0.8),
                                borderRadius: BorderRadius.circular(50),
                              ),
                              child: Icon(
                                Icons.edit,
                                size: 14,
                                // color: Colors.white,
                                color: Colors.black87,
                              ),
                            ),
                          ),
                        ),
                      ],
                      // ج. الصورة الشخصية
                      Positioned(
                        bottom: 10,
                        // right: 124,
                        right: MediaQuery.of(context).size.width / 2 -
                            55, // لتوسيط الصورة تماماً
                        child: Stack(
                          children: [
                            Container(
                              height: 110,
                              width: 110,
                              padding: const EdgeInsets.all(3),
                              decoration: BoxDecoration(
                                color: Color.fromARGB(255, 21, 255, 0),
                                borderRadius: BorderRadius.circular(17),
                                // shape: BoxShape.circle,
                                //
                                //
                                gradient: LinearGradient(
                                  begin: Alignment.bottomCenter,
                                  end: Alignment.topCenter,
                                  colors: [
                                    Colors.black.withOpacity(0.5),
                                    // Colors.transparent,
                                    Colors.white
                                  ],
                                  stops: const [0.0, 0.5],
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
                              child: ClipRRect(
                                // هذا هو الحل السحري لقص الحواف
                                borderRadius: BorderRadius.circular(
                                    15), // أصغر قليلاً من الحواف الخارجية لتبدو متناسقة
                                child: Container(
                                  color: Colors.white,
                                  child: (controller.tempPersonalFile == null)
                                      ? const Icon(
                                          Icons.business,
                                          color: Colors.black54,
                                          size: 50,
                                        )
                                      : Image.file(
                                          controller.tempPersonalFile!,
                                          fit: BoxFit
                                              .cover, // تأكد من استخدام cover لملء المربع
                                        ),
                                ),
                              ),

                              // child: Container(
                              //   decoration: BoxDecoration(
                              //       color: Colors.white,
                              //       borderRadius: BorderRadius.circular(15)),
                              //   child: (controller.tempPersonalFile == null)
                              //       ? Icon(
                              //           Icons.business,
                              //           color: Colors.black54,
                              //           size: 50,
                              //         )
                              //       : Image.file(
                              //           controller.tempPersonalFile!,
                              //           fit: BoxFit.cover,
                              //         ),
                              // ),
                            ),
                            if (isMine) ...[
                              Positioned(
                                bottom: 0,
                                left: 0,
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

                const SizedBox(height: 0),

                // ================= 2. المعلومات الأساسية والملخص =================
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // الاسم
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        child: Center(
                          child: Text(
                            company.name!,
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w800,
                              color: Colors.black87,
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 2),

                      // المسمى الوظيفي
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        child: Center(
                          child: Text(
                            company.industry!,
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.grey[600],
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 30),

                      // ---------------------------------------------
                      // التعديل الجديد: قسم الإحصائيات (3 أعمدة متساوية)
                      // ---------------------------------------------

                      Row(
                        children: [
                          // العمود 1: الموقع
                          BuildStateItem(
                            icon: Icons.people,
                            value: company.companySize.toString(),
                            label: "عدد الموظفين",
                            color: Colors.grey,
                          ),

                          BuildSeparator(),

                          // العمود 2: الراتب
                          // BuildStateItem(
                          //   icon: Icons.monetization_on_outlined,
                          //   value: "\$${company.hourlySalary!}",
                          //   label: "أجر ساعة واحدة",
                          //   color: Colors.green,
                          // ),

                          // BuildSeparator(),

                          // العمود 3: الخبرة
                          BuildStateItem(
                            icon: Icons.work_history_outlined,
                            // icon: FontAwesomeIcons.apple,
                            value: "${company.foundedYear!}",
                            label: "سنة التأسيس",
                            color: Colors.blue,
                          ),
                        ],
                      ),
                      // ),

                      const SizedBox(height: 20),

                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              children: [
                                // 4. المهارات (أول 3 مهارات)
                                Wrap(
                                  spacing: 4, // مسافة أفقية بين الكبسولات
                                  runSpacing: 4, // مسافة عمودية
                                  children: (company.techStack! as List<String>)
                                      .take(3) // نأخذ أول 3 فقط
                                      .map((skill) {
                                    return Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 6, vertical: 3),
                                      decoration: BoxDecoration(
                                          color: Colors.grey[100],
                                          borderRadius:
                                              BorderRadius.circular(4),
                                          border: Border.all(
                                              color: Colors.grey.shade300)),
                                      child: Text(
                                        skill,
                                        style: TextStyle(
                                            fontSize: 9,
                                            color: Colors.grey[800]),
                                      ),
                                    );
                                  }).toList(),
                                ),
                                const SizedBox(height: 8), // مسافة صغيرة
                                // العنوان التوضيحي في السطر الثاني
                                Text(
                                  "التقنيات المستخدمة",
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: Colors.grey[500],
                                    fontWeight: FontWeight.w500,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ],
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
                                        await controller.openUrl(
                                            company.socialMediaLinks[0]);
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
                                        await controller.openUrl(
                                            company.socialMediaLinks[1]);
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
                            isMine ? "نبذة عني" : "نبذة عن ${company.name!}",
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
                        company.description!,
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

                      Row(
                        children: [
                          Icon(Icons.mail_outline_sharp,
                              color: AppColor.primaryColor, size: 15),
                          const SizedBox(width: 5),
                          Text(
                            company.email!,
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
                          Directionality(
                            textDirection: TextDirection.ltr,
                            child: Text(
                              company.phone!,
                              style: const TextStyle(
                                fontSize: 12,
                                color: Colors.black45,
                                height: 1.5,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 30), // مسافة في نهاية الصفحة
              ],
            ),
          ),
        );
      }),
    );
  }
}
