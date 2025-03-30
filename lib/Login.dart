import 'package:flutter/material.dart';
import 'package:rakshakpestcontroller/Components/Buttons.dart';

class Login extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _LoginState();
}

class _LoginState extends State<Login> {
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

    Container signIn(){
      return Container(
        width: getResposive(context, 350, 380, 400, 450),
        height: getResposive(context, 400, 420, 450, 470),
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
              Text("Sing In", style: TextStyle(fontSize: getResposive(context, 18, 20, 22, 24), fontWeight: FontWeight.bold),),
              SizedBox(height: getResposive(context, 14, 16, 16, 18),),

              TextField(
                controller: email,
                decoration: InputDecoration(
                  labelText: "Email",
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
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      InkWell(
                          onTap: (){
                            setState(() {
                              isSignIn = !isSignIn;
                            });
                          },
                          child: Text("Don't have an account?", style: TextStyle(fontSize: getResposive(context, 8, 10, 10, 12), color: Colors.blue),))
                    ],
                  )),
              SizedBox(height: getResposive(context, 14, 16, 16, 18),),

              Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      CustomeButtons.getButton(getResposive(context, 40, 38, 40, 50), getResposive(context, 130, 120, 130, 150), Colors.blue, Icons.cloud_upload, 8, Colors.white, "Sign In", Colors.white, getResposive(context, 12, 14, 16, 18))
                    ],
                  )),
              SizedBox(height: getResposive(context, 8, 9, 9, 8),),
              Row(
                children: [
                  Expanded(
                    child: Divider(
                      color: Colors.grey,      // Divider color
                      thickness: 1,            // Divider thickness
                    ),
                  ),
                  SizedBox(width: 8),
                  Text("OR"),
                  SizedBox(width: 8),
                  Expanded(
                    child: Divider(
                      color: Colors.grey,
                      thickness: 1,
                    ),
                  ),
                ],
              ),
              SizedBox(height: getResposive(context, 14, 16, 16, 18),),
              InkWell(
                onTap: (){},
                child: CustomeButtons.getButton1(context, getResposive(context, 40, 45, 50, 50), getResposive(context, 200, 250, 300, 300), Color(
                    0xffdee9fa), "assets/icons/google.png", 8, Colors.black, "Google", Colors.black, 16),
              )
            ],
          ),
        ),
      );
    }

    Container signUp(){
      return Container(
        width: getResposive(context, 350, 380, 400, 450),
        height: getResposive(context, 510, 550, 600, 600),
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
              Text("Sing Up", style: TextStyle(fontSize: getResposive(context, 18, 20, 22, 24), fontWeight: FontWeight.bold),),
              SizedBox(height: getResposive(context, 14, 16, 16, 18),),
              TextField(
                controller: name,
                decoration: InputDecoration(
                  labelText: "Name",
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
                controller: email,
                decoration: InputDecoration(
                  labelText: "Email",
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

              TextField(
                controller: password2,
                decoration: InputDecoration(
                  labelText: "Confirm Password",
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
              SizedBox(height: getResposive(context, 3, 3, 4, 5),),
              Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      InkWell(
                          onTap: (){
                            setState(() {
                              isSignIn = !isSignIn;
                            });
                          },
                          child: Text("Already have an account?", style: TextStyle(fontSize: getResposive(context, 8, 10, 10, 12), color: Colors.blue),))
                    ],
                  )),
              SizedBox(height: getResposive(context, 14, 16, 16, 18),),

              Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      CustomeButtons.getButton(getResposive(context, 40, 38, 40, 50), getResposive(context, 130, 120, 130, 150), Colors.blue, Icons.cloud_upload, 8, Colors.white, "Sign Up", Colors.white, getResposive(context, 12, 14, 16, 18))
                    ],
                  )),
              SizedBox(height: getResposive(context, 8, 9, 9, 10),),
              Row(
                children: [
                  Expanded(
                    child: Divider(
                      color: Colors.grey,      // Divider color
                      thickness: 1,            // Divider thickness
                    ),
                  ),
                  SizedBox(width: 8),
                  Text("OR"),
                  SizedBox(width: 8),
                  Expanded(
                    child: Divider(
                      color: Colors.grey,
                      thickness: 1,
                    ),
                  ),
                ],
              ),
              SizedBox(height: getResposive(context, 14, 16, 16, 18),),
              InkWell(
                onTap: (){},
                child: CustomeButtons.getButton1(context, getResposive(context, 40, 45, 50, 50), getResposive(context, 200, 250, 300, 300), Color(
                    0xffdee9fa), "assets/icons/google.png", 8, Colors.black, "Google", Colors.black, 16),
              )
            ],
          ),
        ),
      );
    }

    return Scaffold(
      body: Stack(
        children: [
          Center(
            child: !isSignIn? signIn() : signUp(),
          )
        ],
      )
    );
  }
}
