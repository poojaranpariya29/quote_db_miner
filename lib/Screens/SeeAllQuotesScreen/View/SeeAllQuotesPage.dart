import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:focused_menu/focused_menu.dart';
import 'package:focused_menu/modals.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

import '../../../Utils/DBHelper/CategoryDatabase.dart';
import '../../../Utils/DBHelper/QuotesDatabase.dart';
import '../../../Utils/ToastMessage.dart';
import '../../HomeScreen/Controller/HomeController.dart';

class SeeAllQuotesPage extends StatefulWidget {
  const SeeAllQuotesPage({Key? key}) : super(key: key);

  @override
  State<SeeAllQuotesPage> createState() => _SeeAllQuotesPageState();
}

class _SeeAllQuotesPageState extends State<SeeAllQuotesPage> {
  HomeController homeController = Get.put(HomeController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: Icon(
            Icons.arrow_back_ios_new,
            color: Colors.black,
          ),
        ),
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text(
          "All Category Quotes",
          style: GoogleFonts.lobster(color: Colors.black),
        ),
        centerTitle: true,
      ),
      backgroundColor: Colors.white,
      body: Obx(
        () => homeController.CategoryList.isNotEmpty
            ? ListView.builder(
                physics: BouncingScrollPhysics(),
                itemCount: homeController.CategoryList.length,
                itemBuilder: (context, index) {
                  return FocusedMenuHolder(
                    menuItems: [
                      FocusedMenuItem(
                          title: const Text("Update"),
                          onPressed: () {
                            homeController.check.value = 1;
                            homeController.imagePath.value = "fgdf";
                            homeController.check2.value = 1;
                            homeController.CateId.value =
                                homeController.CategoryList[index].id!;
                            homeController.txtUpdateCategory.value =
                                TextEditingController(
                                    text: homeController
                                        .CategoryList[index].Category);
                            homeController.imagepath.value =
                                homeController.CategoryList[index].image!;
                            print(
                                "=========== ${homeController.imagepath.value}");
                            Get.toNamed('Tab');
                            // // Uint8List image = homeController.CategoryList[index].image!;
                            // File image = File.fromRawPath(homeController.CategoryList[index].image!);
                            // homeController.imagePath.value = image.path;
                          }),
                      FocusedMenuItem(
                          title: const Text("Delete"),
                          onPressed: () async {
                            homeController.CategoryId.value =
                                homeController.CategoryList[index].id!;
                            List DataList = await QuotesDatabase.quotesDatabase
                                .ReadQuoteData();
                            homeController.QuotesList.clear();
                            for (int i = 0; i < DataList.length; i++) {
                              if (DataList[i]['category_id'] ==
                                  homeController.CategoryId.value) {
                                // homeController.QuotesList.add(DataList[i]['quote']);
                                print(
                                    "========== ${DataList[i]['category_id']}");
                                QuotesDatabase.quotesDatabase.DeleteQuoteData(
                                    id: DataList[index]['category_id']);
                              }
                            }
                            CategoryDatabse.categoryDatabse.DeleteDatabase(
                                id: homeController.CategoryList[index].id!);
                            homeController.GetData();
                            // homeController.GetData2();
                            ToastMessage(
                                msg: "Quote Is Delete Successfully",
                                color: Colors.blueAccent);
                          }),
                    ],
                    child: InkWell(
                      onTap: () async {
                        homeController.CategoryId.value =
                            homeController.CategoryList[index].id!;
                        List DataList =
                            await QuotesDatabase.quotesDatabase.ReadQuoteData();
                        homeController.QuotesList.clear();
                        for (int i = 0; i < DataList.length; i++) {
                          if (DataList[i]['category_id'] ==
                              homeController.CategoryId.value) {
                            homeController.QuotesList.add(DataList[i]['quote']);
                          }
                        }
                        // homeController.QuotesList.value = homeController.CategoryList[index].c;
                        homeController.QuotesCategory.value =
                            homeController.CategoryList[index].Category!;
                        Get.toNamed('AllQ');
                      },
                      child: Container(
                        height: Get.height / 3.6,
                        width: Get.width,
                        margin: EdgeInsets.all(Get.width / 30),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black54,
                                  offset: Offset(0, 0),
                                  blurRadius: 6)
                            ]),
                        child: Stack(
                          children: [
                            Align(
                              alignment: Alignment.center,
                              child: Container(
                                height: Get.height / 3.6,
                                width: Get.width,
                                child: ClipRRect(
                                    borderRadius: BorderRadius.circular(15),
                                    child: Image.memory(
                                      homeController.CategoryList[index].image!,
                                      fit: BoxFit.fill,
                                    )),
                              ),
                            ),
                            Align(
                              alignment: Alignment.center,
                              child: Text(
                                "${homeController.CategoryList[index].Category} Quotes",
                                style: GoogleFonts.lobster(
                                    color: Colors.white, fontSize: 30.sp),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    onPressed: () {},
                  );
                },
              )
            : Center(
                child: Text(
                  "Category Are Not Available",
                  style:
                      GoogleFonts.lobster(color: Colors.black, fontSize: 15.sp),
                ),
              ),
      ),
    );
  }
}
