import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hireme/controller/student/studentprofile_controller.dart';
import 'package:hireme/core/constant/color.dart';
import 'package:hireme/data/datasource/static/static.dart';

class CoverPreviewPage extends StatelessWidget {
  final bool isCover;
  const CoverPreviewPage({super.key, required this.isCover});

  @override
  Widget build(BuildContext context) {
    StudentProfileControllerImp controller = Get.find();
    final student = studentProfileList[0];

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
      body: GetBuilder<StudentProfileControllerImp>(builder: (controller) {
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
                // Container(
                //   height: 180,
                //   width: double.infinity,
                //   decoration: BoxDecoration(
                //     image: DecorationImage(
                //       image: FileImage(
                //           controller.tempCoverFile!), // عرض من الملف المحلي
                //       fit: BoxFit.cover,
                //     ),
                //   ),
                // ),
                // الصورة الشخصية (للمعاينة فقط)
                Positioned(
                  bottom: -40,
                  right: 20,
                  child: Container(
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
                      backgroundImage: (controller.tempPersonalFile != null)
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
