// class MyRequestToCompanyModel {
//   final int? id;
//   final int? publisherId; // معرف الشركة الناشرة للطلب
//   final String? publisher;
//   final String? logo;
//   final String? jobTitle;
//   final int? orderState;

//   MyRequestToCompanyModel({
//     this.id,
//     this.publisherId,
//     this.publisher,
//     this.logo,
//     this.jobTitle,
//     this.orderState,
//   });

//   // منشئ json المحدث والمتوافق مع البيانات المتداخلة للباك-إند
//   factory MyRequestToCompanyModel.fromJson(Map<String, dynamic> rawJson) {
//     // خطوة أمان: التحقق من تمرير الكائن الأساسي أو كائن 'data' الداخلي
//     final Map<String, dynamic> json =
//         (rawJson['data'] is Map<String, dynamic>) ? rawJson['data'] : rawJson;

//     // استخراج كائن الإعلان 'ad' المتداخل
//     final ad = json['ad'] as Map<String, dynamic>?;

//     // استخراج كائن الشركة 'company' المتداخل داخل كائن الإعلان
//     final company = ad?['company'] as Map<String, dynamic>?;

//     // 1. معالجة وتأمين لوجو الشركة ودمج رابط السيرفر للمسارات النسبية
//     final String? rawLogo =
//         company?['image'] ?? company?['logo'] ?? company?['avatar'];
//     String fullLogo =
//         "https://cdn-icons-png.flaticon.com/512/732/732221.png"; // لوجو افتراضي للشركة

//     if (rawLogo != null && rawLogo.isNotEmpty) {
//       fullLogo = rawLogo.startsWith('http')
//           ? rawLogo
//           : "https://cage-sleep-dallying.ngrok-free.dev/storage/$rawLogo";
//     }

//     // 2. معالجة حالة الطلب بشكل دفاعي (إذا لم يرسلها الباك حالياً نفترضها قيد الانتظار)
//     final dynamic rawState =
//         json['order_state'] ?? json['orderState'] ?? json['status'] ?? 0;
//     int parsedOrderState = 0; // افتراضياً قيد الانتظار
//     if (rawState != null) {
//       parsedOrderState = int.tryParse(rawState.toString()) ?? 0;
//     }

//     // 3. استخراج معرف الشركة الناشرة للطلب (publisherId) بشكل محمي وصارم لتفادي الـ null كلياً
//     int? parsedPublisherId;

//     // محاولة أولى: جلب المعرف من "company_id" بداخل الإعلان "ad"
//     if (ad?['company_id'] != null) {
//       parsedPublisherId = int.tryParse(ad!['company_id'].toString());
//     }
//     // محاولة ثانية (احتياطية): جلب المعرف من "id" بداخل كائن الشركة "company"
//     if (parsedPublisherId == null && company?['id'] != null) {
//       parsedPublisherId = int.tryParse(company!['id'].toString());
//     }

//     return MyRequestToCompanyModel(
//       // المعرّف الخاص بالتقديم على الإعلان (مهم لعملية الحذف)
//       id: json['id'] != null ? int.tryParse(json['id'].toString()) : null,

//       // استخراج اسم الشركة الناشرة للطلب
//       publisher: company?['name'] ?? "شركة غير محددة",

//       // إسناد معرّف الشركة المستخرج بأمان تام
//       publisherId: parsedPublisherId,

//       // اللوجو الكامل للشركة المجهزة
//       logo: fullLogo,

//       // استخراج المسمى الوظيفي للوظيفة المقدم عليها
//       jobTitle: ad?['job_name'] ?? ad?['jobTitle'] ?? "عنوان غير متوفر",

//       // إسناد حالة الطلب المعالجة
//       orderState: parsedOrderState,
//     );
//   }
// }
// //-----------
// class MyRequestToCompanyModel {
//   final int? id;
//   final int? publisherId; // معرف الشركة الناشرة للطلب
//   final String? publisher;
//   final String? logo;
//   final String? jobTitle;
//   final int? orderState;

//   MyRequestToCompanyModel({
//     this.id,
//     this.publisherId,
//     this.publisher,
//     this.logo,
//     this.jobTitle,
//     this.orderState,
//   });

