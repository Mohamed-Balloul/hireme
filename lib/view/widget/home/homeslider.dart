import 'package:hireme/controller/home/homepage_controller.dart';
import 'package:hireme/data/datasource/static/static.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeSlider extends GetView<HomePageControllerImp> {
  const HomeSlider({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            child: PageView.builder(
      controller: controller.pageController,
      onPageChanged: (value) {
        controller.onPageChanged(value);
      },
      itemCount: homeSliderList.length,
      itemBuilder: (context, index) {
        return Container(
          margin: const EdgeInsets.only(
            top: 10,
          ),
          decoration: BoxDecoration(
            color: Colors.grey,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Image.asset(
            homeSliderList[index].image!,
            fit: BoxFit.fill,
          ),
        );
      },
    )));
  }
}
