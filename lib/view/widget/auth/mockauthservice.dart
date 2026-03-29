import 'package:hireme/view/widget/auth/usertype.dart';

class MockAuthService {
  // هذه الدالة تحاكي ما سيأتي لاحقاً من الـ API
  Future<UserType> login(String email, String password) async {
    await Future.delayed(Duration(seconds: 2)); // محاكاة وقت التحميل

    // منطق وهمي للتجريب:
    if (email.contains('company')) {
      return UserType.company;
    } else if (email.contains('customer')) {
      return UserType.customer;
    } else {
      return UserType.student;
    }
  }
}
