import 'package:hireme/controller/home/homepage_controller.dart';
import 'package:hireme/core/constant/color.dart';
import 'package:hireme/data/datasource/static/static.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FlashSaleCategory extends StatelessWidget {
  const FlashSaleCategory({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomePageControllerImp>(
      builder: (controller) => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ...List.generate(
            flashSaleCategory.length,
            (index) => InkWell(
              onTap: () {
                controller.onTapSelectCategoryFlashSale(index);
              },
              child: Container(
                margin: const EdgeInsets.only(
                  right: 5,
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 10.5,
                  vertical: 3.5,
                ),
                decoration: BoxDecoration(
                  color: controller.currentFlashCategory == index
                      ? AppColor.primaryColor
                      : Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(
                    // color: Colors.grey,
                    color: controller.currentFlashCategory == index
                        ? AppColor.primaryColor
                        : Colors.grey,
                  ),
                ),
                child: Text(
                  flashSaleCategory[index],
                  style: TextStyle(
                    color: controller.currentFlashCategory == index
                        ? Colors.white
                        : Colors.black,
                    fontSize: 16,
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
