import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rakshakpestcontroller/AdminControl.dart';

import 'Components/Buttons.dart';

class AdminLogin extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _AdminLogin();
}

class _AdminLogin extends State<AdminLogin> {

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

  TextEditingController name = new TextEditingController();
  TextEditingController email = new TextEditingController();
  TextEditingController password1 = new TextEditingController();
  TextEditingController password2 = new TextEditingController();
  TextEditingController mobileNumber = new TextEditingController();

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

    Container Admin(){
      return Container(
        width: getResposive(context, 330, 380, 400, 450),
        height: getResposive(context, 320, 340, 350, 360),
        decoration: BoxDecoration(
            border: Border.all(width: 0.2, color: Colors.blue),
            borderRadius: BorderRadius.circular(getResposive(context, 20, 18, 20, 20)),
            boxShadow: [customerShadow()],
            color: Colors.white
        ),
        child: Padding(
          padding: EdgeInsets.all(getResposive(context, 30, 40, 40, 50)),
          child: Column(
            children: [
              Text("Admin Login", style: TextStyle(fontSize: getResposive(context, 18, 20, 22, 24), fontWeight: FontWeight.bold),),
              SizedBox(height: getResposive(context, 14, 16, 16, 18),),

              TextField(
                controller: email,
                decoration: InputDecoration(
                  labelText: "Username",
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
              SizedBox(height: getResposive(context, 14, 16, 16, 18),),

              TextField(
                controller: password1,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: "Password",
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
              SizedBox(height: getResposive(context, 14, 16, 16, 18),),
              Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      InkWell(
                        onTap: () async {
                          if(email.text.isNotEmpty && password1.text.isNotEmpty){
                            QuerySnapshot q = await FirebaseFirestore.instance.collection("Admin").where("username", isEqualTo: email.text).where("password", isEqualTo: password1.text).get();
                            if(q.size != 0){
                              Navigator.push(context, MaterialPageRoute(builder: (context) => AdminControll(),));
                            }
                          }
                        },
                        child: CustomeButtons.getButton(
                          getResposive(context, 40, 38, 40, 50),
                          getResposive(context, 130, 120, 130, 150),
                          Colors.blue,
                          Icons.cloud_upload,
                          8,
                          Colors.white,
                          "Login",
                          Colors.white,
                          getResposive(context, 12, 14, 16, 18),
                        ),
                      )
                    ],
                  )),
              SizedBox(height: getResposive(context, 8, 9, 9, 8),),

            ],
          ),
        ),
      );
    }
    return Scaffold(
      body: Stack(
        children: [
          Center(
            child: Admin(),
          )
        ],
      )
    );
  }
}
