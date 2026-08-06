import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hireme/controller/customer/customerhome_controller.dart';
import 'package:hireme/core/constant/color.dart';
// import 'package:hireme/data/datasource/static/static.dart';
import 'package:hireme/data/model/studentprofilemodel.dart';
import 'package:hireme/view/screen/student/studentprofile.dart';

abstract class CustomerSearchController extends GetxController {
  performSearch();
  changeType(String type);
  goToStudentProfile(String studentId);
  //--ربط
  getAllStudents();
}

class CustomerSearchControllerImp extends CustomerSearchController {
  //--ربط
  CustomerHomeControllerImp homeController =
      Get.find<CustomerHomeControllerImp>();
  List<StudentProfileModel> allStudents = [];
  //--ربط
  TextEditingController searchTextController = TextEditingController();
  String selectedType = "عمل";
  bool isLoading = false;
  bool isFilterVisible = false; // للتحكم بظهور الـ Chips

  List<dynamic> allFetchedResults = []; // لتخزين نتائج البحث النصي الأصلية

  List<dynamic> searchResults = []; // ما يعرض فعلياً بعد فلترة الـ Chips

  // القوائم الخاصة بالـ Chips
  List<String> selectedAdvancedFilters = ["الكل"];

  final List<String> jobFilters = [
    "الكل",
    "Developer",
    "Designer",
    "Flutter",
    "Laravel",
    "Front End",
    "Back End",
    "Technical"
  ];

  // دالة البحث النصي (توسيع النطاق)
  @override
  performSearch() async {
    String query = searchTextController.text.trim().toLowerCase();
    if (query.isEmpty) return;

    isLoading = true;
    update();

    await Future.delayed(const Duration(milliseconds: 600));

    allFetchedResults = allStudents
        .asMap()
        .entries
        .where((entry) =>
            entry.value.jobLabel!.toLowerCase().contains(query) ||
            entry.value.name!.toLowerCase().contains(query))
        .map((entry) => {
              'index': entry.key,
              'post': entry.value,
            })
        .toList();

    applyAdvancedFilters(); // تطبيق الفلاتر المتقدمة (الكل افتراضياً)
    isLoading = false;
    update();
  }

  // دالة فلترة النتائج بناءً على الـ Chips
  void applyAdvancedFilters() {
    if (selectedAdvancedFilters.contains("الكل") ||
        selectedAdvancedFilters.isEmpty) {
      searchResults = List.from(allFetchedResults);
    } else {
      searchResults = allFetchedResults.where((post) {
        String fullContent = "";

        fullContent =
            (post['post'].name! + post['post'].jobLabel!).toLowerCase();

        // التحقق إذا كان البوست يحتوي على أي من الكلمات المختارة في الـ Chips
        return selectedAdvancedFilters
            .any((filter) => fullContent.contains(filter.toLowerCase()));
      }).toList();
    }
    update();
  }

  void toggleFilterVisibility() {
    isFilterVisible = !isFilterVisible;
    //me
    if (!isFilterVisible) {
      // print(selectedAdvancedFilters);
      if (selectedAdvancedFilters.contains("الكل")) {
        print(
            "-----------------------------------(selectedAdvancedFilters == ]");
        // selectedAdvancedFilters = ["الكل"];
        // performSearch();
      } else {
        print(
            "-----------------------------------(selectedAdvancedFilters != ]");
        selectedAdvancedFilters = ["الكل"];
        performSearch();
      }
      // print(selectedAdvancedFilters);
    }
    //

    //me
    update();
  }

  void onChipSelected(bool selected, String filter) {
    if (filter == "الكل") {
      selectedAdvancedFilters = ["الكل"];
    } else {
      selectedAdvancedFilters.remove("الكل");
      if (selected) {
        selectedAdvancedFilters.add(filter);
      } else {
        selectedAdvancedFilters.remove(filter);
      }
      if (selectedAdvancedFilters.isEmpty) selectedAdvancedFilters.add("الكل");
    }
    applyAdvancedFilters();
  }

  @override
  changeType(type) {
    selectedType = type;
    selectedAdvancedFilters = ["الكل"]; // إعادة ضبط الفلاتر عند تغيير النوع
    if (searchTextController.text.isNotEmpty) {
      performSearch();
    }
    update();
  }

  // @override
  // goToStudentProfile(int index) {
  //   // Get.to(() => StudentProfile(
  //   //       student: studentProfileList[index], // الطالب المختار من السلايدر
  //   //       isMine: false, // الزائر شركة، لذا لا تظهر أزرار التعديل
  //   //       isCompany: false,
  //   //     ));

  // }
  // داخل كلاس CompanySearchControllerImp بملف البحث:

  @override
  void goToStudentProfile(String studentId) async {
    // 1. إظهار ديالوغ التحميل المتناسق فوراً لمحاكاة الاتصال الفعلي
    Get.dialog(
      const Center(
        child: Card(
          elevation: 4,
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(16)),
          ),
          child: Padding(
            padding: EdgeInsets.all(24.0),
            child: CircularProgressIndicator(
              color: AppColor.primaryColor, // المؤشر الأخضر الدائري المعتمد
            ),
          ),
        ),
      ),
      barrierDismissible: false,
    );

    // 2. تأخير اصطناعي ناعم ومدروس لثانيتين لإضفاء الواقعية على الحركة
    await Future.delayed(const Duration(seconds: 2));

    // 3. إغلاق الديالوغ المنبثق بأمان
    if (Get.isDialogOpen ?? false) {
      Get.back();
    }

    // 4. الانتقال السلس لبروفايل الطالب مع فحص المعرفات الآمن برمجياً لتفادي الـ StateError
    Get.to(() => StudentProfile(
          student: allStudents
              .firstWhere((student) => student.id.toString() == studentId),
          isMine: false,
          isCompany: true,
        ));
  }

  @override
  void onInit() {
    getAllStudents();
    super.onInit();
  }

  @override
  void getAllStudents() {
    allStudents.clear();

    if (homeController.allStudents.isNotEmpty) {
      allStudents.addAll(homeController.allStudents);
    }
  }

  @override
  void dispose() {
    super.dispose();
  }
}
