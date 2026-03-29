import 'package:hireme/core/constant/color.dart';
import 'package:flutter/material.dart';

class MyOrders extends StatelessWidget {
  const MyOrders({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text("My Orders"),
          bottom: TabBar(
              labelColor: AppColor.primaryColor,
              indicatorColor: AppColor.primaryColor,
              tabs: [
                Tab(
                  child: Text("Active"),
                ),
                Tab(
                  child: Text("Completed"),
                ),
                Tab(
                  child: Text("Cancelled"),
                ),
              ]),
        ),
        body: TabBarView(
          children: [
            Text("A"),
            Text("B"),
            Text("C"),
          ],
        ),
      ),
    ));
  }
}
