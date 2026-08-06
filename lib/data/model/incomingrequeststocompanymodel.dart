//------------
class IncomingRequestsToCompanyModel {
  final String? image;
  final String? applicantName;
  final int? applicantId; // معرف الطالب
  final int? applicationId; // معرف الطلب
  final int? expectedSalary;
  final String? joblabel;
  final String? time;
  final String? applicationStatus; // حالة الطلب (مقبول، مرفوض، قيد الانتظار)

  IncomingRequestsToCompanyModel({
    this.image,
    this.applicantName,
    this.applicantId,
    this.applicationId,
    this.expectedSalary,
    this.joblabel,
    this.time,
    this.applicationStatus,
  });

  factory IncomingRequestsToCompanyModel.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      return IncomingRequestsToCompanyModel._default();
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

    // 4. استخراج معرف الطالب بشكل محمي ودفاعي لتفادي الـ null كلياً
    int? parsedApplicantId;

    // محاولة أولى: جلب المعرف من "id" بداخل كائن الطالب "student"
    if (studentMap?['id'] != null) {
      parsedApplicantId = int.tryParse(studentMap!['id'].toString());
    }
    // محاولة ثانية (احتياطية): جلب المعرف من "student_profile_id" بداخل جذر الـ JSON
    if (parsedApplicantId == null && json['student_profile_id'] != null) {
      parsedApplicantId = int.tryParse(json['student_profile_id'].toString());
    }

    // 5. استخراج معرف الطلب (applicationId) من جذر الـ JSON
    final int? parsedApplicationId =
        json['id'] != null ? int.tryParse(json['id'].toString()) : null;

    // 6. استخراج حالة الـ application وترجمتها عربياً
    final String rawStatus = json['status']?.toString() ?? "pending";
    String mappedStatus = "قيد الانتظار";
    if (rawStatus == "accepted" || rawStatus == "approved") {
      mappedStatus = "تم القبول";
    } else if (rawStatus == "rejected") {
      mappedStatus = "تم الرفض";
    }

    // 7. استخراج وقت الـ application وحساب الفارق الزمني برمجياً وتنسيقه
    String formattedTime = "منذ قليل";
    if (json['created_at'] != null) {
      formattedTime =
          _parseDateTimeToFriendlyString(json['created_at'].toString());
    }
    //هنا استخراج معرف الطلب (applicationId) من جذر الـ JSON
    //هنا استخراج الحالة
    //هنا استخراج الوقت

    return IncomingRequestsToCompanyModel(
      image: fullAvatar,
      applicantName: studentMap?['username']?.toString() ??
          studentMap?['name']?.toString() ??
          'متقدم غير معروف',
      applicantId: parsedApplicantId,

      // إسناد المتغيرات الثلاثة الجديدة بنجاح
      applicationId: parsedApplicationId,
      applicationStatus: mappedStatus,
      time: formattedTime,

      expectedSalary: _parseInt(
          json['expected_salary'] ?? json['expectedSalary'],
          defaultValue: 500),
      joblabel: studentProfileMap?['title']?.toString() ?? 'طالب',
    );
  }

  factory IncomingRequestsToCompanyModel._default() {
    return IncomingRequestsToCompanyModel(
      image:
          'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?q=80&w=200&auto=format&fit=crop',
      applicantName: 'متقدم غير معروف',
      applicantId: null,
      applicationId: null,
      expectedSalary: 500,
      joblabel: 'طالب',
      time: "منذ قليل",
      applicationStatus: "قيد الانتظار",
    );
  }

  static int _parseInt(dynamic value, {int defaultValue = 500}) {
    if (value == null) return defaultValue;
    if (value is int) return value;
    if (value is double) return value.toInt();
    if (value is String) return int.tryParse(value) ?? defaultValue;
    return defaultValue;
  }

  // دالة مساعدة لحساب الفارق الزمني وعرض الوقت بشكل منسق ومقروء بالعربية تلقائياً
  static String _parseDateTimeToFriendlyString(String isoString) {
    try {
      DateTime parsedDate = DateTime.parse(isoString);
      Duration diff = DateTime.now().difference(parsedDate);
      if (diff.inDays > 0) {
        return "منذ ${diff.inDays} يوم";
      } else if (diff.inHours > 0) {
        return "منذ ${diff.inHours} ساعة";
      } else if (diff.inMinutes > 0) {
        return "منذ ${diff.inMinutes} دقيقة";
      } else {
        return "منذ قليل";
      }
    } catch (e) {
      return "منذ قليل";
    }
  }
}
