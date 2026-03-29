import 'package:hireme/controller/home/homepage_controller.dart';
import 'package:hireme/core/constant/color.dart';
import 'package:hireme/view/widget/home/categoryiconwithlabel.dart';
import 'package:hireme/view/widget/home/dotcontroller.dart';
import 'package:hireme/view/widget/home/flashsalecategor.dart';
import 'package:hireme/view/widget/home/homegridflashsales.dart';
import 'package:hireme/view/widget/home/homeslider.dart';
import 'package:hireme/view/widget/customtextformwithoutlablel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(HomePageControllerImp());
    return SafeArea(
      child: Scaffold(
        body: Container(
          padding: EdgeInsets.all(15),
          child: ListView(
            // physics: NeverScrollableScrollPhysics(),
            // shrinkWrap: true,
            // child: Column(
            // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              //--  Location
              Padding(
                padding: const EdgeInsets.only(
                  left: 5,
                ),
                child: Text(
                  "Location",
                  style: TextStyle(
                    color: AppColor.grey,
                    fontSize: 11,
                  ),
                ),
              ),
              //--
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.location_on,
                        color: AppColor.primaryColor,
                      ),
                      Text(
                        "New York, USA",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      InkWell(
                          onTap: () {},
                          child: Icon(Icons.keyboard_arrow_down_rounded)),
                    ],
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[400],
                      borderRadius: BorderRadius.circular(30),
                    ),
                    width: 30,
                    height: 30,
                    child:
                        InkWell(onTap: () {}, child: Icon(Icons.notifications)),
                  )
                ],
              ),
              Container(
                padding: EdgeInsets.only(
                  top: 15,
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 40,
                        child: CustomTextFormWithoutLablel(
                          hintText: "search",
                          iconData: Icons.search,
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                        left: 10,
                      ),
                      decoration: BoxDecoration(
                        color: AppColor.primaryColor,
                        borderRadius: BorderRadius.circular(7),
                      ),
                      width: 40,
                      height: 40,
                      child: InkWell(
                          onTap: () {},
                          child: Icon(
                            Icons.tune_outlined,
                            color: Colors.white,
                          )),
                    )
                  ],
                ),
              ),
              //-- the slider
              Container(
                margin: EdgeInsets.only(
                  top: 20,
                  bottom: 5,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    width: 1,
                    color: AppColor.primaryColor,
                  ),
                ),
                height: 135,
                child: HomeSlider(),
              ),
              Container(
                  margin: EdgeInsets.only(
                    bottom: 15,
                  ),
                  child: CustomDotControllerHomePage()),

              //-- row for categories and see all
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () {},
                    child: Text(
                      "Category",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {},
                    child: Text("See All"),
                  ),
                ],
              ),
              //-- row for categories icons with label
              Container(
                  margin: EdgeInsets.only(
                    top: 7,
                    bottom: 15,
                  ),
                  child: HomeCategoriesWithLabel()),
              //--flash sale with counter
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () {},
                    child: Text(
                      "Flash Sale",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {},
                    child: Text("Closing in :"),
                  ),
                ],
              ),
              //--single child scrol view

              Container(
                margin: EdgeInsets.only(
                  top: 6,
                  bottom: 12,
                ),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: FlashSaleCategory(),
                ),
              ),
              HomeGridFlashSales(),
            ],
          ),
        ),
      ),
    );
  }
}
