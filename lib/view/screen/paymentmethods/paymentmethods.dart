import 'package:hireme/controller/paymentmethod/paymentmethods_controller.dart';
import 'package:hireme/core/constant/color.dart';
import 'package:hireme/view/widget/mycart/primecustombutton.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PaymentMethods extends StatelessWidget {
  const PaymentMethods({super.key});

  @override
  Widget build(BuildContext context) {
    PaymentMethodsControllerImp controller =
        Get.put(PaymentMethodsControllerImp());
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: Text("Payment Methods"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Credit & Debit Card",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 5, bottom: 15),
              child: Center(child: PrimeCustomButton(text: "Add Card")),
            ),
            Text(
              "More Payment Options",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            GetBuilder<PaymentMethodsControllerImp>(
              builder: (controller) => Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(color: Colors.grey, width: 1)),
                  child: Column(
                    children: [
                      RadioListTile(
                        activeColor: AppColor.primaryColor,
                        title: Text("Paypal"),
                        groupValue: controller.paymentMethod,
                        value: "paypal",
                        onChanged: (value) {
                          controller.onSelect(value);
                        },
                      ),
                      Divider(),
                      RadioListTile(
                        activeColor: AppColor.primaryColor,
                        title: Text("Google Pay"),
                        groupValue: controller.paymentMethod,
                        value: "google",
                        onChanged: (value) {
                          controller.onSelect(value);
                        },
                      ),
                      Divider(),
                      RadioListTile(
                        activeColor: AppColor.primaryColor,
                        title: Text("Apple Pay"),
                        groupValue: controller.paymentMethod,
                        value: "apple",
                        onChanged: (value) {
                          controller.onSelect(value);
                        },
                      )
                    ],
                  ),
                ),
              ),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 15),
                child: PrimeCustomButton(
                  text: "Confirm Payment",
                  onPressed: () {
                    controller.goToPaymentSuccessfuly();
                  },
                ),
              ),
            )
          ],
        ),
      ),
    ));
  }
}
