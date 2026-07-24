import 'dart:math';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';
import 'package:hireme/core/services/services.dart';
import 'package:hireme/data/datasource/remote/student/notifications.dart';

abstract class NotificationsController extends GetxController {}

class NotificationsControllerImp extends NotificationsController {
  final FirebaseMessaging _fcm = FirebaseMessaging.instance;

  @override
  void onInit() {
    super.onInit();
    _initDeviceId(); // 2. استدعاء توليد معرّف الجهاز فور بدء تشغيل الكنترولر

    _initializeFCM();
  }

  // دالة لتوليد وحفظ معرّف فريد للجهاز إذا لم يكن موجوداً سابقاً
  Future<void> _initDeviceId() async {
    MyServices myServices = Get.find();
    String? deviceId = myServices.sharedPreferences.getString("device_id");

    if (deviceId == null) {
      // توليد نص عشوائي فريد بطول 24 خانة كمعرّف للجهاز
      String generatedId = _generateRandomId(24);
      await myServices.sharedPreferences.setString("device_id", generatedId);
      print(
          "=================== New Device ID Generated: $generatedId ===================");
    } else {
      print(
          "=================== Existing Device ID Found: $deviceId ===================");
    }
  }

  // دالة مساعدة لتوليد نص عشوائي فريد
  String _generateRandomId(int length) {
    const chars = 'abcdefghijklmnopqrstuvwxyz0123456789';
    final random = Random();
    return String.fromCharCodes(Iterable.generate(
      length,
      (_) => chars.codeUnitAt(random.nextInt(chars.length)),
    ));
  }

