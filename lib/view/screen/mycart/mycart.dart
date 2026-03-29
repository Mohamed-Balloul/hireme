// import 'package:hireme/data/datasource/static/static.dart';
import 'package:hireme/controller/mycart/mycart_controller.dart';
import 'package:hireme/core/constant/color.dart';
import 'package:hireme/data/model/homegridflashsalesmodel.dart';
import 'package:hireme/view/widget/mycart/bottomsheetcontent.dart';
import 'package:hireme/view/widget/mycart/primecustombutton.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyCart extends StatelessWidget {
  // final HomeGridFlashSalesModel homeGridFlashSalesModel;
  const MyCart({
    super.key,
    /*required this.homeGridFlashSalesModel*/
  });

  @override
  Widget build(BuildContext context) {
    MyCartControllerImp controller =
        Get.put(MyCartControllerImp(), permanent: true);
    return Scaffold(
      appBar: AppBar(title: const Text("My Cart")),
      body: Obx(() {
        if (controller.cartItems.isEmpty) {
          return const Center(child: Text("Your cart is empty"));
        }

        return Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: controller.cartItems.length,
                itemBuilder: (context, index) {
                  HomeGridFlashSalesModel item = controller.cartItems[index];
                  return Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          //image
                          Row(
                            children: [
                              Container(
                                margin: EdgeInsets.only(
                                  left: 20,
                                  bottom: 5,
                                  right: 13,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.grey,
                                  border: Border.all(
                                    color: AppColor.primaryColor,
                                    width: 2,
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Image.asset(
                                    width: 75,
                                    height: 75,
                                    item.image!,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    item.label!,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        "Size : ",
                                        style: TextStyle(
                                          color: Colors.grey,
                                        ),
                                      ),
                                      Text(
                                        item.size!,
                                        style: TextStyle(
                                          color: Colors.grey,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Text(
                                    item.price!,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              right: 20,
                            ),
                            child: Row(
                              children: [
                                InkWell(
                                  onTap: () {
                                    controller.decreaseQuantity(item);
                                  },
                                  child: Container(
                                    margin: EdgeInsets.only(
                                      right: 7,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Color.fromARGB(255, 216, 216, 216),
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    width: 20,
                                    height: 20,
                                    child: Icon(
                                      Icons.remove,
                                      size: 15,
                                    ),
                                  ),
                                ),
                                Text("${item.quantity}"),
                                InkWell(
                                  onTap: () {
                                    controller.increaseQuantity(item);
                                  },
                                  child: Container(
                                    margin: EdgeInsets.only(
                                      left: 7,
                                    ),
                                    decoration: BoxDecoration(
                                      color: AppColor.primaryColor,
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    width: 20,
                                    height: 20,
                                    child: Icon(
                                      Icons.add,
                                      size: 15,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const Divider(
                        thickness: 3,
                        color: Color.fromARGB(255, 231, 230, 230),
                      ),
                    ],
                  );
                },
              ),
            ),
            //
            Container(
              margin: EdgeInsets.all(10),
              child: PrimeCustomButton(
                onPressed: () {
                  Get.bottomSheet(
                    backgroundColor: Colors.white,
                    BottomSheetContent(),
                  );
                },
                text: "Buy Now",
              ),
            ),
          ],
        );
      }),
    );
  }
}
