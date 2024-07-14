import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter/services.dart';
import 'package:share_plus/share_plus.dart';
import 'package:sizer/sizer.dart';

import '../../HomeScreen/Controller/HomeController.dart';

class QuotesViewPage extends StatefulWidget {
  const QuotesViewPage({Key? key}) : super(key: key);

  @override
  State<QuotesViewPage> createState() => _QuotesViewPageState();
}

class _QuotesViewPageState extends State<QuotesViewPage> {
  HomeController homeController = Get.put(HomeController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () => Stack(
          children: [
            Container(
              height: Get.height,
              width: Get.width,
              child: Image.asset(
                "${homeController.ViewImageBackList[homeController.ImageBackIndex.value]}",
                fit: BoxFit.fill,
              ),
            ),
            Align(
              alignment: Alignment.topCenter,
              child: Padding(
                padding: EdgeInsets.only(
                    right: Get.width / 21,
                    left: Get.width / 15,
                    top: Get.height / 3.5),
                child: Text(
                  "''  ${homeController.QuotesData}  ''",
                  style: homeController
                      .ViewFontList[homeController.FontIndex.value](
                    fontSize: 16.sp,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: Padding(
                padding: EdgeInsets.only(top: Get.height / 3),
                child: Text(
                  "- ${homeController.QuotesCategory} Quotes",
                  style: homeController
                      .ViewFontList[homeController.FontIndex.value](
                    fontSize: 16.sp,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: EdgeInsets.only(bottom: Get.height / 6),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    IconButton(
                      onPressed: () {
                        if (homeController.ImageBackIndex.value == 5) {
                          homeController.ImageBackIndex.value = 0;
                        } else {
                          homeController.ImageBackIndex.value++;
                        }
                      },
                      icon: Icon(
                        Icons.image,
                        color: Colors.white,
                        size: 21.sp,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        if (homeController.FontIndex.value == 5) {
                          homeController.FontIndex.value = 0;
                        } else {
                          homeController.FontIndex.value++;
                        }
                      },
                      icon: Icon(
                        Icons.hdr_auto_rounded,
                        color: Colors.white,
                        size: 21.sp,
                      ),
                    ),
                    IconButton(
                      onPressed: () async {
                        await Clipboard.setData(ClipboardData(
                            text: "${homeController.QuotesData}"));
                        Get.snackbar('Thank You', "This Quotes Is Copied");
                      },
                      icon: Icon(
                        Icons.copy,
                        color: Colors.white,
                        size: 21.sp,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        Share.share("${homeController.QuotesData}");
                      },
                      icon: Icon(
                        Icons.share,
                        color: Colors.white,
                        size: 21.sp,
                      ),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.star,
                        color: Colors.white,
                        size: 21.sp,
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
