import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import 'Screens/AllQuotesScreen/View/AllQuotesPage.dart';
import 'Screens/HomeScreen/View/HomePage.dart';
import 'Screens/QuetosViewScreen/View/QuotesViewPage.dart';
import 'Screens/QuotesAddScreen/View/QuotesAddPage.dart';
import 'Screens/SeeAllQuotesScreen/View/SeeAllQuotesPage.dart';
import 'Screens/TabBarScreen/View/TabBarPage.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(
    Sizer(
      builder: (context, orientation, deviceType) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          routes: {
            '/': (context) => HomePage(),
            'Tab': (context) => TabBarPage(),
            'Add': (context) => QuotesAddPage(),
            'SeeAll': (context) => SeeAllQuotesPage(),
            'View': (context) => QuotesViewPage(),
            'AllQ': (context) => AllQuotesPage(),
          },
        );
      },
    ),
  );
}
