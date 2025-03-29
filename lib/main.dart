import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rakshakpestcontroller/Components/Buttons.dart';
import 'package:rakshakpestcontroller/Login.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Initialize Firebase with the platform-specific options
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
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
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    PreferredSize customAppBar(BuildContext context) {
      return PreferredSize(
        preferredSize: Size.fromHeight(80),
        child: LayoutBuilder(
          builder: (context, constraints) {
            double screenWidth = constraints.maxWidth;

            // Multiple breakpoints
            bool isSmallMobile = screenWidth < 480;
            bool isMobile = screenWidth >= 480 && screenWidth < 768;
            bool isTablet = screenWidth >= 768 && screenWidth < 1024;
            bool isDesktop = screenWidth >= 1024;

            // Adjust sizes and padding based on breakpoints
            double logoSize = isSmallMobile
                ? 24
                : isMobile
                    ? 30
                    : isTablet
                        ? 35
                        : 40;

            double buttonWidth = isSmallMobile
                ? 130
                : isMobile
                    ? 150
                    : isTablet
                        ? 180
                        : 200;
            double buttonFontSize = isSmallMobile
                ? 14
                : isMobile
                    ? 16
                    : isTablet
                        ? 18
                        : 20;
            double padding = isSmallMobile
                ? 10
                : isMobile
                    ? 20
                    : isTablet
                        ? 40
                        : 50;

            return Container(
              height: 80,
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
                      if (!isSmallMobile) // Hide location on very small screens
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

    double horizontalPadding = screenWidth < 480
        ? 0
        : screenWidth < 720
            ? 25
            : 30;
    double introSectionSizeHeight = screenWidth < 480
        ? 150
        : screenWidth < 720
            ? 150
            : 200;
    double introSectionSizeWidth = screenWidth < 480
        ? screenWidth * 0.95
        : screenWidth < 720
            ? screenWidth * 0.9
            : screenWidth * 0.93;
    Container introSection() {
      return Container(
        height: introSectionSizeHeight,
        width: introSectionSizeWidth,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(5),
            border: Border.all(width: 0.1, color: Colors.black),
            boxShadow: [
              BoxShadow(
                color: Colors.blue,
                blurRadius: 0.2,
              )
            ]),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                "Rakshak Pest Control And Multi Services",
                style: TextStyle(fontSize: 25),
              ),
            ],
          ),
        ),
      );
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
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
