// class MyRequestToCustomerModel {
//   final int? id;
//   final String? publisher;
//   final String? image;

//   final String? serviceTitle;
//   final int? requestState;

//   MyRequestToCustomerModel({
//     this.id,
//     this.publisher,
//     this.image,
//     this.serviceTitle,
//     this.requestState,
//   });

//   factory MyRequestToCustomerModel.fromJson(Map<String, dynamic> json) {
//     return MyRequestToCustomerModel(
//       id: json['id'],
//       publisher: json['publisher'],
//       image: json['image'],
//       serviceTitle: json['service_title'] ?? json['serviceTitle'],
//       requestState: json['request_state'] ?? json['requestState'],
//     );
//   }
// }
class MyRequestToCustomerModel {
  final int? id;
  final String? publisher;
  final String? image;
  final String? serviceTitle;
  final int? requestState;

  MyRequestToCustomerModel({
    this.id,
    this.publisher,
    this.image,
    this.serviceTitle,
    this.requestState,
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

    // 2. معالجة حالة الطلب بشكل دفاعي (إذا لم يرسلها الباك حالياً نفترضها قيد الانتظار)
    final dynamic rawState =
        json['request_state'] ?? json['requestState'] ?? json['status'] ?? 0;
    int parsedRequestState = 0; // افتراضياً قيد الانتظار
    if (rawState != null) {
      parsedRequestState = int.tryParse(rawState.toString()) ?? 0;
    }

    return MyRequestToCustomerModel(
      // المعرّف الخاص بالتقديم على المشروع (مهم لعملية الحذف)
      id: json['id'] != null ? int.tryParse(json['id'].toString()) : null,

      // استخراج اسم العميل الناشر للمشروع
      publisher: customer?['name'] ?? "عميل غير معروف",

      // الغلاف الكامل للمشروع المجهز
      image: fullImage,

      // استخراج عنوان المشروع المقدم عليه
      serviceTitle:
          project?['name'] ?? project?['serviceTitle'] ?? "عنوان غير متوفر",

      // إسناد حالة الطلب المعالجة
      requestState: parsedRequestState,
    );
  }
}
