// class MyRequestToCustomerModel {
//   final int? id;
//   final int? publisherId; // معرف العميل الناشر للمشروع
//   final String? publisher;
//   final String? image;
//   final String? serviceTitle;
//   final int? requestState;

//   MyRequestToCustomerModel({
//     this.id,
//     this.publisherId,
//     this.publisher,
//     this.image,
//     this.serviceTitle,
//     this.requestState,
//   });

//   // منشئ json المحدث والمتوافق مع البيانات المتداخلة للباك-إند
//   factory MyRequestToCustomerModel.fromJson(Map<String, dynamic> rawJson) {
//     // خطوة أمان: التحقق من تمرير الكائن الأساسي أو كائن 'data' الداخلي
//     final Map<String, dynamic> json =
//         (rawJson['data'] is Map<String, dynamic>) ? rawJson['data'] : rawJson;

//     // استخراج كائن المشروع 'project' المتداخل
//     final project = json['project'] as Map<String, dynamic>?;

//     // استخراج كائن العميل 'customer' المتداخل داخل كائن المشروع
//     final customer = project?['customer'] as Map<String, dynamic>?;

//     // 1. معالجة وتأمين غلاف المشروع ودمج رابط السيرفر للمسارات النسبية
//     final String? rawImage = project?['cover_image'] ?? project?['image'];
//     String fullImage =
//         'https://images.unsplash.com/photo-1441986300917-64674bd600d8?q=80&w=1000&auto=format&fit=crop'; // غلاف افتراضي للمشروع

//     if (rawImage != null && rawImage.isNotEmpty) {
//       fullImage = rawImage.startsWith('http')
//           ? rawImage
//           : "https://cage-sleep-dallying.ngrok-free.dev/storage/$rawImage";
//     }

//     // 2. معالجة حالة الطلب بشكل دفاعي (إذا لم يرسلها الباك حالياً نفترضها قيد الانتظار)
//     final dynamic rawState =
//         json['request_state'] ?? json['requestState'] ?? json['status'] ?? 0;
//     int parsedRequestState = 0; // افتراضياً قيد الانتظار
//     if (rawState != null) {
//       parsedRequestState = int.tryParse(rawState.toString()) ?? 0;
//     }

//     // 3. استخراج معرف العميل الناشر للمشروع (publisherId) بشكل محمي وصارم لتفادي الـ null كلياً
//     int? parsedPublisherId;

//     // محاولة أولى: جلب المعرف من "customer_id" بداخل المشروع "project"
//     if (project?['customer_id'] != null) {
//       parsedPublisherId = int.tryParse(project!['customer_id'].toString());
//     }
//     // محاولة ثانية (احتياطية): جلب المعرف من "id" بداخل كائن العميل "customer"
//     if (parsedPublisherId == null && customer?['id'] != null) {
//       parsedPublisherId = int.tryParse(customer!['id'].toString());
//     }

//     return MyRequestToCustomerModel(
//       // المعرّف الخاص بالتقديم على المشروع (مهم لعملية الحذف)
//       id: json['id'] != null ? int.tryParse(json['id'].toString()) : null,

//       // إسناد معرّف العميل المستخرج بأمان تام
//       publisherId: parsedPublisherId,

//       // استخراج اسم العميل الناشر للمشروع
//       publisher: customer?['name'] ?? "عميل غير معروف",

//       // الغلاف الكامل للمشروع المجهز
//       image: fullImage,

//       // استخراج عنوان المشروع المقدم عليه
//       serviceTitle:
//           project?['name'] ?? project?['serviceTitle'] ?? "عنوان غير متوفر",

//       // إسناد حالة الطلب المعالجة
//       requestState: parsedRequestState,
//     );
//   }
// }
//---------------
class MyRequestToCustomerModel {
  final int? id;
  final int? publisherId; // معرف العميل الناشر للمشروع
  final String? publisher;
  final String? image;
  final String? serviceTitle;
  final int? requestState;
  final String? time; // تم إضافة حقل الوقت المحدث هنا للربط

  MyRequestToCustomerModel({
    this.id,
    this.publisherId,
    this.publisher,
    this.image,
    this.serviceTitle,
    this.requestState,
    this.time, // الباني المحدث
  });

