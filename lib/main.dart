import 'package:db_miner_quote/controller/home_controller.dart';
import 'package:db_miner_quote/view/details_screen.dart';
import 'package:db_miner_quote/view/home_screen.dart';
import 'package:db_miner_quote/view/like_category_screen.dart';
import 'package:db_miner_quote/view/like_screen.dart';
import 'package:db_miner_quote/view/quotes_detail_screen.dart';
import 'package:db_miner_quote/view/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  HomeController controller = Get.put(HomeController());
  controller.changeTheme();
  runApp(
    Obx(
      () => GetMaterialApp(
        debugShowCheckedModeBanner: false,
        routes: {
          "/": (context) => const SplashScreen(),
          "Home": (context) => const HomeScreen(),
          "detail": (context) => const DetailsScreen(),
          "quotes": (context) => const QuotesDetailsScreen(),
          "like": (context) => const LikeScreen(),
          "likec": (context) => const LikeCategoryScreen(),
        },
        theme: controller.isLight.value ? ThemeData.light() : ThemeData.dark(),
      ),
    ),
  );
}
