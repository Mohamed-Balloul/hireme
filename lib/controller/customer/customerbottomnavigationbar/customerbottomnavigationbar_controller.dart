import 'package:get/get.dart';
import 'package:hireme/controller/customer/customerhome_controller.dart';
import 'package:hireme/core/class/statusrequest.dart';
import 'package:hireme/core/functions/handlingdatacontroller.dart';
import 'package:hireme/core/services/services.dart';
import 'package:hireme/data/datasource/remote/customer/customer.dart';
import 'package:hireme/data/model/customerprofilemodel.dart';

abstract class CustomerBottomNavigationBarrController extends GetxController {
  onChange(int val);
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

  @override
  void onInit() {
    getData();
    super.onInit();
  }

  //ربط
  @override
  getData() async {
    statusRequest = StatusRequest.loading;
    print("==============================-*-Controller $statusRequest ");
    update();

    var response = await customerData.getCustomerData(
        myServices.sharedPreferences.getString("id")!,
        myServices.sharedPreferences.getString("token")!);

    print("==============================* Controller $response ");
    print("==============================--Controller $statusRequest ");

    statusRequest = handlingData(response);

    if (StatusRequest.success == statusRequest) {
      // Start backend
      if (response["message"] != null) {
        customerModel = CustomerProfileModel.fromJson(response);

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
    print("************************** *-*-* $statusRequest");
  }

  // add product to cart
  @override
  onChange(val) {
    selectedIndex = val;
    update();
  }
}
