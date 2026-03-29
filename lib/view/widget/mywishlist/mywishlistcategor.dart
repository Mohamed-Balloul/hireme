import 'package:hireme/controller/mywishlist/mywishlist_controller.dart';
import 'package:hireme/core/constant/color.dart';
import 'package:hireme/data/datasource/static/static.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyWishListCategory extends StatelessWidget {
  const MyWishListCategory({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MyWishListControllerImp>(
      builder: (controller) => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ...List.generate(
            myWishListCategory.length,
            (index) => InkWell(
              onTap: () {
                controller.onTapSelectCategoryMyWishList(index);
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
                  myWishListCategory[index],
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