  // 1. إعداد وتفعيل الإشعارات
  Future<void> _initializeFCM() async {
    // طلب صلاحيات الإشعارات (مهم جداً للـ iOS والـ Android 13+)
    NotificationSettings settings = await _fcm.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('User granted permission');
      print('حالة صلاحية الإشعارات: ${settings.authorizationStatus}');
      // الحصول على الـ Token وإرساله للسيرفر
      await getAndSaveToken();

      // إعداد التنصت (Listeners) على الإشعارات
      _setupNotificationListeners();
    } else {
      print('User declined or has not accepted permission');
    }
  }

  // 2. جلب وتحديث الـ Token
  Future<void> getAndSaveToken() async {
    String? token = await _fcm.getToken();
    if (token != null) {
      print("@=@=@=@=@=@=@=@=@=@=@=@=@=@=@= FCM Token: $token");
      // حفظ التوكن محلياً لتستطيع واجهة الـ Verify الوصول إليه
      MyServices myServices = Get.find();
      await myServices.sharedPreferences.setString("fcm_token", token);

      // هنا نقوم باستدعاء الـ API الخاص بـ Laravel لحفظ الـ Token الخاص بالمستخدم الحالي
      await _sendTokenToBackend(token);
    }

    // الاستماع في حال تغير الـ Token أثناء تشغيل التطبيق
    _fcm.onTokenRefresh.listen((newToken) async {
      await _sendTokenToBackend(newToken);
    });
  }

  Future<void> _sendTokenToBackend(String token) async {
    // استدعاء الـ Repository أو الـ Service لإرسال الـ Token للـ API
    // مثال: await _apiService.saveFcmToken(token);
    NotificationData notificationData = NotificationData(Get.find());
    MyServices myServices = Get.find();
    String? accessToken = myServices.sharedPreferences.getString("token");

    if (accessToken != null) {
      Map data = {
        // بدلاً من "android-id-xyz" الثابتة:
        "device_id": myServices.sharedPreferences.getString("device_id") ??
            "unknown_device",
        "fcm_token": token,
        "platform": GetPlatform.isAndroid ? "android" : "ios",
        "app_version": "1.0.0" // يفضل جلبها من PackageInfo
      };
      var response = await notificationData.registerDevice(accessToken, data);
      print("Device Token Registered on Server Successfully!");
      if (response['status'] == "success" || response['data'] != null) {
        // حفظ رقم السجل القادم من السيرفر لاستخدامه عند تسجيل الخروج
        String deviceRecordId = response['data']['id'].toString();
        myServices.sharedPreferences
            .setString("device_record_id", deviceRecordId);
        print("Saved Device Record ID: $deviceRecordId");
      }
    }
  }

  // 3. الاشتراك في الـ Topic بناءً على دور المستخدم
  // يتم استدعاء هذه الدالة بعد تسجيل الدخول بنجاح ومعرفة الـ Role
  Future<void> subscribeToUserTopic(String role) async {
    // نقوم بإلغاء اشتراكه من المواضيع الأخرى أولاً لتجنب التداخل
    await _fcm.unsubscribeFromTopic('student');
    await _fcm.unsubscribeFromTopic('company');
    await _fcm.unsubscribeFromTopic('client');

    // الاشتراك في الـ Topic الجديد
    if (role == 'student') {
      await _fcm.subscribeToTopic('students');
    } else if (role == 'company') {
      await _fcm.subscribeToTopic('companies');
    } else if (role == 'client') {
      await _fcm.subscribeToTopic('clients');
    }
  }

  // 4. إعداد التنصت على حالات الإشعارات المختلفة
  void _setupNotificationListeners() {
    // الحالة الأولى: عندما يكون التطبيق مفتوحاً في الواجهة (Foreground)
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      if (message.notification != null) {
        print(
            " ====== on Message app is foreground ========= Title: ${message.notification!.title}");
        print(
            " ====== on Message app is foreground ========= Body: ${message.notification!.body}");

        print('Foreground Message received: ${message.notification?.title}');
        _handleForegroundNotification(message);
      }
    });

    // الحالة الثانية: عند النقر على الإشعار والتطبيق في الخلفية (Background)
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('Notification clicked while app in background');
      print("============= Background Message clicked =================");
      print(message.notification!.title);
      print(message.notification!.body);
      print("============= Background Message clicked =================");
      _handleNotificationClick(message);
    });

    // الحالة الثالثة: عند فتح التطبيق من الصفر عن طريق النقر على الإشعار (Terminated)
    _checkInitialMessage();
  }

  // التحقق من الإشعار الذي تسبب بفتح التطبيق من الصفر
  Future<void> _checkInitialMessage() async {
    RemoteMessage? initialMessage = await _fcm.getInitialMessage();
    if (initialMessage != null) {
      print('App opened from terminated state via notification');
      // تأخير بسيط للتأكد من أن الـ Routing الخاص بـ GetX جاهز بالكامل
      Future.delayed(Duration(milliseconds: 500), () {
        _handleNotificationClick(initialMessage);
      });
    }
  }

  // 5. معالجة الإشعار في حال كان التطبيق مفتوحاً (Foreground)
  void _handleForegroundNotification(RemoteMessage message) {
    // هنا سنقرر كيف نعرض الإشعار للمستخدم وهو يتصفح التطبيق حالياً
    // سنناقش هذا بالتفصيل لاحقاً (مثلاً: إظهار Get.snackbar مخصص)
    Get.snackbar(
      message.notification!.title ?? "تنبيه جديد", // عنوان الإشعار
      message.notification!.body ?? "", // نص الإشعار
      snackPosition: SnackPosition.BOTTOM, // مكان الظهور (اختياري)
    );
  }

  // 6. معالجة النقر على الإشعار والتوجيه للشاشة الصحيحة (Routing)
  void _handleNotificationClick(RemoteMessage message) {
    final Map<String, dynamic> data = message.data;

    // قراءة البيانات المرسلة من الباك إند
    final String? route = data['route'];
    final String? entityId = data['entity_id'];
    final String? userType = data['user_type'];

    if (route != null) {
      // هنا يكمن التنظيم الاحترافي:
      // نتحقق أولاً إن كان المستخدم الحالي يملك الصلاحية (مثلاً الطالب لا يمكنه فتح شاشة خاصة بالشركة)
      // يمكنك فحص الـ Role الحالي المخزن محلياً لديك (عبر GetStorage أو كلاس الـ Auth)
      String currentUserRole = "student"; // افترضنا أنه طالب هنا كمثال

      if (userType == null || userType == currentUserRole) {
        // التوجيه باستخدام GetX وتمرير الـ ID كـ arguments
        Get.toNamed(route, arguments: entityId);
      } else {
        print("User role does not match the notification target role");
      }
    }
  }
}