  // منشئ json المحدث والمتوافق مع البيانات المتداخلة للباك-إند
  factory MyRequestToCustomerModel.fromJson(Map<String, dynamic> rawJson) {
    // خطوة أمان: التحقق من تمرير الكائن الأساسي أو كائن 'data' الداخلي
    final Map<String, dynamic> json =
        (rawJson['data'] is Map<String, dynamic>) ? rawJson['data'] : rawJson;

    // استخراج كائن المشروع 'project' المتداخل
    final project = json['project'] as Map<String, dynamic>?;

    // استخراج كائن العميل 'customer' المتداخل داخل كائن المشروع
    final customer = project?['customer'] as Map<String, dynamic>?;

    // 1. معالجة وتأمين غلاف المشروع ودمج رابط السيرفر للمسارات النسبية
    final String? rawImage = project?['cover_image'] ?? project?['image'];
    String fullImage =
        'https://images.unsplash.com/photo-1441986300917-64674bd600d8?q=80&w=1000&auto=format&fit=crop'; // غلاف افتراضي للمشروع

    if (rawImage != null && rawImage.isNotEmpty) {
      fullImage = rawImage.startsWith('http')
          ? rawImage
          : "https://cage-sleep-dallying.ngrok-free.dev/storage/$rawImage";
    }

    // 2. معالجة وتحويل حالة الطلب النصية (status) إلى المعرف الرقمي المتوقع في الواجهة
    final String rawState = (json['status'] ??
            json['request_state'] ??
            json['requestState'] ??
            "pending")
        .toString()
        .toLowerCase();

    int parsedRequestState = 0; // افتراضي قيد الانتظار
    if (rawState == "accepted" ||
        rawState == "approved" ||
        rawState == "assigned" ||
        rawState == "accepted_by_client" ||
        rawState == "1") {
      parsedRequestState = 1; // تمت الموافقة
    } else if (rawState == "rejected" ||
        rawState == "rejected_by_client" ||
        rawState == "2") {
      parsedRequestState = 2; // تم الرفض
    } else {
      parsedRequestState = 0; // قيد الانتظار
    }

    // 3. استخراج معرف العميل الناشر للمشروع (publisherId) بشكل محمي وصارم لتفادي الـ null كلياً
    int? parsedPublisherId;

    // محاولة أولى: جلب المعرف من "customer_id" بداخل المشروع "project"
    if (project?['customer_id'] != null) {
      parsedPublisherId = int.tryParse(project!['customer_id'].toString());
    }
    // محاولة ثانية (احتياطية): جلب المعرف من "id" بداخل كائن العميل "customer"
    if (parsedPublisherId == null && customer?['id'] != null) {
      parsedPublisherId = int.tryParse(customer!['id'].toString());
    }

    // 4. استخراج وقت إنشاء الطلب وحساب الفارق الزمني برمجياً وتنسيقه بالعربية
    String formattedTime = "تم الإرسال منذ ساعات"; // قيمة افتراضية للاحتياط
    if (json['created_at'] != null) {
      formattedTime =
          _parseDateTimeToFriendlyString(json['created_at'].toString());
    }

    return MyRequestToCustomerModel(
      // المعرّف الخاص بالتقديم على المشروع (مهم لعملية الحذف)
      id: json['id'] != null ? int.tryParse(json['id'].toString()) : null,

      // إسناد معرّف العميل المستخرج بأمان تام
      publisherId: parsedPublisherId,

      // استخراج اسم العميل الناشر للمشروع
      publisher: customer?['name'] ?? "عميل غير معروف",

      // الغلاف الكامل للمشروع المجهز
      image: fullImage,

      // استخراج عنوان المشروع المقدم عليه
      serviceTitle:
          project?['name'] ?? project?['serviceTitle'] ?? "عنوان غير متوفر",

      // إسناد حالة الطلب المعالجة الرقمية المطابقة تماماً لـ MyOrders
      requestState: parsedRequestState,

      // إسناد الوقت المجهز المنسق
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
      return "تم الإرسال منذ ساعات";
    }
  }
}
