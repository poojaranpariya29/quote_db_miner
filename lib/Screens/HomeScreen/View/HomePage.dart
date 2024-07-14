import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
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
import '../Controller/HomeController.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  HomeController homeController = Get.put(HomeController());

  @override
  void initState() {
    super.initState();
    homeController.GetData();
  }

  @override
  Widget build(BuildContext context) {
    homeController.GetData();
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey.shade100,
        appBar: AppBar(
          backgroundColor: Colors.grey.shade100,
          elevation: 0,
          title: Text(
            "Amazing Quotes",
            style: GoogleFonts.lobster(color: Colors.black),
          ),
          centerTitle: true,
          actions: [
            Padding(
              padding: EdgeInsets.only(right: Get.width / 60),
              child: IconButton(
                  onPressed: () {
                    homeController.imagePath.value = "";
                    homeController.txtAddCategory.value.clear();
                    homeController.txtAddQuotes.value.clear();
                    if(homeController.CategoryList.isNotEmpty)
                    {
                      homeController.DropdownValue.value = homeController.CategoryList[0].Category!;
                    }
                    homeController.check.value = 0;
                    homeController.Quotecheck.value = 0;
                    homeController.Tabindex.value = 0;

                    Get.toNamed('Tab');
                  },
                  icon: Icon(
                    Icons.add,
                    color: Colors.black,
                  )),
            )
          ],
        ),
        body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            children: [
              Container(
                height: Get.height / 18,
                width: Get.width,
                decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(30)),
                margin: EdgeInsets.only(left: Get.width / 21, right: Get.width / 21),
                padding: EdgeInsets.only(right: Get.width / 21),
                child: TextField(
                  style: GoogleFonts.lobster(),
                  cursorColor: Colors.black,
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Search Quotes",
                      prefixIcon: Icon(Icons.search),
                      prefixIconColor: Colors.black,
                      hintStyle: GoogleFonts.lobster()),
                ),
              ),
              Container(
                height: Get.height / 4,
                //width: Get.width,
                margin: EdgeInsets.symmetric(vertical: Get.width/60),
                child: Stack(
                  children: [
                    // Align(
                    //   alignment: Alignment.center,
                    //   child: CarouselSlider(
                    //     items: [
                    //         Container(
                    //           height: Get.height/4,
                    //           width: Get.width/1.12,
                    //           margin: EdgeInsets.only(top: Get.height/60),
                    //           decoration: BoxDecoration(
                    //               color: Colors.red,
                    //               borderRadius: BorderRadius.circular(15)
                    //           ),
                    //         ),
                    //         Container(
                    //           height: Get.height/4,
                    //           width: Get.width/1.12,
                    //           margin: EdgeInsets.only(top: Get.height/60),
                    //           decoration: BoxDecoration(
                    //               color: Colors.pink,
                    //               borderRadius: BorderRadius.circular(15)
                    //           ),
                    //         ),
                    //         Container(
                    //       height: Get.height/4,
                    //       width: Get.width/1.12,
                    //       margin: EdgeInsets.only(top: Get.height/60),
                    //       decoration: BoxDecoration(
                    //           color: Colors.yellow,
                    //           borderRadius: BorderRadius.circular(15)
                    //       ),
                    //     ),
                    //     ],
                    //     options: CarouselOptions(
                    //
                    //       // aspectRatio: 0,
                    //       enlargeCenterPage: true,
                    //       // animateToClosest: true,
                    //       autoPlayInterval: Duration(seconds: 2),
                    //         autoPlay: true,
                    //     ),
                    //   ),
                    // ),
                    CarouselSlider.builder(
                      itemCount: homeController.CarouselList.length,
                      itemBuilder: (context, index, realIndex) {
                        return InkWell(
                          onTap: () {
                            homeController.QuotesCategory.value = "Motivational";
                            homeController.QuotesData.value = homeController.CarouselList[index]['quotes'];
                            Get.toNamed('View');
                          },
                          child: Stack(
                            children: [
                              Container(
                                height: Get.height / 4,
                                width: Get.width / 1.12,
                                margin: EdgeInsets.only(top: Get.width / 50),
                                decoration: BoxDecoration(
                                  color: Colors.pink,
                                  borderRadius: BorderRadius.circular(15),
                                  boxShadow: [
                                     BoxShadow(
                                        color: Colors.black45,
                                        offset: Offset(0,0),
                                        blurRadius: 6
                                     )
                                  ]
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(15),
                                  child: Image.asset("${homeController.CarouselList[index]['image']}",fit: BoxFit.fill,),
                                ),
                              ),
                              Align(
                                alignment: Alignment.center,
                                child: Container(
                                  margin: EdgeInsets.only(left: Get.width/30,right: Get.width/30,top: Get.height/9),
                                  child: Text(
                                    "${homeController.CarouselList[index]['quotes']}",
                                    maxLines: 2,
                                    style: GoogleFonts.lobster(
                                      fontSize: 15.sp,
                                      color: Colors.white,
                                      textStyle: TextStyle(overflow: TextOverflow.ellipsis)
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        );
                      },
                      options: CarouselOptions(
                        onPageChanged: (index, reason) {
                          homeController.index.value = index;
                        },
                        // aspectRatio: 0,
                        enlargeCenterPage: true,
                        // animateToClosest: true,
                        autoPlayInterval: Duration(seconds: 3),
                        autoPlay: true,
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Obx(
                        () => Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: homeController.CarouselList.asMap()
                                .entries
                                .map(
                                  (e) => Container(
                                    height: homeController.index.value == e.key
                                        ? Get.height / 80
                                        : Get.height / 100,
                                    width: homeController.index.value == e.key
                                        ? Get.height / 80
                                        : Get.height / 100,
                                    margin: EdgeInsets.only(
                                        bottom: Get.height / 60,
                                        left: Get.width / 50),
                                    decoration: BoxDecoration(
                                        color: homeController.index.value == e.key
                                            ? Colors.white
                                            : Colors.grey,
                                        shape: BoxShape.circle),
                                  ),
                                )
                                .toList()),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                height: Get.height/2.4,
                width: Get.width,
                margin: EdgeInsets.all(Get.width/50),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 6,
                      offset: Offset(0,0),
                      color: Colors.grey
                    )
                  ]
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: Get.height/60,left: Get.width/15),
                      child: Align(alignment: Alignment.topLeft,child: Text("Popular Category",style: GoogleFonts.lobster(color: Colors.black,fontSize: 15.sp),)),
                    ),
                    Container(
                      height: Get.height/2.8,
                      width: Get.width,
                      // color: Colors.red,
                      child: Padding(
                        padding: EdgeInsets.only(top: Get.height/60,right: Get.width/60,left: Get.width/60),
                        child: Obx(
                              () => GridView.builder(
                            itemCount: homeController.PopularQuotes.length,
                            physics: BouncingScrollPhysics(),
                            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,crossAxisSpacing: Get.width/70,mainAxisSpacing: Get.width/70,mainAxisExtent: Get.height/6),
                            itemBuilder: (context, index) {
                              return InkWell(
                                onTap: () {
                                  // homeController.QuotesList.clear();
                                  List dataList = homeController.PopularQuotes[index]['quotes'];
                                  print("=============$index LISTTTT $dataList");
                                  homeController.QuotesList.value = dataList;
                                  homeController.QuotesCategory.value = homeController.PopularQuotes[index]['category'];
                                  Get.toNamed('AllQ');
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: Colors.red,
                                      borderRadius: BorderRadius.circular(15),
                                      boxShadow: [
                                        BoxShadow(
                                            color: Colors.black45,
                                            offset: Offset(0,0),
                                            blurRadius: 5
                                        )
                                      ]
                                  ),
                                  // alignment: Alignment.center,
                                  child: Stack(
                                    children: [
                                      Container(
                                        height: Get.height,
                                        width: Get.width,
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(15),
                                          child: Image.asset(homeController.PopularQuotes[index]['image'],fit: BoxFit.fill,),
                                        ),
                                      ),
                                      Align(
                                        alignment: Alignment.center,
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(horizontal: Get.width/60),
                                          child: Text(
                                            "${homeController.PopularQuotes[index]['category']} Quotes",
                                            maxLines: 3,
                                            style: GoogleFonts.lobster(
                                                color: Colors.white,
                                                fontSize: 15.sp,
                                                textStyle: TextStyle(overflow: TextOverflow.ellipsis)
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Obx(() => homeController.CategoryList.isEmpty
                  ? Center(
                    child: Container(
                      height: Get.height/9,
                      width: Get.width,
                      margin: EdgeInsets.all(Get.width/50),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15),
                          boxShadow: [
                            BoxShadow(
                                blurRadius: 6,
                                offset: Offset(0,0),
                                color: Colors.grey
                            )
                          ]
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        "Please Add Category",
                        style: GoogleFonts.lobster(
                            color: Colors.black,
                            fontSize: 15.sp
                        ),
                      ),
                    ),
                  )
                  : Container(
                      height: Get.height/4,
                      width: Get.width,
                      margin: EdgeInsets.all(Get.width/50),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15),
                          boxShadow: [
                            BoxShadow(
                                blurRadius: 6,
                                offset: Offset(0,0),
                                color: Colors.grey
                            )
                          ]
                      ),
                      child: Column(
                        children: [
                          ListTile(
                            leading: Text("Quotes Category",style: GoogleFonts.lobster(color: Colors.black,fontSize: 15.sp),),
                            trailing: InkWell(onTap: (){
                              Get.toNamed('SeeAll');
                            },child: Text("See All",style: GoogleFonts.lobster(color: Colors.grey,fontSize: 15.sp),)),
                          ),
                          Container(
                            height: Get.height/6,
                            width: Get.width,
                            // color: Colors.red,
                            child: Padding(
                              padding: EdgeInsets.only(right: Get.width/60,left: Get.width/60),
                              child: Obx(
                                    () => GridView.builder(
                                  itemCount: homeController.CategoryList.length,
                                  scrollDirection: Axis.horizontal,
                                  physics: BouncingScrollPhysics(),
                                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 1,crossAxisSpacing: Get.width/70,mainAxisSpacing: Get.width/70,mainAxisExtent: Get.height/4.8),
                                  itemBuilder: (context, index) {
                                    return FocusedMenuHolder(
                                      menuItems: [
                                        FocusedMenuItem(title: const Text("Update"), onPressed: (){
                                          homeController.check.value = 1;
                                          homeController.Tabindex.value = 0;
                                          homeController.imagePath.value = "123";
                                          homeController.check2.value = 1;
                                          homeController.CateId.value = homeController.CategoryList[index].id!;
                                          homeController.txtUpdateCategory.value = TextEditingController(text: homeController.CategoryList[index].Category);
                                          homeController.imagepath.value = homeController.CategoryList[index].image!;
                                          print("=========== ${homeController.imagepath.value}");
                                          Get.toNamed('Tab');
                                          // // Uint8List image = homeController.CategoryList[index].image!;
                                          // File image = File.fromRawPath(homeController.CategoryList[index].image!);
                                          // homeController.imagePath.value = image.path;
                                        }),
                                        FocusedMenuItem(title: const Text("Delete"), onPressed: () async {
                                          homeController.CategoryId.value = homeController.CategoryList[index].id!;
                                          List DataList = await QuotesDatabase.quotesDatabase.ReadQuoteData();
                                          homeController.QuotesList.clear();
                                          for(int i=0; i<DataList.length; i++)
                                          {
                                            if(DataList[i]['category_id'] == homeController.CategoryId.value)
                                            {
                                              // homeController.QuotesList.add(DataList[i]['quote']);
                                              print("========== ${DataList[i]['category_id']}");
                                              QuotesDatabase.quotesDatabase.DeleteQuoteData(id: DataList[i]['category_id']);
                                            }
                                          }
                                          CategoryDatabse.categoryDatabse.DeleteDatabase(id: homeController.CategoryList[index].id!);
                                          ToastMessage(msg: "Your Category Is Delete Successfully", color: Colors.red);
                                          homeController.GetData();
                                          homeController.GetData2();
                                        }),
                                      ],
                                      child: InkWell(
                                        onTap: () async {
                                          // homeController.GetData2();
                                          homeController.CategoryId.value = homeController.CategoryList[index].id!;
                                          List DataList = await QuotesDatabase.quotesDatabase.ReadQuoteData();
                                          homeController.QuotesList.clear();
                                          homeController.QuotesIdList.clear();
                                          for(int i=0; i<DataList.length; i++)
                                          {
                                            if(DataList[i]['category_id'] == homeController.CategoryId.value)
                                            {
                                              homeController.QuotesList.add(DataList[i]['quote']);
                                              homeController.QuotesIdList.add(DataList[i]['id']);
                                            }
                                          }
                                          print("======== ccgfd ${homeController.QuotesIdList}");
                                          // homeController.QuotesList.value = homeController.CategoryList[index].c;
                                          homeController.QuotesCategory.value = homeController.CategoryList[index].Category!;
                                          Get.toNamed('AllQ');
                                        },
                                        child: Container(
                                          decoration: BoxDecoration(
                                              color: Colors.red,
                                              borderRadius: BorderRadius.circular(15),
                                              boxShadow: [
                                                BoxShadow(
                                                    color: Colors.black45,
                                                    offset: Offset(0,0),
                                                    blurRadius: 5
                                                )
                                              ]
                                          ),
                                          // alignment: Alignment.center,
                                          child: Stack(
                                            children: [
                                              Container(
                                                height: Get.height,
                                                width: Get.width,
                                                child: ClipRRect(
                                                  borderRadius: BorderRadius.circular(15),
                                                  child: Image.memory(homeController.CategoryList[index].image!,fit: BoxFit.fill,),
                                                ),
                                              ),
                                              Align(
                                                alignment: Alignment.center,
                                                child: Padding(
                                                  padding: EdgeInsets.symmetric(horizontal: Get.width/60),
                                                  child: Text(
                                                    "${homeController.CategoryList[index].Category!} Quotes",
                                                    maxLines: 3,
                                                    style: GoogleFonts.lobster(
                                                        color: Colors.white,
                                                        fontSize: 15.sp,
                                                        textStyle: TextStyle(overflow: TextOverflow.ellipsis)
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      onPressed: (){},
                                    );
                                  },
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),),
              Container(
                height: Get.height/2.4,
                width: Get.width,
                margin: EdgeInsets.only(top: Get.width/50,left: Get.width/50,right: Get.width/50,bottom: Get.width/50),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                          blurRadius: 6,
                          offset: Offset(0,0),
                          color: Colors.grey
                      )
                    ]
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: Get.height/90,left: Get.width/15),
                      child: Align(alignment: Alignment.topLeft,child: Text("Quotes By Author",style: GoogleFonts.lobster(color: Colors.black,fontSize: 15.sp),)),
                    ),
                    Container(
                      height: Get.height/2.8,
                      width: Get.width,
                      // color: Colors.red,
                      child: Padding(
                        padding: EdgeInsets.only(top: Get.height/60,right: Get.width/60,left: Get.width/60),
                        child: Obx(
                              () => GridView.builder(
                            itemCount: homeController.AuthorQuotes.length,
                            physics: BouncingScrollPhysics(),
                            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,crossAxisSpacing: Get.width/70,mainAxisSpacing: Get.width/70,mainAxisExtent: Get.height/6),
                            itemBuilder: (context, index) {
                              return InkWell(
                                onTap: () {
                                  homeController.QuotesCategory.value = homeController.AuthorQuotes[index]['category'];
                                  // homeController.QuotesList.clear();
                                  homeController.QuotesList.value = homeController.AuthorQuotes[index]['quotes'];
                                  Get.toNamed('AllQ');
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: Colors.red,
                                      borderRadius: BorderRadius.circular(15),
                                      boxShadow: [
                                        BoxShadow(
                                            color: Colors.black45,
                                            offset: Offset(0,0),
                                            blurRadius: 5
                                        )
                                      ]
                                  ),
                                  // alignment: Alignment.center,
                                  child: Stack(
                                    children: [
                                      Container(
                                        height: Get.height,
                                        width: Get.width,
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(15),
                                          child: Image.asset(homeController.AuthorQuotes[index]['image'],fit: BoxFit.fill,),
                                        ),
                                      ),
                                      Align(
                                        alignment: Alignment.center,
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(horizontal: Get.width/60),
                                          child: Text(
                                            "${homeController.AuthorQuotes[index]['category']} Quotes",
                                            maxLines: 3,
                                            style: GoogleFonts.lobster(
                                                color: Colors.white,
                                                fontSize: 15.sp,
                                                textStyle: TextStyle(overflow: TextOverflow.ellipsis)
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
