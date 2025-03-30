import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomeButtons {
  static double getResposive(BuildContext context, double a, double b, double c, double d){
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    bool isSmallMobile = screenWidth < 480;
    bool isMobile = screenWidth >= 480 && screenWidth < 768;
    bool isTablet = screenWidth >= 768 && screenWidth < 1024;

    return isSmallMobile ? a : isMobile ? b : isTablet ? c : d;
  }
  static getButton(double height, double width, Color backColor, IconData icon,
      int padding, Color textColor, String text, Color iconColor, double textFontSize) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: backColor,
      ),
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: iconColor,
            ),
            SizedBox(
              width: 5,
            ),
            Text(
              text,
              style: GoogleFonts.sanchez(
                  color: textColor, fontSize: textFontSize, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              width: 5,
            ),
          ],
        ),
      ),
    );
  }

  static getButton1(BuildContext context, double height, double width, Color backColor, String image,
      int padding, Color textColor, String text, Color iconColor, double textFontSize) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: backColor,
      ),
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image(
                image: AssetImage(
                    image
                ), width: getResposive(context, 16, 16, 16, 22), height: getResposive(context, 14, 16, 16, 22),
            ),
            SizedBox(
              width: 5,
            ),
            Text(
              text,
              style: GoogleFonts.sanchez(
                  color: textColor, fontSize: textFontSize, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              width: 5,
            ),
          ],
        ),
      ),
    );
  }

}
