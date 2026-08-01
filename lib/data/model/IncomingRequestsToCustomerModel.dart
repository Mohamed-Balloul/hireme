// class IncomingRequestsToCustomerModel {
//   final String? image;
//   final String? applicantName;
//   final int? expectedSalary;
//   final String? joblabel;

//   IncomingRequestsToCustomerModel({
//     this.image,
//     this.applicantName,
//     this.expectedSalary,
//     this.joblabel,
//   });
//   factory IncomingRequestsToCustomerModel.fromJson(Map<String, dynamic>? json) {
//     if (json == null) {
//       return IncomingRequestsToCustomerModel._default();
//     }

//     return IncomingRequestsToCustomerModel(
//       // حماية الصورة
//       image: json['image']?.toString() ??
//           "https://images.unsplash.com/photo-1500648767791-00dcc994a43e?q=80&w=200&auto=format&fit=crop",

//       // حماية الاسم
//       applicantName:
//           (json['applicantName'] ?? json['applicant_name'])?.toString() ??
//               'متقدم غير معروف',

//       // حماية الراتب: القيمة الافتراضية 500 في حال كان null أو غير موجود
//       expectedSalary: _parseInt(
//           json['expectedSalary'] ?? json['expected_salary'],
//           defaultValue: 500),

//       // حماية المسمى الوظيفي
//       joblabel:
//           (json['joblabel'] ?? json['job_label'])?.toString() ?? 'غير محدد',
//     );
//   }

//   // قيم افتراضية في حال كانت استجابة الـ JSON كاملة null
//   factory IncomingRequestsToCustomerModel._default() {
//     return IncomingRequestsToCustomerModel(
//       image: '',
//       applicantName: 'متقدم غير معروف',
//       expectedSalary: 500,
//       joblabel: 'غير محدد',
//     );
//   }

//   // دالة تحويل الأرقام بأمان مع تحديد قيمة افتراضية قابلة للتخصيص
//   static int _parseInt(dynamic value, {int defaultValue = 500}) {
//     if (value == null) return defaultValue;
//     if (value is int) return value;
//     if (value is double) return value.toInt();
//     if (value is String) return int.tryParse(value) ?? defaultValue;
//     return defaultValue;
//   }
// }

class IncomingRequestsToCustomerModel {
  final String image;
  final String applicantName;
  final int expectedSalary;
  final String joblabel;

  IncomingRequestsToCustomerModel({
    required this.image,
    required this.applicantName,
    required this.expectedSalary,
    required this.joblabel,
  });

  factory IncomingRequestsToCustomerModel.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      return IncomingRequestsToCustomerModel._default();
    }

    // 1. استخراج كائن الطالب 'student' المتداخل بأمان
    final studentMap = json['student'] as Map<String, dynamic>?;

    // 2. استخراج كائن الملف الشخصي 'profile' المتداخل بأمان داخل الطالب
    final studentProfileMap = studentMap?['profile'] as Map<String, dynamic>?;

    // 3. معالجة وتأمين الصورة الشخصية من داخل كائن الطالب
    final String? rawAvatar = studentMap?['avatar'] ?? studentMap?['image'];
    String fullAvatar =
        "https://images.unsplash.com/photo-1500648767791-00dcc994a43e?q=80&w=200&auto=format&fit=crop"; // افتراضية

    if (rawAvatar != null && rawAvatar.isNotEmpty) {
      fullAvatar = rawAvatar.startsWith('http')
          ? rawAvatar
          : "https://cage-sleep-dallying.ngrok-free.dev/storage/$rawAvatar"; // دمج رابط السيرفر للمسارات النسبية
    }

    return IncomingRequestsToCustomerModel(
      // تمرير الصورة الكاملة المجهزة
      image: fullAvatar,

      // جلب الاسم من داخل كائن الطالب المتداخل (username أو name)
      applicantName: studentMap?['username']?.toString() ??
          studentMap?['name']?.toString() ??
          'متقدم غير معروف',

      // جلب الراتب المتوقع من الجذر الأساسي للطلب (Expected Salary)
      expectedSalary: _parseInt(
          json['expected_salary'] ?? json['expectedSalary'],
          defaultValue: 500),

      // جلب المسمى الوظيفي من داخل كائن الملف الشخصي للطالب (title) بأسلوب دفاعي لتفادي الـ null
      joblabel: studentProfileMap?['title']?.toString() ?? 'طالب',
    );
  }

  factory IncomingRequestsToCustomerModel._default() {
    return IncomingRequestsToCustomerModel(
      image:
          'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?q=80&w=200&auto=format&fit=crop',
      applicantName: 'متقدم غير معروف',
      expectedSalary: 500,
      joblabel: 'طالب',
    );
  }

  static int _parseInt(dynamic value, {int defaultValue = 500}) {
    if (value == null) return defaultValue;
    if (value is int) return value;
    if (value is double) return value.toInt();
    if (value is String) return int.tryParse(value) ?? defaultValue;
    return defaultValue;
  }
}
