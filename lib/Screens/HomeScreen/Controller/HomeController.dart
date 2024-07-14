import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../Utils/DBHelper/CategoryDatabase.dart';
import '../../CategoryAddScreen/View/CategoryAddPage.dart';
import '../../QuotesAddScreen/Model/CategoryModel.dart';
import '../../QuotesAddScreen/View/QuotesAddPage.dart';

class HomeController extends GetxController {
  RxInt index = 0.obs;
  RxInt Tabindex = 0.obs;
  RxList CarouselList = [
    {
      'image': "assets/images/blanks.jpg",
      "quotes":
          "The greatest glory in living lies not in never falling, but in rising every time we fall. -Nelson Mandela",
    },
    {
      'image': "assets/images/blu.jpg",
      "quotes":
          "The way to get started is to quit talking and begin doing. -Walt Disney",
    },
    {
      'image': "assets/images/pink_sky.jpg",
      "quotes":
          "If life were predictable it would cease to be life, and be without flavor. -Eleanor Roosevelt",
    },
    {
      'image': "assets/images/pngtree.jpg",
      "quotes":
          "If you set your goals ridiculously high and it's a failure, you will fail above everyone else's success. -James Cameron",
    },
    {
      'image': "assets/images/empty.jpg",
      "quotes":
          "Life is what happens when you're busy making other plans. -John Lennon",
    },
    {
      'image': "assets/images/blur.jpg",
      "quotes":
          "Your time is limited, so don't waste it living someone else's life. Don't be trapped by dogma – which is living with the results of other people's thinking. -Steve Jobs",
    },
  ].obs;
  RxList PopularQuotes = [
    {
      'category': "Love",
      'image': "assets/images/love_quotes.jpg",
      'quotes': [
        "As he read, I fell in love the way you fall asleep: slowly, and then all at once",
        "Loved you yesterday, love you still, always have, always will",
        "I’ll be loving you, always with a love that’s true",
        "I need you like a heart needs a bea",
        "Take my hand, take my whole life too. For I can’t help falling in love with you",
        "There is never a time or place for true love. It happens accidentally, in a heartbeat, in a single flashing, throbbing moment",
      ],
    },
    {
      'category': "Swami Vivekananda",
      'image': "assets/images/swami_vivekananda_quotes.jpg",
      'quotes': [
        "In a conflict between the heart and the brain, follow your heart",
        "Do not wait for anybody or anything. Do whatever you can, build your hope on none",
        "Purity, patience, and perseverance are the three essentials to success and above all, love",
        "The more we come out and do good to others, the more our hearts will be purified, and God will be in them",
        "Comfort is no test of truth. Truth is often far from being comfortable",
        "The fire that warms us can also consume us; it is not the fault of the fire",
      ],
    },
    {
      'category': "Albert Einstein",
      'image': "assets/images/albert_einstein_quotes.jpg",
      'quotes': [
        "We cannot solve our problems with the same thinking we used when we created them",
        "The true sign of intelligence is not knowledge but imagination",
        "A person who never made a mistake never tried anything new",
        "The only source of knowledge is experience",
        "Education is what remains after one has forgotten what one has learned in school",
        "Pure mathematics is, in its way, the poetry of logical ideas",
      ],
    },
    {
      'category': "Motivational",
      'image': "assets/images/motivational_quotes.jpg",
      'quotes': [
        "You can get everything in life you want if you will just help enough other people get what they want",
        "Inspiration does exist, but it must find you working",
        "Show up, show up, show up, and after a while the muse shows up, too",
        "Don't bunt. Aim out of the ballpark. Aim for the company of immortals",
        "I have stood on a mountain of no’s for one yes",
        "If the highest aim of a captain were to preserve his ship, he would keep it in port forever",
      ],
    },
  ].obs;
  RxList AuthorQuotes = [
    {
      'category': "Albert Einstein",
      'image': "assets/images/albert_einstein2_quotes.jpg",
      'quotes': [
        "The difference between genius and stupidity is that genius has its limits",
        "A clever person solves a problem. A wise person avoids it",
        "Once you stop learning, you start dying",
        "The moon does not simply disappear when we are not looking at it",
        "Without deep reflection one knows from daily life that one exists for other people",
        "It has become appallingly obvious that our technology has exceeded our humanity",
      ],
    },
    {
      'category': "Swami Vivekananda",
      'image': "assets/images/swami_vivekananda2_quotes.jpg",
      'quotes': [
        "Be the servant while leading. Be unselfish. Have infinite patience, and success is yours",
        "Believe in yourself and the world will be at your feet",
        "Do one thing at a Time, and while doing it put your whole soul into it to the exclusion of all else",
        "If I love myself despite my infinite faults, how can I hate anyone at the glimpse of a few faults?",
        "Have faith in yourself – all power is in you. Even the poison of a snake is powerless, if you can firmly deny it",
        "Talk to yourself at least once in a day otherwise you may miss meeting an excellent person in this world",
      ],
    },
    {
      'category': "Helen Keller",
      'image': "assets/images/helen_quotes.jpg",
      'quotes': [
        "We are never really happy until we try to brighten the lives of others",
        "As selfishness and complaint pervert and cloud the mind, so sex with its joy clears and sharpens the vision",
        "Great poetry needs no interpreter other than a responsive heart",
        "There is no better way to thank God for your sight than by giving a helping hand to someone in the dark",
        "The most pathetic person in the world is someone who has sight but no vision",
        "The true test of a character is to face hard conditions with the determination to make them better",
      ],
    },
    {
      'category': "Dr. Seuss",
      'image': "assets/images/seuss_quotes.jpg",
      'quotes': [
        "To the world you may be one person but to one person you may be the world",
        "Simple it’s not, I am afraid you will find, for a mind-maker-upper to make up his mind",
        "You have brains in your head. You have feet in your shoes. You can steer yourself any direction you choose",
        "Things are never quite as scary when you’ve got a best friend",
        "You do not like them. So you say. Try them! Try them! And you may!",
        "They say I’m old-fashioned, and live in the past, but sometimes I think progress progresses too fast!",
      ],
    },
  ].obs;
  RxString imagePath = "".obs;
  Rx<GlobalKey<FormState>> key = GlobalKey<FormState>().obs;
  Rx<GlobalKey<FormState>> key2 = GlobalKey<FormState>().obs;
  Rx<TextEditingController> txtAddCategory = TextEditingController().obs;
  Rx<TextEditingController> txtUpdateCategory = TextEditingController().obs;
  Rx<TextEditingController> txtAddQuotes = TextEditingController().obs;
  Rx<TextEditingController> txtUpdateQuotes = TextEditingController().obs;
  RxString DropdownValue = "".obs;
  RxList<CategoryModel> CategoryList = <CategoryModel>[].obs;
  RxList ViewImageBackList = [
    "assets/images/bulb.png",
    "assets/images/trai.jpg",
    "assets/images/wallpaper.jpg",
    "assets/images/space.jpg",
    "assets/images/forest.jpg",
    "assets/images/space.jpg",
  ].obs;
  RxList ViewFontList = [
    GoogleFonts.lobster,
    GoogleFonts.rubikWetPaint,
    GoogleFonts.rampartOne,
    GoogleFonts.indieFlower,
    GoogleFonts.permanentMarker,
    GoogleFonts.caveatBrush,
  ].obs;
  RxInt FontIndex = 0.obs;
  RxInt ImageBackIndex = 0.obs;
  RxString QuotesData = "".obs;
  RxList QuotesList = [].obs;
  RxList QuotesIdList = [].obs;
  RxList Screens = [
    CategoryAddPage(),
    QuotesAddPage(),
  ].obs;
  RxString QuotesCategory = "".obs;
  RxInt CategoryId = 0.obs;
  RxInt QuoteId = 0.obs;
  RxInt check = 0.obs;
  RxInt check2 = 0.obs;
  RxInt Quotecheck = 0.obs;
  RxInt CateId = 0.obs;
  Rx<Uint8List> imagepath = Uint8List(0).obs;
  void GetData() async {
    bool Data = false;
    CategoryList.value = await CategoryDatabse.categoryDatabse.ReadDatabase();
    update();
  }

  void GetData2() async {
    // List DataList = await QuotesDatabase.quotesDatabase.ReadQuoteData();
    // QuotesList.clear();
    // for(int i=0; i<DataList.length; i++)
    //   {
    //     QuotesList.add(DataList[i]['quote']);
    //   }
    // update();
  }
}
