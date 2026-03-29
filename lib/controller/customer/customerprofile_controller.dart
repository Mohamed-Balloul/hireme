import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hireme/view/screen/customer/coverpreviewpage.dart';
import 'package:hireme/view/screen/customer/editcustomerprofileinfo.dart';
import 'package:image_picker/image_picker.dart';
import 'package:url_launcher/url_launcher.dart';

abstract class CustomerProfileController extends GetxController {
  // uploadProfilePic(XFile image);
  // select(String gender);
  // uploadProfilePic(XFile image);
  select(String gender);
  saveCoverImage();
  pickCoverImage();
  deleteCoverImage();
  savePersonalImage();
  pickPersonalImage();
  deletePersonalImage();
  goToEditCustomerProfileInfo();
  Future<void> openUrl(String url);
}

class CustomerProfileControllerImp extends CustomerProfileController {
  // XFile? profilePic;

  // @override
  // void onInit() {
  //   super.onInit();
  // }

  // @override
  // void dispose() {
  //   super.dispose();
  // }

  // @override
  // select(String gender) {
  //   update();
  // }

  // @override
  // uploadProfilePic(image) {
  //   profilePic = image;
  //   update();
  // }
  //*
  // XFile? profilePic;

  // أضف هذه المتغيرات والدوال
  File? tempCoverFile;
  File? tempPersonalFile;
  final ImagePicker _picker = ImagePicker();

  @override
  Future<void> pickCoverImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      tempCoverFile = File(image.path);
      // الانتقال لواجهة المعاينة
      Get.to(() => const CoverPreviewPage(isCover: true));
      update(); // تحديث إذا كنت تستخدم GetBuilder
    }
  }

  @override
  void deleteCoverImage() {
    tempCoverFile = null;
    update();
  }

  @override
  void saveCoverImage() {
    // هنا لاحقاً سنرفع الصورة للسيرفر
    // حالياً سنقوم بتحديث القيمة محلياً للغرض التجريبي
    // student.cover = tempCoverFile!.path;
    // Get.back(); // العودة من صفحة المعاينة
    // Get.snackbar("نجاح", "تم تحديث صورة الغلاف بنجاح");
    //
// 1. هنا نرفع الصورة للسيرفر
    // 2. بعد النجاح نحدث البيانات محلياً
    // student.cover = tempCoverFile!.path;

    Get.back(); // العودة للبروفايل
    Get.snackbar("نجاح", "تم تحديث صورة الغلاف بنجاح");
    update(); // لتحديث الواجهة فوراً بالصورة الجديدة
  }

  @override
  Future<void> pickPersonalImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      tempPersonalFile = File(image.path);
      // الانتقال لواجهة المعاينة
      Get.to(() => const CoverPreviewPage(isCover: false));
      update(); // تحديث إذا كنت تستخدم GetBuilder
    }
  }

  @override
  void deletePersonalImage() {
    tempPersonalFile = null;
    update();
  }

  @override
  void savePersonalImage() {
    // هنا لاحقاً سنرفع الصورة للسيرفر
    // حالياً سنقوم بتحديث القيمة محلياً للغرض التجريبي
    // student.cover = tempCoverFile!.path;
    // Get.back(); // العودة من صفحة المعاينة
    // Get.snackbar("نجاح", "تم تحديث صورة الغلاف بنجاح");
    //
// 1. هنا نرفع الصورة للسيرفر
    // 2. بعد النجاح نحدث البيانات محلياً
    // student.cover = tempCoverFile!.path;

    Get.back(); // العودة للبروفايل
    Get.snackbar("نجاح", "تم تحديث الصورة الشخصية بنجاح");
    update(); // لتحديث الواجهة فوراً بالصورة الجديدة
  }

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  select(String gender) {
    update();
  }

  @override
  goToEditCustomerProfileInfo() {
    Get.to(() => const EditCustomerProfileInfo());
  }

  @override
  Future<void> openUrl(url) async {
    if (url.isEmpty) {
      Get.snackbar(
        "تنبيه",
        "لم يتم إدخال رابط",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Color.fromARGB(255, 199, 199, 199),
        colorText: const Color.fromARGB(255, 0, 0, 0),
        icon: const Icon(
          Icons.error_outline,
          // color: Colors.white,
          color: Color.fromARGB(255, 255, 0, 0),
        ),
        margin: const EdgeInsets.all(10),
        borderRadius: 12,
        duration: const Duration(seconds: 2),
      );

      return;
    }
    final Uri uri = Uri.parse(url);

    if (!await launchUrl(
      uri,
      mode: LaunchMode.externalApplication,
    )) {
      // throw Exception('Could not launch $url');
      // debugPrint("Cannot open $url");
      Get.snackbar(
        "فشل فتح الرابط",
        "تأكد من صحة الرابط",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: const Color(0xFF0A8F5A),
        colorText: Colors.white,
        icon: const Icon(
          Icons.error_outline,
          color: Colors.white,
        ),
        margin: const EdgeInsets.all(10),
        borderRadius: 12,
        duration: const Duration(seconds: 2),
      );
    }
  }

  // @override
  // uploadProfilePic(image) {
  //   profilePic = image;
  //   update();
  // }
}
