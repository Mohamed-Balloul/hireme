import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hireme/controller/company/companysearch_controller.dart';
import 'package:hireme/core/constant/color.dart';
import 'package:hireme/view/widget/company/studentcard.dart';

class CompanySearch extends StatelessWidget {
  const CompanySearch({super.key});
  @override
  Widget build(BuildContext context) {
    CompanySearchControllerImp controller =
        Get.put(CompanySearchControllerImp());

    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xFFF9F9F9),
        body: Directionality(
          textDirection: TextDirection.rtl,
          child: GetBuilder<CompanySearchControllerImp>(builder: (controller) {
            return SingleChildScrollView(
              // جعل الواجهة كاملة قابلة للسكرول
              child: Column(
                children: [
                  // 1. حقل البحث العلوي
                  _buildHeader(controller),

                  // // 2. الفلاتر (عمل / خدمة)
                  // _buildTypeFilters(controller),

                  // 3. سطر الإحصائيات (عدد النتائج + أيقونة الترتيب)
                  _buildStatsRow(controller),

                  // 4. منطقة النتائج (تعديل منطق العرض هنا)
                  if (controller.isLoading)
                    const Padding(
                      padding: EdgeInsets.only(top: 50),
                      child: Center(
                          child: CircularProgressIndicator(
                              color: AppColor.primaryColor)),
                    )
                  else if (controller.searchResults.isEmpty &&
                      controller.searchTextController.text.isNotEmpty)
                    const Padding(
                      padding: EdgeInsets.only(top: 50),
                      child: Center(child: Text("لا توجد نتائج تطابق بحثك")),
                    )
                  else
                    ListView.builder(
                      // هذه الإعدادات ضرورية ليعمل الـ ListView داخل SingleChildScrollView
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: controller.searchResults.length,
                      padding: const EdgeInsets.only(top: 10, bottom: 20),
                      itemBuilder: (context, index) {
                        final item = controller.searchResults[index]['post'];
                        final ind = controller.searchResults[index]['index'];

                        return StudentCard(studentProfileModel: item, ind: ind);
                      },
                    ),
                ],
              ),
            );
          }),
        ),
      ),
    );
  }

  // ويجت رأس الصفحة (حقل البحث)
  Widget _buildHeader(CompanySearchControllerImp controller) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Container(
        height: 50,
        decoration: BoxDecoration(
          color: Colors.grey[100],
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.grey.shade400),
          // borderRadius: BorderRadius.circular(10),
        ),
        child: TextField(
          controller: controller.searchTextController,
          onSubmitted: (_) => controller.performSearch(),
          decoration: InputDecoration(
            hintText: "ابحث عن طالب",
            hintStyle: TextStyle(color: Colors.grey[600], fontSize: 14),
            prefixIcon: Icon(Icons.search, color: Colors.grey[600]),
            border: InputBorder.none,
            contentPadding: const EdgeInsets.symmetric(vertical: 15),
          ),
        ),
      ),
    );
  }

  // ويجت أزرار الفلترة (عمل / خدمة)
  Widget _buildTypeFilters(CompanySearchControllerImp controller) {
    return GetBuilder<CompanySearchControllerImp>(builder: (controller) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          mainAxisAlignment:
              MainAxisAlignment.start, // حسب الصورة الفلاتر جهة اليسار في RTL
          children: [
            Text(
              "النوع:",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              width: 10,
            ),
            _filterChip("عمل", controller),
            const SizedBox(width: 10),
            _filterChip("خدمة", controller),
          ],
        ),
      );
    });
  }

  Widget _filterChip(String label, CompanySearchControllerImp controller) {
    bool isSelected = controller.selectedType == label;
    return InkWell(
      onTap: () => controller.changeType(label),
      borderRadius: BorderRadius.circular(10),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 17, vertical: 3),
        decoration: BoxDecoration(
          color: isSelected ? AppColor.primaryColor : Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
              color: isSelected ? AppColor.primaryColor : Colors.grey.shade400),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  // ويجت سطر النتائج والفلتر
  // تعديل سطر الإحصائيات لإضافة onTap
  Widget _buildStatsRow(CompanySearchControllerImp controller) {
    return GetBuilder<CompanySearchControllerImp>(builder: (controller) {
      if (controller.allFetchedResults.isEmpty || controller.isLoading)
        return const SizedBox();

      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "النتائج (${controller.searchResults.length})",
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 16),
                ),
                InkWell(
                  onTap: () => controller.toggleFilterVisibility(),
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: controller.isFilterVisible
                          // ? AppColor.primaryColor.withOpacity(0.1)
                          ? Colors.white
                          : Colors.transparent,
                      border: Border.all(
                          color: controller.isFilterVisible
                              ? AppColor.primaryColor
                              : Colors.grey.shade400),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(Icons.tune,
                        size: 20,
                        color: controller.isFilterVisible
                            ? AppColor.primaryColor
                            : Colors.black87),
                  ),
                ),
              ],
            ),
            // إظهار الـ Chips عند الضغط على أيقونة الفلترة
            if (controller.isFilterVisible)
              _buildAdvancedFilterChips(controller),
          ],
        ),
      );
    });
  }

  // ويجت بناء الـ Chips المتقدمة
  Widget _buildAdvancedFilterChips(CompanySearchControllerImp controller) {
    List<String> currentFilters = controller.jobFilters;
    return Container(
      height: 50,
      margin: const EdgeInsets.only(top: 10),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: currentFilters.length,
        itemBuilder: (context, index) {
          String filter = currentFilters[index];
          bool isSelected = controller.selectedAdvancedFilters.contains(filter);
          return Padding(
            padding: const EdgeInsets.only(left: 8),
            child: FilterChip(
              label: Text(filter),
              selected: isSelected,
              onSelected: (bool value) =>
                  controller.onChipSelected(value, filter),
              selectedColor: AppColor.primaryColor.withOpacity(0.1),
              checkmarkColor: AppColor.primaryColor,
              backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
                side: BorderSide(
                    color: isSelected
                        ? AppColor.primaryColor
                        : Colors.grey.shade300),
              ),
              labelStyle: TextStyle(
                color: isSelected ? AppColor.primaryColor : Colors.black87,
                fontSize: 12,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          );
        },
      ),
    );
  }
}
