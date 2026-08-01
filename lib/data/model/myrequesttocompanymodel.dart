// class MyRequestToCompanyModel {
//   final int? id;
//   final String? publisher;
//   final String? logo;
//   final String? jobTitle;
//   final int? orderState;

//   MyRequestToCompanyModel({
//     this.id,
//     this.publisher,
//     this.logo,
//     this.jobTitle,
//     this.orderState,
//   });
//   // إضافة منشئ json لتسهيل عملية التحويل
//   factory MyRequestToCompanyModel.fromJson(Map<String, dynamic> json) {
//     return MyRequestToCompanyModel(
//       id: json['id'],
//       publisher: json['publisher'],
//       logo: json['logo'],
//       // حقول لارافيل تكون غالباً snake_case، قمنا بتوقع الحالتين للاحتياط
//       jobTitle: json['job_title'] ?? json['jobTitle'],
//       orderState: json['order_state'] ?? json['orderState'],
//     );
//   }
// }
class MyRequestToCompanyModel {
  final int? id;
  final String? publisher;
  final String? logo;
  final String? jobTitle;
  final int? orderState;

  MyRequestToCompanyModel({
    this.id,
    this.publisher,
    this.logo,
    this.jobTitle,
    this.orderState,
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

    // 2. معالجة حالة الطلب بشكل دفاعي (إذا لم يرسلها الباك حالياً نفترضها قيد الانتظار)
    final dynamic rawState =
        json['order_state'] ?? json['orderState'] ?? json['status'] ?? 0;
    int parsedOrderState = 0; // افتراضياً قيد الانتظار
    if (rawState != null) {
      parsedOrderState = int.tryParse(rawState.toString()) ?? 0;
    }

    return MyRequestToCompanyModel(
      // المعرّف الخاص بالتقديم على الإعلان (مهم لعملية الحذف)
      id: json['id'] != null ? int.tryParse(json['id'].toString()) : null,

      // استخراج اسم الشركة الناشرة للطلب
      publisher: company?['name'] ?? "شركة غير محددة",

      // اللوجو الكامل للشركة المجهزة
      logo: fullLogo,

      // استخراج المسمى الوظيفي للوظيفة المقدم عليها
      jobTitle: ad?['job_name'] ?? ad?['jobTitle'] ?? "عنوان غير متوفر",

      // إسناد حالة الطلب المعالجة
      orderState: parsedOrderState,
    );
  }
}
