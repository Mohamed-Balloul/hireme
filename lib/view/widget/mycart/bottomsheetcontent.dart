import 'package:hireme/controller/mycart/mycart_controller.dart';
import 'package:hireme/view/widget/mycart/primecustombutton.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BottomSheetContent extends GetView<MyCartControllerImp> {
  const BottomSheetContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      height: 200,
      width: double.infinity,
      // color: Colors.white,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Sub-Total",
                style: TextStyle(
                  color: Colors.grey,
                ),
              ),
              Text(
                "\$${controller.totalPrice}",
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Delivery Fee",
                style: TextStyle(
                  color: Colors.grey,
                ),
              ),
              Text(
                "\$25",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Discount",
                style: TextStyle(
                  color: Colors.grey,
                ),
              ),
              Text(
                "-\$35",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Total Cost",
                style: TextStyle(
                  color: Colors.grey,
                ),
              ),
              Text(
                "\$${controller.totalPrice + 25 - 35}",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: 20,
            ),
            child: PrimeCustomButton(
              onPressed: () {
                controller.goToCheckout();
              },
              text: "Proceed To Checkout",
            ),
          ),
        ],
      ),
    );
  }
}
