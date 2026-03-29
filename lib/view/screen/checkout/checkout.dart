import 'package:hireme/controller/checkout/checout_controller.dart';
import 'package:hireme/controller/mycart/mycart_controller.dart';
import 'package:hireme/core/constant/color.dart';
import 'package:hireme/data/model/homegridflashsalesmodel.dart';
import 'package:hireme/view/widget/mycart/primecustombutton.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../widget/checkout/custombutton.dart';

class Checkout extends GetView<MyCartControllerImp> {
  const Checkout({super.key});

  @override
  Widget build(BuildContext context) {
    CheckoutControllerImp checkController = Get.put(CheckoutControllerImp());
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: const Text("            Checkout")),
        body: Padding(
          padding: const EdgeInsets.all(13),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Text(
                  "Shipping Address",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 1),
                        child: Icon(
                          Icons.location_on_outlined,
                          size: 20,
                        ),
                      ),
                      Column(
                        children: [
                          Text(
                            "london",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text("street 4"),
                        ],
                      ),
                    ],
                  ),
                  //
                  CustomButton(
                    onPressed: () {},
                    text: "CHANGE",
                  ),
                ],
              ),
              Divider(),
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Text(
                  "Choose Shipping Type",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 3),
                        child: Icon(
                          Icons.local_shipping_outlined,
                          size: 20,
                        ),
                      ),
                      Column(
                        children: [
                          Text(
                            "Economy",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text("street 4"),
                        ],
                      ),
                    ],
                  ),
                  //
                  CustomButton(
                    onPressed: () {},
                    text: "CHANGE",
                  ),
                ],
              ),
              Divider(),
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Text(
                  "Order List",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              //
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
                                    left: 0,
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
              Center(
                child: Container(
                  margin: EdgeInsets.only(
                    top: 15,
                  ),
                  child: PrimeCustomButton(
                    onPressed: () {
                      checkController.goToPayment();
                    },
                    text: "Continue To Payment",
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
