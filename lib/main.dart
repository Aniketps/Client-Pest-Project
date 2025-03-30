import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rakshakpestcontroller/Components/Buttons.dart';
import 'package:rakshakpestcontroller/Login.dart';
import 'package:rakshakpestcontroller/Services/AboutBusiness.dart';
import 'package:url_launcher/url_launcher.dart';
import 'Components/InputField.dart';
import 'Services/BusinessServices.dart';
import 'Services/RatingAndReviews.dart';
import 'firebase_options.dart';

AboutBusiness business = AboutBusiness();
BusinessServices businessServices = BusinessServices();
RatingAndReviews ratingAndReviews = RatingAndReviews();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Initialize Firebase with the platform-specific options
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await business.fetchDataFromFirebase();
  await businessServices.fetchServices();
  await ratingAndReviews.fetchReviews();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const MyHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  Future<void> fetchData() async {
    AboutBusiness business = AboutBusiness();
    await business.fetchDataFromFirebase();
  }

  double getResposive(
      BuildContext context, double a, double b, double c, double d) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    bool isSmallMobile = screenWidth < 480;
    bool isMobile = screenWidth >= 480 && screenWidth < 768;
    bool isTablet = screenWidth >= 768 && screenWidth < 1024;

    return isSmallMobile
        ? a
        : isMobile
            ? b
            : isTablet
                ? c
                : d;
  }

  bool isSmallPhone() {
    final screenWidth = MediaQuery.of(context).size.width;
    return screenWidth < 480;
  }

  bool isPhone() {
    final screenWidth = MediaQuery.of(context).size.width;
    return screenWidth >= 480 && screenWidth < 768;
  }

  Container getContactIconWithName(Image image, String text) {
    return Container(
      height: 100,
      width: 100,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            image,
            SizedBox(
              height: 5,
            ),
            Text(text),
          ],
        ),
      ),
    );
  }

  void getAboutBusiness() {}

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    BoxShadow customerShadow() {
      return BoxShadow(
        color: Colors.blue.withOpacity(0.3),
        spreadRadius: 1.0,
        blurRadius: 2.0,
        offset: Offset(4, 4),
      );
    }

    PreferredSize customAppBar(BuildContext context) {
      return PreferredSize(
        preferredSize: Size.fromHeight(80),
        child: LayoutBuilder(
          builder: (context, constraints) {
            // Adjust sizes and padding based on breakpoints
            double logoSize = getResposive(context, 24, 30, 35, 40);

            double buttonWidth = getResposive(context, 130, 150, 180, 200);
            double buttonFontSize = getResposive(context, 14, 16, 18, 20);
            double padding = getResposive(context, 10, 20, 40, 50);

            bool isSmallMobile = screenWidth < 480;
            bool isMobile = screenWidth >= 480 && screenWidth < 768;
            bool isTablet = screenWidth >= 768 && screenWidth < 1024;

            return Container(
              height: (isPhone() || isSmallPhone()) ? 60 : 80,
              width: screenWidth,
              decoration: BoxDecoration(
                color: Colors.white,
                border:
                    Border(bottom: BorderSide(width: 0.3, color: Colors.black)),
              ),
              padding: EdgeInsets.symmetric(horizontal: padding),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Left Section: Logo + Location
                  Row(
                    children: [
                      Text(
                        "RPCAMS",
                        style: GoogleFonts.alkatra(fontSize: logoSize),
                      ),
                      SizedBox(width: 10),
                      if (!isSmallMobile &&
                          !isMobile) // Hide location on very small screens
                        Container(
                          height: 40,
                          padding: EdgeInsets.symmetric(horizontal: 12),
                          decoration: BoxDecoration(
                            color: Color(0xFFF4F0F0),
                            border: Border.all(width: 0.2, color: Colors.black),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Row(
                            children: [
                              Icon(Icons.location_on,
                                  color: Colors.green,
                                  size: isSmallMobile ? 16 : 20),
                              SizedBox(width: 5),
                              Text(
                                "Sambhaji Nagar, Loni Kalbhor",
                                style: GoogleFonts.sanchez(
                                    fontSize: isSmallMobile ? 12 : 14),
                              ),
                            ],
                          ),
                        ),
                    ],
                  ),

                  // Right Section: Sign In / Sign Up Button
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Login(),
                          ));
                    },
                    child: Container(
                      height: 50,
                      width: buttonWidth,
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 3, 1, 159),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      alignment: Alignment.center,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Sign In / Sign Up",
                          style: GoogleFonts.secularOne(
                              fontSize: buttonFontSize, color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      );
    }

    double horizontalPadding = getResposive(context, 0, 10, 25, 30);

    Container introSection() {
      double introSectionSizeHeight = getResposive(context, 300, 320, 220, 250);
      double introSectionSizeWidth = getResposive(context, screenWidth * 0.90,
          screenWidth * 0.9, screenWidth * 0.93, screenWidth * 0.95);
      double businessTitle = getResposive(context, 18, 25, 30, 35);

      return Container(
        height: introSectionSizeHeight,
        width: introSectionSizeWidth,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(5),
            border: (isPhone() || isSmallPhone())
                ? null
                : Border.all(width: 0.1, color: Colors.black),
            boxShadow: (isPhone() || isSmallPhone())
                ? null
                : [
                    BoxShadow(
                      color: Colors.blue,
                      blurRadius: 0.2,
                    )
                  ]),
        child: Padding(
          padding: (isPhone() || isSmallPhone())
              ? EdgeInsets.all(4.0)
              : EdgeInsets.all(15.0),
          child: Container(
            height: getResposive(context, 120, 120, 150, 200),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      business.businessname.toString(),
                      style: TextStyle(
                          fontSize: getResposive(context, 16, 18, 20, 22),
                          fontWeight: (isPhone() || isSmallPhone())
                              ? FontWeight.bold
                              : null),
                    ),
                    SizedBox(
                      height: getResposive(context, 5, 7, 9, 13),
                    ),
                    Row(
                      children: [
                        Container(
                          height: getResposive(context, 24, 30, 40, 40),
                          width: getResposive(context, 50, 60, 70, 70),
                          decoration: BoxDecoration(
                            color: Color(0xF9EA001C),
                            borderRadius: BorderRadius.circular(
                                getResposive(context, 2, 3, 4, 5)),
                          ),
                          child: Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  "4.7",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: getResposive(
                                          context, 16, 18, 20, 22)),
                                ),
                                Icon(
                                  Icons.star,
                                  size: getResposive(context, 18, 20, 22, 26),
                                  color: Colors.white,
                                )
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          "343 Ratings",
                          style: TextStyle(
                              fontSize: getResposive(context, 14, 16, 18, 20),
                              color: Colors.green),
                        )
                      ],
                    ),
                    SizedBox(
                      height: getResposive(context, 5, 7, 9, 13),
                    ),
                    (isPhone() || isSmallPhone())
                        ? Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  RichText(
                                    text: TextSpan(
                                      children: [
                                        TextSpan(
                                          text:
                                              business.shortAddress.length > 25
                                                  ? business.shortAddress
                                                          .substring(0, 25) +
                                                      '...'
                                                  : business.shortAddress,
                                          style: TextStyle(
                                              fontSize: 16,
                                              color: Colors.black),
                                        ),
                                        TextSpan(
                                          text: "\t\t\tOpen 24 Hrs",
                                          style: TextStyle(
                                              color: Colors.green,
                                              fontSize: 16),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: getResposive(context, 2, 3, 4, 5),
                              ),
                              RichText(
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text: "9 Years in Business",
                                      style: TextStyle(
                                          color: Colors.blue, fontSize: 16),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          )
                        : Row(
                            children: [
                              Icon(
                                Icons.location_on,
                                color: Colors.green,
                              ),
                              SizedBox(
                                width: getResposive(context, 2, 3, 4, 5),
                              ),
                              RichText(
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text: business.shortAddress,
                                      style: TextStyle(fontSize: 16),
                                    ),
                                    TextSpan(
                                      text:
                                          "\t\t\t${business.schedule.toString()}",
                                      style: TextStyle(
                                          color: Colors.green, fontSize: 16),
                                    ),
                                    TextSpan(
                                      text: "\t\t\t 9 Years in Business",
                                      style: TextStyle(
                                          color: Colors.blue, fontSize: 16),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                    SizedBox(
                      height: getResposive(context, 8, 7, 9, 13),
                    ),
                    (isPhone() || isSmallPhone())
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              InkWell(
                                onTap: (){},
                                child: getContactIconWithName(
                                    Image(
                                      image: AssetImage(
                                        "assets/icons/call.png",
                                      ),
                                      height:
                                      getResposive(context, 45, 47, 49, 51),
                                      width:
                                      getResposive(context, 45, 47, 49, 51),
                                    ),
                                    "Call Now"),
                              ),
                              InkWell(
                                onTap: (){},
                                child: getContactIconWithName(
                                    Image(
                                      image: AssetImage(
                                        "assets/icons/chat.png",
                                      ),
                                      height:
                                      getResposive(context, 45, 47, 49, 51),
                                      width:
                                      getResposive(context, 45, 47, 49, 51),
                                    ),
                                    "Enquire Now"),
                              ),
                              InkWell(

                                child: getContactIconWithName(
                                    Image(
                                      image: AssetImage(
                                        "assets/icons/whatsapp.png",
                                      ),
                                      height:
                                      getResposive(context, 45, 47, 49, 51),
                                      width:
                                      getResposive(context, 45, 47, 49, 51),
                                    ),
                                    "Whatsapp"),
                              ),
                            ],
                          )
                        : Row(
                            children: [
                              InkWell(
                                onTap: () {

                                },
                                child: CustomeButtons.getButton(
                                    getResposive(context, 20, 30, 40, 50),
                                    getResposive(context, 100, 120, 150, 180),
                                    Color(0xff71d000),
                                    Icons.call,
                                    5,
                                    Colors.white,
                                    "Show Number",
                                    Colors.white,
                                    getResposive(context, 12, 14, 16, 18)),
                              ),
                              SizedBox(
                                width: getResposive(context, 5, 10, 15, 20),
                              ),
                              InkWell(
                                onTap: (){},
                                  child: CustomeButtons.getButton(
                                      getResposive(context, 20, 30, 40, 50),
                                      getResposive(context, 100, 120, 150, 180),
                                      Color(0xff011ba1),
                                      Icons.chat,
                                      5,
                                      Colors.white,
                                      "Enquire Now",
                                      Colors.white,
                                      getResposive(context, 12, 14, 16, 18)),
                              ),
                              SizedBox(
                                width: getResposive(context, 5, 10, 15, 20),
                              ),
                              InkWell(
                                onTap: () async {
                                  final phoneNumber = business.contactNumber;
                                  final url = "https://wa.me/$phoneNumber";
                                  if (await canLaunch(url)) {
                                    await launch(url);
                                  } else {
                                    throw 'Could not launch $url';
                                  }
                                },
                                child: CustomeButtons.getButton1(
                                    context,
                                    getResposive(context, 20, 30, 40, 50),
                                    getResposive(context, 100, 120, 150, 180),
                                    Color(0xff3fff55),
                                    "assets/icons/whatsapp.png",
                                    5,
                                    Colors.black,
                                    "Whatsapp",
                                    Colors.black,
                                    getResposive(context, 12, 14, 16, 18)),
                              ),
                            ],
                          ),
                    SizedBox(
                      height: getResposive(context, 8, 7, 9, 13),
                    ),
                    isPhone() || isSmallPhone()
                        ? Container(
                            width: getResposive(
                                context,
                                screenWidth * 0.86,
                                screenWidth * 0.85,
                                screenWidth * 0.75,
                                screenWidth * 0.75),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  "Click To Rate",
                                  style: TextStyle(
                                      fontSize: getResposive(
                                          context, 16, 18, 20, 22)),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Icon(
                                      CupertinoIcons.star,
                                      size:
                                          getResposive(context, 34, 36, 30, 40),
                                    ),
                                    Icon(
                                      CupertinoIcons.star,
                                      size:
                                          getResposive(context, 34, 36, 30, 40),
                                    ),
                                    Icon(
                                      CupertinoIcons.star,
                                      size:
                                          getResposive(context, 34, 36, 30, 40),
                                    ),
                                    Icon(
                                      CupertinoIcons.star,
                                      size:
                                          getResposive(context, 34, 36, 30, 40),
                                    ),
                                    Icon(
                                      CupertinoIcons.star,
                                      size:
                                          getResposive(context, 34, 36, 30, 40),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          )
                        : SizedBox(),
                  ],
                ),
                !isPhone() && !isSmallPhone()
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            "Click To Rate",
                            style: TextStyle(
                                fontSize:
                                    getResposive(context, 16, 18, 20, 22)),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Icon(
                                CupertinoIcons.star,
                                size: getResposive(context, 34, 36, 30, 40),
                              ),
                              Icon(
                                CupertinoIcons.star,
                                size: getResposive(context, 34, 36, 30, 40),
                              ),
                              Icon(
                                CupertinoIcons.star,
                                size: getResposive(context, 34, 36, 30, 40),
                              ),
                              Icon(
                                CupertinoIcons.star,
                                size: getResposive(context, 34, 36, 30, 40),
                              ),
                              Icon(
                                CupertinoIcons.star,
                                size: getResposive(context, 34, 36, 30, 40),
                              ),
                            ],
                          )
                        ],
                      )
                    : SizedBox(), // Hide in mobile mode
              ],
            ),
          ),
        ),
      );
    }

    Container quickLinks() {
      return Container(
        width: screenWidth,
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              Container(
                child: Center(
                    child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Overview",
                    style: TextStyle(
                        fontSize: getResposive(context, 14, 16, 18, 20)),
                  ),
                )),
              ),
              SizedBox(
                width: 10,
              ),
              Container(
                child: Center(
                    child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Photos",
                    style: TextStyle(
                        fontSize: getResposive(context, 14, 16, 18, 20)),
                  ),
                )),
              ),
              SizedBox(
                width: 10,
              ),
              Container(
                child: Center(
                    child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Price List",
                    style: TextStyle(
                        fontSize: getResposive(context, 14, 16, 18, 20)),
                  ),
                )),
              ),
              SizedBox(
                width: 10,
              ),
              Container(
                child: Center(
                    child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Quick Info",
                    style: TextStyle(
                        fontSize: getResposive(context, 14, 16, 18, 20)),
                  ),
                )),
              ),
              SizedBox(
                width: 10,
              ),
              Container(
                child: Center(
                    child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Sevices",
                    style: TextStyle(
                        fontSize: getResposive(context, 14, 16, 18, 20)),
                  ),
                )),
              ),
            ],
          ),
        ),
      );
    }

    Container contactInfo() {
      return Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            border: Border.all(width: 0.5, color: Colors.blue),
            color: Colors.white,
            boxShadow: [customerShadow()]),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Contacts",
                style: TextStyle(
                    fontSize: getResposive(context, 16, 22, 24, 26),
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 5,
              ),
              InkWell(
                onTap: (){},
                child: CustomeButtons.getButton(
                    getResposive(context, 0, 34, 38, 40),
                    getResposive(context, 0, 150, 170, 180),
                    Colors.white,
                    Icons.call,
                    8,
                    Colors.blue,
                    "Show Number",
                    Colors.blue,
                    getResposive(context, 12, 14, 16, 18)),
              ),
              Divider(),
              Text(
                "Address",
                style: TextStyle(
                    fontSize: getResposive(context, 16, 22, 24, 26),
                    fontWeight: FontWeight.bold),
              ),
              Text(
                business.fullAddress,
                style:
                    TextStyle(fontSize: getResposive(context, 0, 14, 16, 18)),
              ),
              InkWell(
                onTap: () async {
                  final location = business.fullAddress;
                  final url = "https://www.google.com/maps/search/?q=$location"; // URL to search for the location
                  if (await canLaunch(url)) {
                  await launch(url); // Open Google Maps with the search query
                  } else {
                  throw 'Could not launch $url';
                  }
                },
                child: CustomeButtons.getButton(
                    getResposive(context, 0, 34, 38, 40),
                    getResposive(context, 0, 120, 170, 180),
                    Colors.white,
                    Icons.directions,
                    8,
                    Colors.blue,
                    "Get Direction",
                    Colors.blue,
                    getResposive(context, 12, 12, 16, 18)),
              ),
              CustomeButtons.getButton(
                  getResposive(context, 0, 34, 38, 40),
                  getResposive(context, 0, 125, 180, 195),
                  Colors.white,
                  Icons.watch_later,
                  8,
                  Colors.green,
                  "Open 24 Hours",
                  Colors.green,
                  getResposive(context, 12, 12, 16, 18)),
              InkWell(
                onTap: () async {

                },
                child: CustomeButtons.getButton(
                    getResposive(context, 0, 34, 38, 40),
                    getResposive(context, 0, 130, 245, 270),
                    Colors.white,
                    Icons.mail,
                    8,
                    Colors.black,
                    "Send Enquiry via Email",
                    Colors.black,
                    getResposive(context, 12, 8, 16, 18)),
              ),
              InkWell(
                onTap: (){},
                child: CustomeButtons.getButton(
                    getResposive(context, 0, 34, 38, 40),
                    getResposive(context, 0, 150, 206, 222),
                    Colors.white,
                    Icons.contact_mail,
                    8,
                    Colors.black,
                    "Get info via Email",
                    Colors.black,
                    getResposive(context, 12, 12, 16, 18)),
              ),
            ],
          ),
        ),
      );
    }

    Container photo() {
      return Container(
        height: getResposive(context, 130, 140, 280, 280),
        width: getResposive(context, 180, 180, 400, 400),
        decoration: BoxDecoration(
            borderRadius:
                BorderRadius.circular(getResposive(context, 2, 3, 4, 5)),
            color: Colors.white,
            boxShadow: [customerShadow()],
            border: Border.all(width: 0.2, color: Colors.blue)),
      );
    }

    Container photosSection() {
      return Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Photos",
              style: TextStyle(
                  fontSize: getResposive(context, 16, 22, 24, 26),
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 5,
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Padding(
                padding: const EdgeInsets.all(1),
                child: Row(
                  children: [
                    photo(),
                    SizedBox(
                      width: getResposive(context, 5, 8, 10, 15),
                    ),
                    photo(),
                    SizedBox(
                      width: getResposive(context, 5, 8, 10, 15),
                    ),
                    photo(),
                    SizedBox(
                      width: getResposive(context, 5, 8, 10, 15),
                    ),
                    photo(),
                  ],
                ),
              ),
            )
          ],
        ),
      );
    }

    Container serviceInfo(
        String title, String description, String rate, String type) {
      return Container(
        width: getResposive(context, 340, 280, 380, 450),
        decoration: BoxDecoration(
            border: Border.all(width: 0.2, color: Colors.blue),
            boxShadow: [customerShadow()],
            color: Colors.white,
            borderRadius:
                BorderRadius.circular(getResposive(context, 15, 15, 15, 8))),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              Row(
                children: [
                  Text(
                    title,
                    style: TextStyle(
                        fontSize: getResposive(context, 18, 18, 20, 24),
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              SizedBox(
                height: 8,
              ),
              Text(
                description.length > getResposive(context, 450, 400, 500, 520)
                    ? description.substring(0,
                            getResposive(context, 450, 400, 500, 520) as int?) +
                        '...'
                    : description,
                textAlign: TextAlign.justify,
                style:
                    TextStyle(fontSize: getResposive(context, 16, 14, 16, 18)),
              ),
              SizedBox(
                height: 8,
              ),
              Row(
                children: [
                  Text(
                    rate,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: getResposive(context, 16, 16, 18, 20)),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    type,
                    style: TextStyle(
                        fontSize: getResposive(context, 14, 12, 14, 16)),
                  ),
                ],
              ),
              SizedBox(
                height: 8,
              ),
              CustomeButtons.getButton(
                  getResposive(context, 38, 35, 40, 55),
                  getResposive(context, 180, 180, 200, 300),
                  Color(0xFF31AD01),
                  Icons.send,
                  8,
                  Colors.white,
                  "Enquire Now",
                  Colors.white,
                  14)
            ],
          ),
        ),
      );
    }

    Container priceListSection() {
      double value = getResposive(
          context,
          screenWidth - (2 * getResposive(context, 10, 0, 0, 10)),
          screenWidth * 0.6 - (2 * getResposive(context, 0, 8, 0, 10)),
          screenWidth * 0.6 - (2 * getResposive(context, 0, 0, 9, 10)),
          screenWidth * 0.65 - (2 * getResposive(context, 0, 0, 0, 10)));
      return Container(
        width: value,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Price List",
              style: TextStyle(
                  fontSize: getResposive(context, 16, 22, 24, 26),
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 5,
            ),
            Center(
              child: Wrap(
                spacing: getResposive(context, 0, 8, 8, 10),
                runSpacing: getResposive(context, 5, 8, 8, 10),
                alignment: WrapAlignment.center,
                runAlignment: WrapAlignment.center,
                children: businessServices.allServices.map<Widget>((service) {
                  return serviceInfo(service.name, service.description,
                      service.rate.toString(), service.type);
                }).toList(),
              ),
            )
          ],
        ),
      );
    }

    Row places(String title) {
      return Row(
        children: [
          Icon(
            Icons.check,
            size: getResposive(context, 18, 16, 18, 20),
          ),
          SizedBox(
            width: 5,
          ),
          Text(
            title,
            style: TextStyle(
                fontSize: getResposive(context, 12, 12, 12, 14),
                fontWeight: FontWeight.bold),
          )
        ],
      );
    }

    Container businessInfoSection() {
      return Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Quick Information",
              style: TextStyle(
                  fontSize: getResposive(context, 16, 22, 24, 26),
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              "Year of Estimated",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(business.registeredYear),
            places("Properties Served"),
            places("Residential, Commercial"),
          ],
        ),
      );
    }

    Container mainContents() {
      return Container(
        width: getResposive(
            context,
            screenWidth - (2 * getResposive(context, 10, 0, 0, 10)),
            screenWidth * 0.6 - (2 * getResposive(context, 0, 8, 0, 10)),
            screenWidth * 0.6 - (2 * getResposive(context, 0, 0, 9, 10)),
            screenWidth * 0.65 - (2 * getResposive(context, 0, 0, 0, 10))),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            border: Border.all(width: 0.5, color: Colors.blue),
            color: Colors.white,
            boxShadow: [customerShadow()]),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              photosSection(),
              SizedBox(
                height: 15,
              ),
              Divider(),
              SizedBox(
                height: 15,
              ),
              priceListSection(),
              SizedBox(
                height: 15,
              ),
              Divider(),
              SizedBox(
                height: 15,
              ),
              businessInfoSection(),
            ],
          ),
        ),
      );
    }

    Container commentSection(
        String name, String date, int star, String comment) {
      return Container(
        decoration: BoxDecoration(
            boxShadow: [customerShadow()],
            borderRadius: BorderRadius.circular(10),
            color: Colors.white),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(
                children: [
                  Container(
                    height: getResposive(context, 20, 20, 40, 50),
                    width: getResposive(context, 20, 20, 40, 50),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: Colors.white,
                      border: Border.all(width: 0.2, color: Colors.black),
                    ),
                    child: Center(child: Icon(CupertinoIcons.profile_circled)),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name.length > 15 ? '${name.substring(0, 15)}...' : name,
                        style: TextStyle(
                          fontSize: getResposive(context, 14, 10, 15, 18),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        date,
                        style: TextStyle(
                            fontSize: getResposive(context, 12, 8, 12, 14)),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: 5,
              ),
              SizedBox(
                height: 5,
              ),
              SizedBox(
                height: 5,
              ),
              Row(
                children: [
                  Icon(
                    Icons.star,
                    color: Colors.yellow,
                  ),
                  Icon(
                    Icons.star,
                    color: Colors.yellow,
                  ),
                  Icon(
                    Icons.star,
                    color: Colors.yellow,
                  ),
                  Icon(
                    Icons.star,
                    color: Colors.yellow,
                  ),
                  Icon(
                    Icons.star,
                    color: Colors.yellow,
                  ),
                ],
              ),
              SizedBox(
                height: 5,
              ),
              Text(comment),
              SizedBox(
                height: 5,
              ),
              Row(
                children: [
                  CustomeButtons.getButton1(
                      context,
                      getResposive(context, 20, 20, 30, 40),
                      getResposive(context, 60, 50, 70, 90),
                      Colors.white,
                      "assets/icons/like.png",
                      5,
                      Colors.black,
                      "HelpFul",
                      Colors.white,
                      getResposive(context, 8, 6, 8, 11)),
                  CustomeButtons.getButton1(
                      context,
                      getResposive(context, 20, 20, 30, 40),
                      getResposive(context, 80, 60, 70, 90),
                      Colors.white,
                      "assets/icons/comment.png",
                      5,
                      Colors.black,
                      "Comment",
                      Colors.white,
                      getResposive(context, 8, 6, 8, 10)),
                  isPhone()
                      ? Container()
                      : CustomeButtons.getButton1(
                          context,
                          getResposive(context, 0, 20, 30, 40),
                          getResposive(context, 0, 50, 70, 90),
                          Colors.white,
                          "assets/icons/sahre1.png",
                          5,
                          Colors.black,
                          "Share",
                          Colors.white,
                          getResposive(context, 8, 6, 8, 11))
                ],
              )
            ],
          ),
        ),
      );
    }

    Container reviewsAndRatings() {
      return Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            border: Border.all(width: 0.5, color: Colors.blue),
            color: Colors.white,
            boxShadow: [customerShadow()]),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Reviews & Ratings",
                style: TextStyle(
                    fontSize: getResposive(context, 16, 22, 24, 26),
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 5,
              ),
              TextField(
                decoration: InputDecoration(
                  labelText: "Comment",
                  hintStyle: TextStyle(color: Colors.grey[500]),
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: Colors.blueAccent, width: 1),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: Colors.blue, width: 2),
                  ),
                ),
                style: TextStyle(fontSize: 16, color: Colors.black),
                cursorColor: Colors.blueAccent,
              ),
              SizedBox(
                height: 8,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(Icons.star_border_outlined),
                      Icon(Icons.star_border_outlined),
                      Icon(Icons.star_border_outlined),
                      Icon(Icons.star_border_outlined),
                      Icon(Icons.star_border_outlined),
                    ],
                  ),
                  CustomeButtons.getButton(
                      getResposive(context, 0, 0, 0, 40),
                      getResposive(context, 0, 0, 0, 120),
                      Colors.blue,
                      Icons.post_add,
                      8,
                      Colors.white,
                      "Post",
                      Colors.white,
                      getResposive(context, 0, 0, 0, 16))
                ],
              ),
              SizedBox(
                height: 5,
              ),
              commentSection("CHANDA KOLGAONKAR", "18 Aug 2023", 5,
                  "Two young boys under 18 came and did a terrible job. Totally unprofessional approach. We did it for ants but in 4 days ants are running everywhere and no after service"),
              SizedBox(
                height: 10,
              ),
              commentSection("CHANDA KOLGAONKAR", "18 Aug 2023", 5,
                  "Two young boys under 18 came and did a terrible job. Totally unprofessional approach. We did it for ants but in 4 days ants are running everywhere and no after service"),
              SizedBox(
                height: 10,
              ),
              commentSection("CHANDA KOLGAONKAR", "18 Aug 2023", 5,
                  "Two young boys under 18 came and did a terrible job. Totally unprofessional approach. We did it for ants but in 4 days ants are running everywhere and no after service"),
              SizedBox(
                height: 10,
              ),
              commentSection("CHANDA KOLGAONKAR", "18 Aug 2023", 5,
                  "Two young boys under 18 came and did a terrible job. Totally unprofessional approach. We did it for ants but in 4 days ants are running everywhere and no after service"),
            ],
          ),
        ),
      );
    }

    Container footerSection() {
      return Container();
    }

    return Scaffold(
        appBar: customAppBar(context),
        body: Container(
          height: screenHeight,
          width: screenWidth,
          decoration: BoxDecoration(color: Color(0xD9D9D9ff)),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
            child: Container(
              color: Colors.white,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: introSection(),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: quickLinks(),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          mainContents(),
                          isSmallPhone()
                              ? Container()
                              : Container(
                                  width: getResposive(
                                      context,
                                      0,
                                      screenWidth * 0.35,
                                      screenWidth * 0.332,
                                      screenWidth * 0.29),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      contactInfo(),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Divider(),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      reviewsAndRatings(),
                                    ],
                                  ),
                                ),
                        ],
                      ),
                    ),
                    isSmallPhone() ? reviewsAndRatings() : Container(),
                    footerSection()
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
