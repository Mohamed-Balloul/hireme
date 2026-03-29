import 'package:hireme/controller/mywishlist/mywishlist_controller.dart';
import 'package:hireme/core/constant/color.dart';
import 'package:hireme/data/datasource/static/static.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyWishListGrid extends StatelessWidget {
  const MyWishListGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MyWishListControllerImp>(
      builder: (controller) => GridView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: myWishListGridList.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            mainAxisSpacing: 0,
            crossAxisSpacing: 12,
            crossAxisCount: 2,
            childAspectRatio: 0.8),
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              // controller.goToProductDetails();
            },
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Stack(children: [
                      Container(
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
                            myWishListGridList[index].image!,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Positioned(
                        top: 10,
                        right: 10,
                        child: Container(
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                              color: Color.fromARGB(180, 237, 237, 237),
                              // color: Colors.green,
                              borderRadius: BorderRadius.circular(20)),
                          child: Icon(
                            Icons.favorite_rounded,
                            size: 22,
                            color: AppColor.primaryColor,
                          ),
                        ),
                      ),
                    ]),
                  ),
                  // Center(
                  //   child: Container(
                  //     decoration: BoxDecoration(
                  //       color: Colors.grey,
                  //       border: Border.all(
                  //         color: AppColor.primaryColor,
                  //         width: 2,
                  //       ),
                  //       borderRadius: BorderRadius.circular(10),
                  //     ),
                  //     child: ClipRRect(
                  //       borderRadius: BorderRadius.circular(10),
                  //       child: Image.asset(
                  //         width: 150,
                  //         height: 150,
                  //         myWishListGridList[index].image!,
                  //         fit: BoxFit.cover,
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  Container(
                    margin: EdgeInsets.only(
                      left: 5,
                    ),
                    child: Text(
                      myWishListGridList[index].label!,
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                      left: 5,
                    ),
                    child: Text(
                      myWishListGridList[index].price!,
                      style: TextStyle(
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
