import 'package:hireme/controller/home/homepage_controller.dart';
import 'package:hireme/core/constant/color.dart';
import 'package:hireme/data/datasource/static/static.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeCategoriesWithLabel extends StatelessWidget {
  const HomeCategoriesWithLabel({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomePageControllerImp>(
      builder: (controller) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ...List.generate(
            homeCategoriesWithLableList.length,
            (index) => InkWell(
              onTap: () {
                controller.onTapSelectCategory(index);
              },
              child: Column(
                children: [
                  Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      border: Border.all(
                        width: 2,
                        color: controller.currentCategory == index
                            ? AppColor.primaryColor
                            : Colors.white,
                      ),
                      borderRadius: BorderRadius.circular(
                        60,
                      ),
                    ),
                    child: Icon(
                      homeCategoriesWithLableList[index].icon,
                      color: AppColor.primaryColor,
                    ),
                  ),
                  Text(
                    homeCategoriesWithLableList[index].label!,
                    style: TextStyle(
                      color: controller.currentCategory == index
                          ? AppColor.primaryColor
                          : Colors.black,
                      fontWeight: controller.currentCategory == index
                          ? FontWeight.bold
                          : FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