//   // منشئ json المحدث والمتوافق مع البيانات المتداخلة للباك-إند
//   factory MyRequestToCompanyModel.fromJson(Map<String, dynamic> rawJson) {
//     // خطوة أمان: التحقق من تمرير الكائن الأساسي أو كائن 'data' الداخلي
//     final Map<String, dynamic> json =
//         (rawJson['data'] is Map<String, dynamic>) ? rawJson['data'] : rawJson;

//     // استخراج كائن الإعلان 'ad' المتداخل
//     final ad = json['ad'] as Map<String, dynamic>?;

//     // استخراج كائن الشركة 'company' المتداخل داخل كائن الإعلان
//     final company = ad?['company'] as Map<String, dynamic>?;

//     // 1. معالجة وتأمين لوجو الشركة ودمج رابط السيرفر للمسارات النسبية
//     final String? rawLogo =
//         company?['image'] ?? company?['logo'] ?? company?['avatar'];
//     String fullLogo =
//         "https://cdn-icons-png.flaticon.com/512/732/732221.png"; // لوجو افتراضي للشركة

//     if (rawLogo != null && rawLogo.isNotEmpty) {
//       fullLogo = rawLogo.startsWith('http')
//           ? rawLogo
//           : "https://cage-sleep-dallying.ngrok-free.dev/storage/$rawLogo";
//     }

//     // 2. معالجة وتحويل حالة الطلب النصية (status) إلى المعرف الرقمي المتوقع في الواجهة
//     final String rawState = (json['status'] ??
//             json['order_state'] ??
//             json['orderState'] ??
//             "pending")
//         .toString()
//         .toLowerCase();

//     int parsedOrderState = 0; // افتراضي قيد الانتظار
//     if (rawState == "accepted" || rawState == "approved" || rawState == "1") {
//       parsedOrderState = 1; // تمت الموافقة
//     } else if (rawState == "rejected" || rawState == "2") {
//       parsedOrderState = 2; // تم الرفض
//     } else {
//       parsedOrderState = 0; // قيد الانتظار
//     }

//     // 3. استخراج معرف الشركة الناشرة للطلب (publisherId) بشكل محمي وصارم لتفادي الـ null كلياً
//     int? parsedPublisherId;

//     // محاولة أولى: جلب المعرف من "company_id" بداخل الإعلان "ad"
//     if (ad?['company_id'] != null) {
//       parsedPublisherId = int.tryParse(ad!['company_id'].toString());
//     }
//     // محاولة ثانية (احتياطية): جلب المعرف من "id" بداخل كائن الشركة "company"
//     if (parsedPublisherId == null && company?['id'] != null) {
//       parsedPublisherId = int.tryParse(company!['id'].toString());
//     }

//     return MyRequestToCompanyModel(
//       // المعرّف الخاص بالتقديم على الإعلان (مهم لعملية الحذف)
//       id: json['id'] != null ? int.tryParse(json['id'].toString()) : null,

//       // استخراج اسم الشركة الناشرة للطلب
//       publisher: company?['name'] ?? "شركة غير محددة",

//       // إسناد معرّف الشركة المستخرج بأمان تام
//       publisherId: parsedPublisherId,

//       // اللوجو الكامل للشركة المجهزة
//       logo: fullLogo,

//       // استخراج المسمى الوظيفي للوظيفة المقدم عليها
//       jobTitle: ad?['job_name'] ?? ad?['jobTitle'] ?? "عنوان غير متوفر",

//       // إسناد حالة الطلب المعالجة الرقمية المطابقة تماماً لـ MyOrders
//       orderState: parsedOrderState,
//     );
//   }
// }
class MyRequestToCompanyModel {
  final int? id;
  final int? publisherId; // معرف الشركة الناشرة للطلب
  final String? publisher;
  final String? logo;
  final String? jobTitle;
  final int? orderState;
  final String? time; // تم إضافة حقل الوقت المحدث هنا للربط

  MyRequestToCompanyModel({
    this.id,
    this.publisherId,
    this.publisher,
    this.logo,
    this.jobTitle,
    this.orderState,
    this.time, // الباني المحدث
  });

