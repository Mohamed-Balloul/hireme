import 'package:get/get.dart';

validInput(String val, int min, int max, String type) {
  // 3. التحقق حسب النوع
  if (type == "description") {
    // التعبير النمطي يدعم:
    // - الحروف العربية: \u0600-\u06FF
    // - الحروف الإنجليزية: a-zA-Z
    // - الأرقام: 0-9
    // - الفراغات والرموز الشائعة: \s, -, .
    RegExp jobTitleRegExp = RegExp(r'^[\u0600-\u06FFa-zA-Z0-9\s\-\.]+$');

    if (!jobTitleRegExp.hasMatch(val)) {
      return "يرجى إدخال نص يحتوي (حروف عربية أو إنجليزية وفراغات فقط)";
    }
  }
  if (type == "username") {
    if (!GetUtils.isUsername(val)) {
      return "اسم المستخدم غير صالح";
    }
  }
  if (type == "password") {
    if (!GetUtils.isUsername(val)) {
      return "كلمة المرور ضعيفة";
    }
  }
  if (type == "email") {
    if (!GetUtils.isEmail(val)) {
      return "البريد الإلكتروني غير صالح";
    }
  }
  if (type == "link") {
    if (!GetUtils.isURL(val)) {
      return "الرابط غير صالح";
    }
  }
  if (type == "phone") {
    if (!GetUtils.isPhoneNumber(val)) {
      return "رقم الهاتف غير صالح";
    }
  }
  if (val.length < min) {
    return "value can't be less than $min";
  }
  if (val.length > max) {
    return "value can't be larger than $max";
  }

  if (val.isEmpty) {
    // return "can't be empty";
    return "لا يمكن ان يكون الحقل فارغ";
  }
}
