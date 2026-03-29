// import 'package:hireme/data/datasource/static/static.dart';
import 'package:hireme/controller/mywishlist/mywishlist_controller.dart';
import 'package:hireme/view/widget/mywishlist/mywishlistcategor.dart';
import 'package:hireme/view/widget/mywishlist/mywishlistgrid.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyWishList extends StatelessWidget {
  // final HomeGridFlashSalesModel homeGridFlashSalesModel;
  const MyWishList({
    super.key,
    /*required this.homeGridFlashSalesModel*/
  });

  @override
  Widget build(BuildContext context) {
    MyWishListControllerImp controller = Get.put(MyWishListControllerImp());
    return SafeArea(
      child: Scaffold(
        body: ListView(
          children: [
            Text(
              "My Wishlist",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18,
              ),
            ),
            Container(
              margin: EdgeInsets.only(
                top: 20,
                left: 16,
              ),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: MyWishListCategory(),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: MyWishListGrid(),
            ),
          ],
        ),
      ),
    );
  }
}
