import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../CategoryAddScreen/View/CategoryAddPage.dart';
import '../../HomeScreen/Controller/HomeController.dart';
import '../../QuotesAddScreen/View/QuotesAddPage.dart';

class TabBarPage extends StatefulWidget {
  const TabBarPage({Key? key}) : super(key: key);

  @override
  State<TabBarPage> createState() => _TabBarPageState();
}

class _TabBarPageState extends State<TabBarPage> with TickerProviderStateMixin {
  HomeController homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () => Get.back(),
            icon: Icon(
              Icons.arrow_back_ios_new,
              color: Colors.black,
            ),
          ),
          actions: [
            Padding(
              padding: EdgeInsets.only(right: Get.width / 60),
              child: IconButton(
                onPressed: () {
                  homeController.imagePath.value = "";
                  homeController.txtAddCategory.value.clear();
                  homeController.txtAddQuotes.value.clear();
                  if (homeController.CategoryList.isNotEmpty) {
                    homeController.DropdownValue.value =
                        homeController.CategoryList[0].Category!;
                  }
                },
                icon: Icon(
                  Icons.refresh,
                  color: Colors.black,
                ),
              ),
            )
          ],
          backgroundColor: Colors.white,
          elevation: 0,
          title: Obx(() => Text(
                "Add Quotes ${homeController.Tabindex.value == 0 ? "Category" : ""}",
                style: GoogleFonts.lobster(color: Colors.black),
              )),
          centerTitle: true,
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(40),
            child: Obx(
              () => TabBar(
                controller: TabController(
                    length: 2,
                    vsync: this,
                    initialIndex: homeController.Tabindex.value),
                onTap: (value) {
                  homeController.Tabindex.value = value;
                  print("=========== $value");
                },
                indicatorColor: Colors.black,
                indicatorSize: TabBarIndicatorSize.label,
                labelStyle: GoogleFonts.lobster(),
                labelColor: Colors.black,
                unselectedLabelStyle: GoogleFonts.lobster(),
                unselectedLabelColor: Colors.grey,
                tabs: [
                  Tab(
                    text: "Add Quotes Category",
                  ),
                  Tab(
                    text: "Add Quotes",
                  ),
                ],
              ),
            ),
          ),
        ),
        body: Obx(
          () => TabBarView(
            physics: BouncingScrollPhysics(),
            controller: TabController(
              length: 2,
              vsync: this,
              initialIndex: homeController.Tabindex.value,
            ),
            children: [
              CategoryAddPage(),
              QuotesAddPage(),
            ],
          ),
        ),
      ),
    );
  }
}
