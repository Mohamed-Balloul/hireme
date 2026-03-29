import 'package:hireme/core/constant/routes.dart';
import 'package:hireme/data/model/homegridflashsalesmodel.dart';
import 'package:get/get.dart';

abstract class MyCartController extends GetxController {
  addToCart(HomeGridFlashSalesModel product);
  removeItemFromCart(HomeGridFlashSalesModel product);
  increaseQuantity(HomeGridFlashSalesModel product);
  decreaseQuantity(HomeGridFlashSalesModel product);
  goToCheckout();
  // totalPrice(HomeGridFlashSalesModel product);
}

class MyCartControllerImp extends MyCartController {
  // List<HomeGridFlashSalesModel> cartItems = <HomeGridFlashSalesModel>[].obs;
  var cartItems = <HomeGridFlashSalesModel>[].obs;
  // late PageController pageController;
  // int currentPage = 0;
  int currentFlashCategory = 0;
  // int currentCategory = 0;

  // MyServices myServices = Get.find();

  @override
  removeItemFromCart(product) {
    cartItems.remove(product);
  }

  @override
  increaseQuantity(product) {
    product.quantity++;
    cartItems.refresh();
  }

  @override
  decreaseQuantity(HomeGridFlashSalesModel product) {
    if (product.quantity > 1) {
      product.quantity--;
      cartItems.refresh();
    } else {
      cartItems.remove(product);
    }
  }

  double get totalPrice {
    return cartItems.fold(
        0,
        (sum, item) =>
            sum +
            (double.tryParse(item.price.replaceAll("\$", "")) ?? 0) *
                item.quantity);
  }

  @override
  void onInit() {
    // pageController = PageController();
    super.onInit();
  }

  // add product to cart
  @override
  addToCart(product) {
    int index = -1;
    index = cartItems.indexWhere((element) => element.label == product.label);
    if (index >= 0) {
      cartItems[index].quantity += 1;
    } else {
      cartItems.add(product);
    }
  }

  @override
  goToCheckout() {
    Get.toNamed(AppRoute.checkout);
  }
}
