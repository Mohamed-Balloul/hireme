import 'package:hireme/controller/productdetails/productdetails_controller.dart';
import 'package:hireme/core/constant/color.dart';
import 'package:hireme/data/datasource/static/static.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SelectSize extends StatelessWidget {
  const SelectSize({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProductDetailsControllerImp>(
      builder: (controller) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ...List.generate(
            selectSizeList.length,
            (index) => InkWell(
              onTap: () {
                controller.onTapSelectCategoryFlashSale(index);
              },
              child: Container(
                margin: EdgeInsets.only(right: 5, bottom: 5),
                padding: EdgeInsets.symmetric(
                  horizontal: 10.5,
                  vertical: 3.5,
                ),
                decoration: BoxDecoration(
                  color: controller.currentFlashCategory == index
                      ? AppColor.primaryColor
                      : Colors.white,
                  borderRadius: BorderRadius.circular(7),
                  border: Border.all(
                    // color: Colors.grey,
                    color: controller.currentFlashCategory == index
                        ? AppColor.primaryColor
                        : Color.fromARGB(255, 229, 227, 227),
                  ),
                ),
                child: Text(
                  selectSizeList[index],
                  style: TextStyle(
                    color: controller.currentFlashCategory == index
                        ? Colors.white
                        : Colors.black,
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
