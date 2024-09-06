import 'package:flutter/material.dart';

import 'pages/Catagory_and_Author_page.dart';
import 'pages/HomePage.dart';
import 'pages/Splash_screen.dart';
import 'pages/details_page.dart';
import 'pages/quouts_page.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: 'splash_screen',
      routes: {
        'splash_screen': (context) => const SplashScreen(),
        '/': (context) => const HomePage(),
        'details_page': (context) => const DetailsPage(),
        'category_or_author_page': (context) => const CategoryOrAuthorPage(),
        'quotes_page': (context) => const QuotesPage(),
      },
    ),
  );
}
