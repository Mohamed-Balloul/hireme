import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hireme/controller/customer/sendobjectiontoadmin_controller.dart';
import 'package:hireme/core/class/handlingdataview.dart';
import 'package:hireme/core/constant/color.dart';
import 'package:hireme/view/widget/customer/objection_project_card.dart';

class SendObjectionToAdmin extends StatelessWidget {
  const SendObjectionToAdmin({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(SendObjectionToAdminControllerImp());

    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9),
      appBar: AppBar(
        title: const Text(
          "الاعتراض على خدمة",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black87,
        elevation: 0.5,
      ),
      body: GetBuilder<SendObjectionToAdminControllerImp>(
        builder: (controller) => Directionality(
          textDirection: TextDirection.rtl,
          child: HandlingDataRequest(
            statusRequest: controller.statusRequest,
            widget: controller.receivedProjects.isEmpty
                ? _buildEmptyState() // الحالة الأولى: لا توجد مشاريع مستلمة
                : _buildObjectionForm(
                    controller), // الحالة الثانية: عرض فورم الاعتراض
          ),
        ),
      ),
    );
  }

  // الواجهة الخاصة بالحالة الأولى (القائمة فارغة)
  Widget _buildEmptyState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.info_outline_rounded,
              size: 65,
              color: Colors.grey.shade400,
            ),
            const SizedBox(height: 16),
            const Text(
              "لم تقم باستلام أية خدمة بعد",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black54,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              "يمكنك تقديم اعتراض فقط على الخدمات والملفات التي تم تسليمها إليك بشكل رسمي من قبل الأدمن.",
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey.shade400,
                height: 1.5,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  // الواجهة الخاصة بالحالة الثانية (فورم الاعتراض الكامل)
  Widget _buildObjectionForm(SendObjectionToAdminControllerImp controller) {
    return Form(
      key: controller.formState,
      child: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          // 1. قسم تحديد الخدمة
          _buildSectionHeader("يرجى تحديد الخدمة :"),
          const SizedBox(height: 12),
          ...controller.receivedProjects.map((project) {
            return ObjectionProjectCard(
              project: project,
              isSelected: controller.selectedProjectId == project.id,
              onTap: () => controller.selectProject(project.id!),
            );
          }).toList(),

          const SizedBox(height: 25),

          // 3. قسم الوصف المختصر
          _buildSectionHeader("أضف إضافة وصف مختصر للاعتراض :"),
          const SizedBox(height: 12),
          TextFormField(
            controller: controller.explanationController,
            maxLines: 4,
            minLines: 3,
            decoration: InputDecoration(
              hintText:
                  "أضف وصفاً مختصراً للاعتراض يوضح المشكلة الفنية بالتفصيل...",
              hintStyle: TextStyle(fontSize: 12, color: Colors.grey.shade400),
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: Colors.grey.shade200),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: Colors.grey.shade200),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: AppColor.primaryColor),
              ),
            ),
          ),

          const SizedBox(height: 35),

          // 4. زر الإرسال
          SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton(
              onPressed: () => controller.submitObjection(),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColor.primaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 1,
              ),
              child: const Text(
                "إرسال الاعتراض",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
            ),
          ),
          const SizedBox(height: 30),
        ],
      ),
    );
  }

  // دالة مساعدة لبناء ترويسة الأقسام بالشكل المطلوب وبخط مائل/منسق
  Widget _buildSectionHeader(String title) {
    return Row(
      children: [
        const Text(
          "* ",
          style: TextStyle(
              color: Colors.red, fontWeight: FontWeight.bold, fontSize: 16),
        ),
        Text(
          title,
          style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
      ],
    );
  }
}
