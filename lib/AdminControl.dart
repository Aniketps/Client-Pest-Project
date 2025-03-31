import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AdminControll extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _AdminControll();

}

class _AdminControll extends State<AdminControll>{
  double getResposive(BuildContext context, double a, double b, double c, double d) {
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

  bool isSignIn = false;

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
                      Container(
                        height: getResposive(context, 50, 40, 44, 60),
                        width: getResposive(context, 50, 40, 44, 60),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(getResposive(context, 36, 40, 44, 60)),
                          border: Border.all(width: 0.2, color: Colors.blue),
                          boxShadow: [customerShadow()],
                          color: Colors.white,
                        ),
                        child: Transform(
                          alignment: Alignment.center,
                          transform: Matrix4.identity()
                            ..scale(0.8)  // Zoom out to 80%
                            ..rotateZ(45 * 3.1415927 / 180),  // Rotate 45 degrees
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(getResposive(context, 36, 40, 44, 60)),
                            child: Image.asset(
                              "assets/bug.png",
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      Text("Admin Control", style: TextStyle(fontWeight: FontWeight.bold, fontSize: getResposive(context, 20, 20, 22, 24)),)
                    ],
                  ),
                ],
              ),
            );
          },
        ),
      );
    }

    return Scaffold(
      appBar: customAppBar(context),
      body: Container(),
    );
  }

}