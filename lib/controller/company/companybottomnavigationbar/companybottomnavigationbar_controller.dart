import 'package:get/get.dart';
import 'package:hireme/controller/company/companyhome_controller.dart';
import 'package:hireme/core/class/statusrequest.dart';
import 'package:hireme/core/functions/handlingdatacontroller.dart';
import 'package:hireme/core/services/services.dart';
import 'package:hireme/data/datasource/remote/company/company.dart';
import 'package:hireme/data/model/companyprofilemodel.dart';

abstract class CompanyBottomNavigationBarrController extends GetxController {
  onChange(int val);
  getData();
}

class CompanyBottomNavigationBarrControllerImp
    extends CompanyBottomNavigationBarrController {
  int selectedIndex = 0;
  //ربط
  MyServices myServices = Get.find();
  StatusRequest statusRequest = StatusRequest.none;

  CompanyData companyData = CompanyData(Get.find());

  // List data = [];
  CompanyProfileModel? companyModel;
  //ربط
  @override
  getData() async {
    statusRequest = StatusRequest.loading;
    print(
        "=======CompanyBottomNavigationBarrController=========getData==============-*-Controller $statusRequest ");
    update();

    var response = await companyData.getCompanyData(
        myServices.sharedPreferences.getString("user_id")!,
        myServices.sharedPreferences.getString("token")!);

    print(
        "======CompanyBottomNavigationBarrController=========getData===============* Controller $response ");
    print(
        "======CompanyBottomNavigationBarrController========getData================--Controller $statusRequest ");

    statusRequest = handlingData(response);

    if (StatusRequest.success == statusRequest) {
      // Start backend
      if (response["data"] != null) {
        // data.addAll(response['data']);
        companyModel = CompanyProfileModel.fromJson(response);
        //*
        // استخراج البيانات الهامة من الرد
        // var responseData = response['data'];
        if (Get.isRegistered<CompanyHomeControllerImp>()) {
          Get.find<CompanyHomeControllerImp>().getCompanyData();
        }
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
        "****CompanyBottomNavigationBarrController**********getData************ *-*-* $statusRequest");
  }

  @override
  void onInit() {
    getData();
    // pageController = PageController();
    super.onInit();
  }

  // add product to cart
  @override
  onChange(val) {
    selectedIndex = val;
    update();
  }
}
