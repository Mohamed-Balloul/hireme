// class CreateAdRequestModel {
//   final String jobName;
//   final String additionalDetails;
//   final List<String> requirements;
//   final List<String> duties;
//   final List<String> features;
//   final bool githubRequired;
//   final bool resumeRequired;
//   final bool prevWorkRequired;
//   final bool expectedSalaryRequired;

//   CreateAdRequestModel({
//     required this.jobName,
//     required this.additionalDetails,
//     required this.requirements,
//     required this.duties,
//     required this.features,
//     required this.githubRequired,
//     required this.resumeRequired,
//     required this.prevWorkRequired,
//     required this.expectedSalaryRequired,
//   });

//   // هذه الدالة تقوم بتحويل الكائن إلى Map لإرساله كـ JSON للباك-إند
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = {
//       "job_name": jobName,
//       "additional_details": additionalDetails,
//       "github_required": githubRequired,
//       "resume_required": resumeRequired,
//       "prev_work_required": prevWorkRequired,
//       //

//       //
//       "expected_salary_required": expectedSalaryRequired,
//     };

//     // 1. تحويل مصفوفة المتطلبات إلى حقول req1, req2... ديناميكياً
//     for (int i = 0; i < requirements.length; i++) {
//       data["req${i + 1}"] = requirements[i];
//     }

//     // 2. تحويل مصفوفة المهام إلى حقول task1, task2... ديناميكياً
//     for (int i = 0; i < duties.length; i++) {
//       data["task${i + 1}"] = duties[i];
//     }

//     // 3. تحويل مصفوفة الميزات إلى حقول feature1, feature2... ديناميكياً
//     for (int i = 0; i < features.length; i++) {
//       data["feature${i + 1}"] = features[i];
//     }

//     return data;
//   }
// }
//----
// استبدل كود كلاس CreateAdRequestModel بالكامل في ملف الموديل بهذا الكود:

class CreateAdRequestModel {
  final String jobName;
  final String description; // الحقل الجديد المضاف رسمياً لمطابقة تحديث الباك
  final String additionalDetails;
  final List<String> requirements;
  final List<String> duties;
  final List<String> features;
  final bool githubRequired;
  final bool resumeRequired;
  final bool prevWorkRequired;
  final bool expectedSalaryRequired;

  CreateAdRequestModel({
    required this.jobName,
    required this.description, // تمرير الوصف هنا
    required this.additionalDetails,
    required this.requirements,
    required this.duties,
    required this.features,
    required this.githubRequired,
    required this.resumeRequired,
    required this.prevWorkRequired,
    required this.expectedSalaryRequired,
  });

  // هذه الدالة تقوم بتحويل الكائن إلى Map لإرساله كـ JSON للباك-إند
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {
      "job_name": jobName,
      "description": description, // إرسال الوصف بشكل منفصل ومطابق للبوستمان
      "additional_details": additionalDetails,
      "github_required": githubRequired,
      "resume_required": resumeRequired,
      "prev_work_required": prevWorkRequired,
      "expected_salary_required": expectedSalaryRequired,
    };

    // 1. تحويل مصفوفة المتطلبات إلى حقول req1, req2... ديناميكياً
    for (int i = 0; i < requirements.length; i++) {
      data["req${i + 1}"] = requirements[i];
    }

    // 2. تحويل مصفوفة المهام إلى حقول task1, task2... ديناميكياً
    for (int i = 0; i < duties.length; i++) {
      data["task${i + 1}"] = duties[i];
    }

    // 3. تحويل مصفوفة الميزات إلى حقول feature1, feature2... ديناميكياً
    for (int i = 0; i < features.length; i++) {
      data["feature${i + 1}"] = features[i];
    }

    return data;
  }
}
