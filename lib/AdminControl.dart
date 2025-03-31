import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rakshakpestcontroller/Services/Enquiries.dart';
import 'package:rakshakpestcontroller/main.dart';

import 'Components/Buttons.dart';
import 'Services/AboutBusiness.dart';
import 'Services/BusinessServices.dart';
import 'Services/RatingAndReviews.dart';

AboutBusiness business = AboutBusiness();
BusinessServices businessServices = BusinessServices();
RatingAndReviews ratingAndReviews = RatingAndReviews();

class AdminControll extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _AdminControll();

}

class _AdminControll extends State<AdminControll>{

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    refresh();
  }

  Future<void> refresh() async {
    await enquiry.fetchEnquiries();
  }
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
  bool isEnquiry = false;
  int reviewsToShow = 3;


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
                      SizedBox(width: 10,),
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

    Widget enquirySection(String date, String serviceTitle, String name, String email, String location, String number, String status, String id) {
      return FutureBuilder<DocumentSnapshot>(
        future: FirebaseFirestore.instance.collection("Services").doc(serviceTitle).get(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Text("Error: ${snapshot.error}");
          }
          if (snapshot.hasData && snapshot.data!.exists) {
            var documentSnapshot = snapshot.data!;
            var serviceName = documentSnapshot.get("name") ?? 'No Name';

            return Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("All Enquiries", style: TextStyle(fontSize: getResposive(context, 16, 22, 24, 26), fontWeight: FontWeight.bold),),
                  Container(
                    decoration: BoxDecoration(
                        border: Border.all(width: 0.2, color: Colors.blue),
                        boxShadow: [customerShadow()],
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(getResposive(context, 15, 15, 15, 8))
                    ),
                    height: getResposive(context, 200, 180, 200, 240),
                    width: getResposive(context, 320, 250, 300, 400),
                    padding: EdgeInsets.all(getResposive(context, 10, 8, 10, 15)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Date: $date", style: TextStyle(fontSize: getResposive(context, 14, 12, 14, 16))),
                        SizedBox(height: 2,),
                        Text("For: $serviceName", style: TextStyle(fontSize: getResposive(context, 14, 12, 14, 16))),
                        SizedBox(height: 2,),
                        Text("Name: $name", style: TextStyle(fontSize: getResposive(context, 14, 12, 14, 16))),
                        SizedBox(height: 2,),
                        Text("Email: $email", style: TextStyle(fontSize: getResposive(context, 14, 12, 14, 16))),
                        SizedBox(height: 2,),
                        Text("Location: $location", style: TextStyle(fontSize: getResposive(context, 14, 12, 14, 16))),
                        SizedBox(height: 2,),
                        Text("Phone Number: $number", style: TextStyle(fontSize: getResposive(context, 14, 12, 14, 16))),
                        SizedBox(height: 2,),
                        if (status == "Neutral")
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              InkWell(
                                onTap: () async {
                                  FirebaseFirestore.instance.collection("Enquiries").doc(id.toString()).update({
                                    "status": "Accepted",
                                  });
                                },
                                child: CustomeButtons.getButton(
                                    getResposive(context, 40, 34, 36, 40),
                                    getResposive(context, 100, 80, 100, 120),
                                    Colors.green, Icons.done, 8, Colors.white,
                                    "Done", Colors.white, getResposive(context, 14, 10, 12, 14)
                                ),
                              ),
                              SizedBox(width: 8),
                              InkWell(
                                onTap: () {
                                  FirebaseFirestore.instance.collection("Enquiries").doc(id.toString()).update({
                                    "status": "Cancelled",
                                  });
                                },
                                child: CustomeButtons.getButton(
                                  getResposive(context, 40, 34, 36, 40),
                                  getResposive(context, 100, 90, 100, 120),
                                  Colors.red,
                                  Icons.cancel,
                                  8,
                                  Colors.white,
                                  "Canceled",
                                  Colors.white,
                                  getResposive(context, 14, 10, 12, 14),
                                ),
                              ),
                            ],
                          )
                        else
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(status, style: TextStyle(fontWeight: FontWeight.bold, fontSize: getResposive(context, 14, 12, 14, 16))),
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }
          return Text("No Data Available");
        },
      );
    }


    Container pastEnquiries() {
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
              "Work Records",
              style: TextStyle(
                  fontSize: getResposive(context, 16, 22, 24, 26),
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
      );
    }

    Container commentSection(String name, String date, int star, String comment) {
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
              )
            ],
          ),
        ),
      );
    }
    
    double horizontalPadding = getResposive(context, 0, 10, 25, 30);

    Container mainContents() {
      return Container(
        width: getResposive(context, screenWidth * 0.92, screenWidth * 0.92, screenWidth * 0.91, screenWidth * 0.92),
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
              Wrap(
                spacing: getResposive(context, 0, 8, 8, 10),
                runSpacing: getResposive(context, 5, 8, 8, 10),
                alignment: WrapAlignment.center,
                runAlignment: WrapAlignment.center,
                children: enquiry.allEnquiries.map<Widget>((e) {
                  return enquirySection(e.date, e.serviceUID, e.name, e.email, e.localAddress, e.mobileNumber, e.status, e.id);
                }).toList(),
              ),
            ],
          ),
        ),
      );
    }

    Container reviewsAndRatings() {
      return Container(
        height: getResposive(context, 500, 500, 500, 650),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          border: Border.all(width: 0.5, color: Colors.blue),
          color: Colors.white,
          boxShadow: [customerShadow()],
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Reviews & Ratings",
                  style: TextStyle(
                    fontSize: getResposive(context, 16, 22, 24, 26),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8),
                // Column for reviews
                Column(
                  children: ratingAndReviews.allReviews
                      .take(reviewsToShow)  // Only show top 'reviewsToShow' reviews
                      .map<Widget>((review) {
                    return Column(
                      children: [
                        commentSection(
                          review.name,
                          review.date,
                          review.rate,
                          review.comment,
                        ),
                        SizedBox(height: 10),
                      ],
                    );
                  }).toList(),
                ),

                // Button to load more reviews if available
                if (ratingAndReviews.allReviews.length > reviewsToShow)
                  Center(
                    child: InkWell(
                        onTap: (){
                          setState(() {
                            reviewsToShow += 2;  // Load 5 more reviews
                          });
                        },
                        child: CustomeButtons.getButton(getResposive(context, 44, 38, 40, 44), getResposive(context, 120, 100, 120, 140), Colors.blue, Icons.change_circle_rounded, 8, Colors.white, "Load", Colors.white, getResposive(context, 14, 12, 14, 16))
                    ),
                  )
              ],
            ),
          ),
        ),
      );
    }

    return Scaffold(
      appBar: customAppBar(context),
      body: Stack(
        children: [
          Container(
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
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(child: mainContents()),
                          ],
                        ),
                      ),
                      Container(
                        height: getResposive(context, 70, 70, 80, 120),
                        color: Color(0xff83a7fa),
                        child: Container(
                            height: getResposive(context, 60, 70, 80, 80),
                            child: Padding(
                              padding: EdgeInsets.only(left: getResposive(context, 40, 70, 80, 120)),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text("© 2021–${DateTime.now().year} Rakshak Pest Controller. All rights reserved.", style: TextStyle(fontSize: getResposive(context, 10, 12, 12, 14), fontWeight: FontWeight.bold, color: Colors.white),),
                                ],
                              ),
                            )
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      )
    );
  }

}