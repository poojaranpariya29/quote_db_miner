import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

import '../../../Utils/DBHelper/QuotesDatabase.dart';
import '../../../Utils/ToastMessage.dart';
import '../../HomeScreen/Controller/HomeController.dart';

class QuotesAddPage extends StatefulWidget {
  const QuotesAddPage({Key? key}) : super(key: key);

  @override
  State<QuotesAddPage> createState() => _QuotesAddPageState();
}

class _QuotesAddPageState extends State<QuotesAddPage> {
  HomeController homeController = Get.put(HomeController());

  @override
  void initState() {
    super.initState();
    homeController.Quotecheck.value == 0
        ? homeController.CategoryId.value = 0
        : "";
    homeController.GetData();
    homeController.GetData2();

    homeController.Quotecheck.value == 0
        ? homeController.CategoryList.isNotEmpty
            ? homeController.DropdownValue.value =
                homeController.CategoryList[0].Category!
            : ""
        : "";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Form(
          key: homeController.key2.value,
          child: Obx(
            () => homeController.CategoryList.isEmpty
                ? Center(
                    child: Text(
                    "Please Add Category",
                    style: GoogleFonts.lobster(
                        color: Colors.black, fontSize: 15.sp),
                  ))
                : Column(
                    children: [
                      Container(
                        height: Get.height / 18,
                        width: Get.width,
                        decoration: BoxDecoration(
                            color: Colors.grey.shade300,
                            borderRadius: BorderRadius.circular(30)),
                        margin: EdgeInsets.only(
                            left: Get.width / 21,
                            right: Get.width / 21,
                            top: Get.height / 90),
                        padding: EdgeInsets.only(left: Get.width / 21),
                        child: TextFormField(
                          controller: homeController.Quotecheck.value == 0
                              ? homeController.txtAddQuotes.value
                              : homeController.txtUpdateQuotes.value,
                          style: GoogleFonts.lobster(),
                          cursorColor: Colors.black,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "Add Quotes Required*",
                            // prefix: Container(),
                            // prefixIconColor: Colors.black,
                            hintStyle: GoogleFonts.lobster(),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Required* Please Add This Value";
                            } else {
                              return null;
                            }
                          },
                        ),
                      ),
                      Container(
                        height: Get.height / 18,
                        width: Get.width,
                        decoration: BoxDecoration(
                            color: Colors.grey.shade300,
                            borderRadius: BorderRadius.circular(30)),
                        margin: EdgeInsets.only(
                            left: Get.width / 21,
                            right: Get.width / 21,
                            top: Get.height / 90),
                        padding:
                            EdgeInsets.symmetric(horizontal: Get.width / 21),
                        child: Obx(
                          () => DropdownButtonHideUnderline(
                            child: DropdownButton(
                              onChanged: (value) {
                                homeController.DropdownValue.value = value!;
                              },
                              items: homeController.CategoryList.asMap()
                                  .entries
                                  .map(
                                    (e) => DropdownMenuItem(
                                      child: Text(
                                        "${homeController.CategoryList[e.key].Category}",
                                        style: GoogleFonts.lobster(),
                                      ),
                                      value:
                                          "${homeController.CategoryList[e.key].Category}",
                                      onTap: () {
                                        print("==== ${e.key}");
                                        homeController.CategoryId.value = e.key;
                                        print(
                                            "==== ${homeController.CategoryId.value}   ${homeController.CategoryList[homeController.CategoryId.value].id}");
                                      },
                                    ),
                                  )
                                  .toList(),
                              value: homeController.DropdownValue.value,
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () async {
                          if (homeController.key2.value.currentState!
                              .validate()) {
                            if (homeController.Quotecheck.value == 0) {
                              print(
                                  "==== ${homeController.CategoryId.value}   ${homeController.CategoryList[homeController.CategoryId.value].id}");
                              QuotesDatabase.quotesDatabase.InsertQutesData(
                                  Quote: homeController.txtAddQuotes.value.text,
                                  Category_Id: homeController
                                      .CategoryList[
                                          homeController.CategoryId.value]
                                      .id!);
                              ToastMessage(
                                  msg: "Your Data Is Insert Successfully",
                                  color: Colors.green);
                            } else {
                              // print("====ELES ${homeController.CategoryId.value}   ${homeController.CategoryList[homeController.CategoryId.value].id}");
                              QuotesDatabase.quotesDatabase.UpdateQuoteData(
                                  id: homeController.QuoteId.value,
                                  Quote:
                                      homeController.txtUpdateQuotes.value.text,
                                  Category_Id: homeController.CategoryId.value);
                              ToastMessage(
                                  msg: "Your Data Is Update Successfully",
                                  color: Colors.green);
                            }
                            List DataList = await QuotesDatabase.quotesDatabase
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
                            homeController.GetData();
                            Get.back();
                            homeController.txtAddQuotes.value.clear();
                            homeController.txtAddQuotes.value.clear();
                          } else {
                            ToastMessage(
                                msg: "Please Add Your Data", color: Colors.red);
                          }
                        },
                        child: Container(
                            height: Get.height / 18,
                            width: Get.width / 2.1,
                            decoration: BoxDecoration(
                                color: Colors.grey.shade300,
                                borderRadius: BorderRadius.circular(30)),
                            margin: EdgeInsets.only(
                                left: Get.width / 21,
                                right: Get.width / 21,
                                top: Get.height / 21),
                            alignment: Alignment.center,
                            child: Text(
                              "${homeController.Quotecheck.value == 0 ? "Add" : "Update"} Quotes",
                              style: GoogleFonts.lobster(
                                  fontSize: 15.sp, color: Colors.black),
                            )),
                      ),
                    ],
                  ),
          )),
    );
  }
}
