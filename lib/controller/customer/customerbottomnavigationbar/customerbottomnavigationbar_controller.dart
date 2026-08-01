import 'package:get/get.dart';
import 'package:hireme/controller/customer/customerhome_controller.dart';
import 'package:hireme/core/class/statusrequest.dart';
import 'package:hireme/core/functions/handlingdatacontroller.dart';
import 'package:hireme/core/services/services.dart';
import 'package:hireme/data/datasource/remote/customer/customer.dart';
import 'package:hireme/data/model/customerprofilemodel.dart';

abstract class CustomerBottomNavigationBarrController extends GetxController {
  onChange(int val);
  //ربط
  getData();
}

class CustomerBottomNavigationBarrControllerImp
    extends CustomerBottomNavigationBarrController {
  int selectedIndex = 0;
  //ربط
  MyServices myServices = Get.find();
  StatusRequest statusRequest = StatusRequest.none;

  CustomerData customerData = CustomerData(Get.find());

  CustomerProfileModel? customerModel;
  //ربط
  @override
  getData() async {
    statusRequest = StatusRequest.loading;
    print(
        "=======CustomerBottomNavigationBarrController=========getData==============-*-Controller $statusRequest ");
    update();

    var response = await customerData.getCustomerData(
        myServices.sharedPreferences.getString("user_id")!,
        myServices.sharedPreferences.getString("token")!);

    print(
        "======CustomerBottomNavigationBarrController=========getData===============* Controller $response ");
    print(
        "======CustomerBottomNavigationBarrController========getData================--Controller $statusRequest ");

    statusRequest = handlingData(response);

    if (StatusRequest.success == statusRequest) {
      // Start backend
      if (response["data"] != null) {
        // data.addAll(response['data']);
        customerModel = CustomerProfileModel.fromJson(response);
        //*
        // استخراج البيانات الهامة من الرد
        // var responseData = response['data'];
        if (Get.isRegistered<CustomerHomeControllerImp>()) {
          Get.find<CustomerHomeControllerImp>().getCustomerData();
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
        "****CustomerBottomNavigationBarrController**********getData************ *-*-* $statusRequest");
  }

  @override
  void onInit() {
    getData();
    super.onInit();
  }

  // add product to cart
  @override
  onChange(val) {
    selectedIndex = val;
    update();
  }
}
