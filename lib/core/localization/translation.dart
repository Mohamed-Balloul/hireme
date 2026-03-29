import 'package:get/get.dart';

class MyTranslation extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        "ar": {"1": "اختر لغتك", "2": "أهلا بك"},
        "en": {"1": "Choose Your Language", "2": "Welcome Back"}
      };
}
