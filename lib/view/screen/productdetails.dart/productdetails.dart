// import 'package:hireme/data/datasource/static/static.dart';
import 'package:hireme/controller/mycart/mycart_controller.dart';
import 'package:hireme/controller/productdetails/productdetails_controller.dart';
import 'package:hireme/core/constant/routes.dart';
import 'package:hireme/data/model/homegridflashsalesmodel.dart';
import 'package:hireme/view/widget/productdetails/custombutton.dart';
import 'package:hireme/view/widget/productdetails/selectsize.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductDetails extends StatelessWidget {
  final HomeGridFlashSalesModel homeGridFlashSalesModel;
  const ProductDetails({super.key, required this.homeGridFlashSalesModel});

  @override
  Widget build(BuildContext context) {
    ProductDetailsControllerImp controller =
        Get.put(ProductDetailsControllerImp());
    MyCartControllerImp cartController = Get.put(MyCartControllerImp());
    return SafeArea(
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              height: 275,
              decoration: BoxDecoration(
                color: Colors.green,
              ),
              child: ClipRRect(
                child: Image.asset(
                  homeGridFlashSalesModel.image!,
                  fit: BoxFit.fill,
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.only(
                top: 25,
                left: 20,
                right: 20,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    homeGridFlashSalesModel.styleType!,
                    style: TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      bottom: 15,
                      top: 5,
                    ),
                    child: Text(
                      homeGridFlashSalesModel.fullLabel!,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 17,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      bottom: 3,
                    ),
                    child: Text(
                      "Product Details",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                  ),
                  Text(
                    homeGridFlashSalesModel.productDetalils!,
                    style: TextStyle(
                      color: const Color.fromARGB(255, 133, 133, 133),
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  Divider(),
                  Padding(
                    padding: const EdgeInsets.only(
                      bottom: 3,
                    ),
                    child: Text(
                      "Select Size",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                  ),
                  SelectSize(),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 27),
                    child: Divider(),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Column(
                          children: [
                            Text(
                              "Total Price",
                              style: TextStyle(
                                color: Colors.grey,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            Text(
                              homeGridFlashSalesModel.price!,
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                        CustomButton(
                          onPressed: () {
                            cartController.addToCart(homeGridFlashSalesModel);
                            // Get.snackbar(
                            //   "Added to Cart",
                            //   "${homeGridFlashSalesModel.label} has been added!",
                            //   snackPosition: SnackPosition.BOTTOM,
                            // );
                            // Get.toNamed(AppRoute.myCart);

                            // Get.toNamed(AppRoute.myWishList);
                          },
                          icon: Icons.shopping_bag,
                          text: "Add to Cart",
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
