import 'package:hireme/controller/home/homepage_controller.dart';
import 'package:hireme/core/constant/color.dart';
import 'package:hireme/data/datasource/static/static.dart';
import 'package:hireme/data/model/homegridflashsalesmodel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeGridFlashSales extends StatelessWidget {
  const HomeGridFlashSales({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomePageControllerImp>(
      builder: (controller) => GridView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: homeGridFlashSalesList.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            mainAxisSpacing: 0,
            crossAxisSpacing: 12,
            crossAxisCount: 2,
            childAspectRatio: 0.8),
        itemBuilder: (context, index) {
          final HomeGridFlashSalesModel selectedProducnt =
              homeGridFlashSalesList[index];
          return InkWell(
            onTap: () {
              controller.goToProductDetails(selectedProducnt);
            },
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Container(
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
                          width: 150,
                          height: 150,
                          homeGridFlashSalesList[index].image!,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(
                      left: 5,
                    ),
                    child: Text(
                      homeGridFlashSalesList[index].label!,
                      style: const TextStyle(
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(
                      left: 5,
                    ),
                    child: Text(
                      homeGridFlashSalesList[index].price!,
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
