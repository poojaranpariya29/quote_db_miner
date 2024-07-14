import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:focused_menu/focused_menu.dart';
import 'package:focused_menu/modals.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

import '../../../Utils/DBHelper/QuotesDatabase.dart';
import '../../../Utils/ToastMessage.dart';
import '../../HomeScreen/Controller/HomeController.dart';

class AllQuotesPage extends StatefulWidget {
  const AllQuotesPage({Key? key}) : super(key: key);

  @override
  State<AllQuotesPage> createState() => _AllQuotesPageState();
}

class _AllQuotesPageState extends State<AllQuotesPage> {
  HomeController homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          leading: IconButton(
            onPressed: () => Get.back(),
            icon: Icon(
              Icons.arrow_back_ios_new,
              color: Colors.black,
            ),
          ),
          backgroundColor: Colors.white,
          title: Text(
            "${homeController.QuotesCategory.value} Quotes",
            style: GoogleFonts.lobster(color: Colors.black),
          ),
          centerTitle: true,
        ),
        backgroundColor: Colors.white,
        body: Obx(
          () => homeController.QuotesList.isNotEmpty
              ? ListView.builder(
                  physics: BouncingScrollPhysics(),
                  itemCount: homeController.QuotesList.length,
                  itemBuilder: (context, index) {
                    return FocusedMenuHolder(
                      menuItems: [
                        FocusedMenuItem(
                            title: Text("Update"),
                            onPressed: () {
                              homeController.Tabindex.value = 1;
                              homeController.Quotecheck.value = 1;
                              homeController.DropdownValue =
                                  homeController.QuotesCategory;
                              homeController.txtUpdateQuotes.value =
                                  TextEditingController(
                                      text: homeController.QuotesList[index]);
                              homeController.QuoteId.value =
                                  homeController.QuotesIdList[index];
                              print(
                                  "====== Drop ${homeController.DropdownValue.value} Id ${homeController.QuoteId.value} List = ${homeController.QuotesIdList[index]} Cateid = ${homeController.CategoryId}");
                              Get.toNamed('Tab');
                            }),
                        FocusedMenuItem(
                            title: Text("Delete"),
                            onPressed: () async {
                              QuotesDatabase.quotesDatabase.DeleteQuoteData(
                                  id: homeController.QuotesIdList[index]);
                              // homeController.CategoryId.value = homeController.CategoryList[index].id!;
                              List DataList = await QuotesDatabase
                                  .quotesDatabase
                                  .ReadQuoteData();
                              homeController.QuotesList.clear();
                              homeController.QuotesIdList.clear();
                              for (int i = 0; i < DataList.length; i++) {
                                if (DataList[i]['category_id'] ==
                                    homeController.CategoryId.value) {
                                  homeController.QuotesList.add(
                                      DataList[i]['quote']);
                                  homeController.QuotesIdList.add(
                                      DataList[i]['id']);
                                }
                              }
                              ToastMessage(
                                  msg: "Quote Is Delete Successfully",
                                  color: Colors.red);
                            })
                      ],
                      child: InkWell(
                        onTap: () {
                          // print("========= bdf ${homeController.QuotesIdList[index]}");
                          homeController.QuotesData.value =
                              homeController.QuotesList[index];
                          Get.toNamed('View');
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
                                alignment: Alignment.topCenter,
                                child: Padding(
                                  padding: EdgeInsets.only(
                                      left: Get.width / 21,
                                      right: Get.width / 21,
                                      top: Get.width / 10),
                                  child: Text(
                                    "${homeController.QuotesList[index]}",
                                    style: GoogleFonts.lobster(
                                        color: Colors.black, fontSize: 12.sp),
                                  ),
                                ),
                              ),
                              Align(
                                alignment: Alignment.bottomCenter,
                                child: Padding(
                                    padding: EdgeInsets.only(
                                      bottom: Get.width / 15,
                                      left: Get.width / 5,
                                      right: Get.width / 5,
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        IconButton(
                                          onPressed: () {
                                            ToastMessage(
                                                msg: "Quote Is Done",
                                                color: Colors
                                                    .deepOrangeAccent.shade100);
                                          },
                                          icon: Icon(
                                            Icons.done_all,
                                            color: Colors.black,
                                          ),
                                        ),
                                        IconButton(
                                          onPressed: () {
                                            ToastMessage(
                                                msg: "Quote Is Stared",
                                                color: Colors.yellowAccent);
                                          },
                                          icon: Icon(
                                            Icons.star,
                                            color: Colors.black,
                                          ),
                                        ),
                                        IconButton(
                                          onPressed: () async {
                                            await Clipboard.setData(ClipboardData(
                                                text:
                                                    "${homeController.QuotesList[index]}"));
                                            ToastMessage(
                                                msg: "Quote Is Copied",
                                                color: Colors.blueAccent);
                                          },
                                          icon: Icon(
                                            Icons.copy,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ],
                                    )),
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
                    "Quotes Are Not Available",
                    style: GoogleFonts.lobster(
                        color: Colors.black, fontSize: 15.sp),
                  ),
                ),
        ));
  }
}
