import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hireme/data/datasource/static/static.dart';
import 'package:hireme/data/model/companiespostmodel.dart';
import 'package:hireme/data/model/freelancerpostmodel.dart';

abstract class StudentSearchController extends GetxController {
  performSearch();
  changeType(String type);
}

//-----------------------
class StudentSearchControllerImp extends StudentSearchController {
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
  final List<String> serviceFilters = [
    "الكل",
    "تطبيق",
    "موقع إلكتروني",
    "لوحة تحكم",
    "تصميم",
    "برمجة"
  ];

  // دالة البحث النصي (توسيع النطاق)
  @override
  performSearch() async {
    String query = searchTextController.text.trim().toLowerCase();
    if (query.isEmpty) return;

    isLoading = true;
    update();

    await Future.delayed(const Duration(milliseconds: 600));

    if (selectedType == "عمل") {
      allFetchedResults = allcompaniesPosts.where((post) {
        return post.jobTitle!.toLowerCase().contains(query) ||
            post.companyName!.toLowerCase().contains(query) ||
            post.content!.toLowerCase().contains(query); // توسيع النطاق للمحتوى
      }).toList();
    } else {
      allFetchedResults = freelancerPostsList.where((post) {
        return post.serviceTitle!.toLowerCase().contains(query) ||
            post.publisher!.toLowerCase().contains(query) ||
            post.description!
                .toLowerCase()
                .contains(query); // توسيع النطاق للوصف
      }).toList();
    }

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
        if (post is CompaniesPostModel) {
          fullContent = (post.companyName! + post.jobTitle! + post.content!)
              .toLowerCase();
        } else if (post is FreelancerPostModel) {
          fullContent =
              (post.publisher! + post.serviceTitle! + post.description!)
                  .toLowerCase();
        }

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
}
