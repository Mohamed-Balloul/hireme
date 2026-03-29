import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hireme/controller/company/companyprofile_controller.dart';
// import 'package:hireme/controller/student/studentprofile_controller.dart';
import 'package:hireme/core/constant/color.dart';
// import 'package:hireme/data/datasource/static/static.dart';

class CoverPreviewPage extends StatelessWidget {
  final bool isCover;
  const CoverPreviewPage({super.key, required this.isCover});

  @override
  Widget build(BuildContext context) {
    CompanyProfileControllerImp controller = Get.find();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          isCover ? "معاينة غلاف الملف الشخصي" : "معاينة الصورة الشخصية",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: AppColor.primaryColor,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        foregroundColor: Colors.black,
      ),
      body: GetBuilder<CompanyProfileControllerImp>(builder: (controller) {
        return Column(
          children: [
            const SizedBox(height: 20),
            // جزء المعاينة (يشبه الهيدر تماماً)
            Stack(
              clipBehavior: Clip.none,
              children: [
                // الغلاف الجديد المختار
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
                      // color: Colors.red.withOpacity(0.3),
                    ),
                  ),
                ),

                // ج. الصورة الشخصية
                Positioned(
                  bottom: -55,
                  right: 124,
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
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 100),

            // أزرار التحكم
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  ElevatedButton(
                    onPressed: () {
                      isCover
                          ? controller.saveCoverImage()
                          : controller.savePersonalImage();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      minimumSize: const Size(double.infinity, 50),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                    ),
                    child: const Text("حفظ التغييرات",
                        style: TextStyle(color: AppColor.black, fontSize: 16)),
                  ),
                  const SizedBox(height: 15),
                  TextButton(
                    onPressed: () {
                      isCover
                          ? controller.pickCoverImage()
                          : controller.pickPersonalImage();
                    }, // إعادة اختيار الصورة
                    child: const Text("اختيار صورة أخرى",
                        style: TextStyle(color: Colors.grey, fontSize: 14)),
                  ),
                ],
              ),
            ),
          ],
        );
      }),
    );
  }
}
