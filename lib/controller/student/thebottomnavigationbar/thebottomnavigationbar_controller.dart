import 'package:get/get.dart';
import 'package:hireme/core/class/statusrequest.dart';
import 'package:hireme/core/functions/handlingdatacontroller.dart';
import 'package:hireme/core/services/services.dart';
import 'package:hireme/data/datasource/remote/student/student.dart';
import 'package:hireme/data/model/studentprofilemodel.dart';

abstract class StudentBottomNavigationBarrController extends GetxController {
  onChange(int val);
}

class StudentBottomNavigationBarrControllerImp
    extends StudentBottomNavigationBarrController {
  int selectedIndex = 0;
  //ربط
  MyServices myServices = Get.find();
  StatusRequest statusRequest = StatusRequest.none;

  StudentData studentData = StudentData(Get.find());

  // List data = [];
  StudentProfileModel? studentModel;
  //ربط

  getData() async {
    statusRequest = StatusRequest.loading;
    print(
        "===============StudentBottomNavigationBarrControllerImp===============-*-Controller $statusRequest ");
    update();
    // بعد ما ينجح الـ API call
    // await Future.delayed(const Duration(seconds: 5)); // أضف هذا السطر
    // ثم انتقل لصفحة الـ

    var response = await studentData.getStudentData(
        myServices.sharedPreferences.getString("user_id")!,
        myServices.sharedPreferences.getString("token")!);

    print(
        "==========StudentBottomNavigationBarrControllerImp======== The Response ============* Controller $response ");
    print(
        "==========StudentBottomNavigationBarrControllerImp====================--Controller $statusRequest ");

    statusRequest = handlingData(response);

    if (StatusRequest.success == statusRequest) {
      // Start backend
      if (response['data'] != null) {
        // data.addAll(response['data']);
        studentModel = StudentProfileModel.fromJson(response['data']);
        //*
        // استخراج البيانات الهامة من الرد
        // var responseData = response['data'];
      } else {
        // Get.defaultDialog(
        //   title: "warning",
        //   middleText: "email or password is wrong, try again",
        // );
        statusRequest = StatusRequest.failure;
      }
      // End
    } else {}
    update();
    print(
        "*************StudentBottomNavigationBarrControllerImp************* *-*-* $statusRequest");
  }

  @override
  void onInit() {
    //--
    getData();

    //--
    super.onInit();
  }

  @override
  onChange(val) {
    selectedIndex = val;
    update();
  }
}