  // منشئ json المحدث والمتوافق مع البيانات المتداخلة للباك-إند
  factory MyRequestToCompanyModel.fromJson(Map<String, dynamic> rawJson) {
    // خطوة أمان: التحقق من تمرير الكائن الأساسي أو كائن 'data' الداخلي
    final Map<String, dynamic> json =
        (rawJson['data'] is Map<String, dynamic>) ? rawJson['data'] : rawJson;

    // استخراج كائن الإعلان 'ad' المتداخل
    final ad = json['ad'] as Map<String, dynamic>?;

    // استخراج كائن الشركة 'company' المتداخل داخل كائن الإعلان
    final company = ad?['company'] as Map<String, dynamic>?;

    // 1. معالجة وتأمين لوجو الشركة ودمج رابط السيرفر للمسارات النسبية
    final String? rawLogo =
        company?['image'] ?? company?['logo'] ?? company?['avatar'];
    String fullLogo =
        "https://cdn-icons-png.flaticon.com/512/732/732221.png"; // لوجو افتراضي للشركة

    if (rawLogo != null && rawLogo.isNotEmpty) {
      fullLogo = rawLogo.startsWith('http')
          ? rawLogo
          : "https://cage-sleep-dallying.ngrok-free.dev/storage/$rawLogo";
    }

    // 2. معالجة وتحويل حالة الطلب النصية (status) إلى المعرف الرقمي المتوقع في الواجهة
    final String rawState = (json['status'] ??
            json['order_state'] ??
            json['orderState'] ??
            "pending")
        .toString()
        .toLowerCase();

    int parsedOrderState = 0; // افتراضي قيد الانتظار
    if (rawState == "accepted" || rawState == "approved" || rawState == "1") {
      parsedOrderState = 1; // تمت الموافقة
    } else if (rawState == "rejected" || rawState == "2") {
      parsedOrderState = 2; // تم الرفض
    } else {
      parsedOrderState = 0; // قيد الانتظار
    }

    // 3. استخراج معرف الشركة الناشرة للطلب (publisherId) بشكل محمي وصارم لتفادي الـ null كلياً
    int? parsedPublisherId;

    // محاولة أولى: جلب المعرف من "company_id" بداخل الإعلان "ad"
    if (ad?['company_id'] != null) {
      parsedPublisherId = int.tryParse(ad!['company_id'].toString());
    }
    // محاولة ثانية (احتياطية): جلب المعرف من "id" بداخل كائن الشركة "company"
    if (parsedPublisherId == null && company?['id'] != null) {
      parsedPublisherId = int.tryParse(company!['id'].toString());
    }

    // 4. استخراج وقت إنشاء الطلب وحساب الفارق الزمني برمجياً وتنسيقه بالعربية
    String formattedTime = "تم الإرسال منذ يوم"; // قيمة افتراضية للاحتياط
    if (json['created_at'] != null) {
      formattedTime =
          _parseDateTimeToFriendlyString(json['created_at'].toString());
    }

    return MyRequestToCompanyModel(
      // المعرّف الخاص بالتقديم على الإعلان (مهم لعملية الحذف)
      id: json['id'] != null ? int.tryParse(json['id'].toString()) : null,

      // استخراج اسم الشركة الناشرة للطلب
      publisher: company?['name'] ?? "شركة غير محددة",

      // إسناد معرّف الشركة المستخرج بأمان تام
      publisherId: parsedPublisherId,

      // اللوجو الكامل للشركة المجهزة
      logo: fullLogo,

      // استخراج المسمى الوظيفي للوظيفة المقدم عليها
      jobTitle: ad?['job_name'] ?? ad?['jobTitle'] ?? "عنوان غير متوفر",

      // إسناد حالة الطلب المعالجة الرقمية المطابقة تماماً لـ MyOrders
      orderState: parsedOrderState,

      // إسناد الوقت المنسق الجديد
      time: formattedTime,
    );
  }

  // دالة مساعدة لحساب الفارق الزمني وعرض الوقت بشكل منسق ومقروء بالعربية تلقائياً
  static String _parseDateTimeToFriendlyString(String isoString) {
    try {
      DateTime parsedDate = DateTime.parse(isoString);
      Duration diff = DateTime.now().difference(parsedDate);
      if (diff.inDays > 0) {
        return "تم الإرسال منذ ${diff.inDays} يوم";
      } else if (diff.inHours > 0) {
        return "تم الإرسال منذ ${diff.inHours} ساعة";
      } else if (diff.inMinutes > 0) {
        return "تم الإرسال منذ ${diff.inMinutes} دقيقة";
      } else {
        return "تم الإرسال منذ قليل";
      }
    } catch (e) {
      return "تم الإرسال منذ يوم";
    }
  }
}
