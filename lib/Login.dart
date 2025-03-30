import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool isSignIn = true; // To toggle between Sign In and Sign Up forms

  // Function to switch between forms
  void toggleForm() {
    setState(() {
      isSignIn = !isSignIn;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Get the screen width
    double screenWidth = MediaQuery.of(context).size.width;

    // Define breakpoints for responsive design
    bool isMobile = screenWidth < 768;
    bool isTablet = screenWidth >= 768 && screenWidth < 1024;
    bool isDesktop = screenWidth >= 1024;

    // Adjust text size based on screen width
    double textSize = isDesktop ? 20 : (isTablet ? 18 : 16);
    double buttonFontSize = isDesktop ? 20 : (isTablet ? 18 : 16);

    // Set container size to 50% of screen width
    double containerWidth = screenWidth * 0.5;

    return Scaffold(
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(isDesktop ? 40.0 : 20.0), // Responsive padding
          child: SingleChildScrollView(
            child: Container(
              width: containerWidth, // 50% of the screen width
              padding: EdgeInsets.all(isDesktop ? 40.0 : 20.0), // Add padding to the container
              decoration: BoxDecoration(
                color: Colors.white, // Set the background color for the container
                borderRadius: BorderRadius.circular(12), // Rounded corners
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: Offset(0, 3), // Shadow position
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Title (Inside the container)
                  Text(
                    isSignIn ? "Sign In" : "Sign Up",
                    style: TextStyle(
                      fontSize: 24, // Adjust font size for the title
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: isDesktop ? 30 : 15), // Spacing below the title

                  // Username (Name) TextField
                  SizedBox(
                    width: containerWidth, // Set width to 50% of the screen width (same as container)
                    child: TextField(
                      decoration: InputDecoration(
                        labelText: "Name",
                        labelStyle: TextStyle(fontSize: textSize), // Adjust label size
                        contentPadding: EdgeInsets.symmetric(vertical: isDesktop ? 20 : 10),
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  SizedBox(height: isDesktop ? 20 : 10), // Responsive spacing

                  // Email TextField
                  SizedBox(
                    width: containerWidth, // Set width to 50% of the screen width (same as container)
                    child: TextField(
                      decoration: InputDecoration(
                        labelText: "Email",
                        labelStyle: TextStyle(fontSize: textSize), // Adjust label size
                        contentPadding: EdgeInsets.symmetric(vertical: isDesktop ? 15 : 10),
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  SizedBox(height: isDesktop ? 20 : 10), // Responsive spacing

                  // Password TextField
                  SizedBox(
                    width: containerWidth, // Set width to 50% of the screen width (same as container)
                    child: TextField(
                      decoration: InputDecoration(
                        labelText: "Password",
                        labelStyle: TextStyle(fontSize: textSize), // Adjust label size
                        contentPadding: EdgeInsets.symmetric(vertical: isDesktop ? 15 : 10),
                        border: OutlineInputBorder(),
                      ),
                      obscureText: true,
                    ),
                  ),
                  SizedBox(height: isDesktop ? 20 : 10), // Responsive spacing

                  // Conditional Confirm Password field (only for Sign Up)
                  if (!isSignIn)
                    SizedBox(
                      width: containerWidth, // Set width to 50% of the screen width (same as container)
                      child: TextField(
                        decoration: InputDecoration(
                          labelText: "Confirm Password",
                          labelStyle: TextStyle(fontSize: textSize), // Adjust label size
                          contentPadding: EdgeInsets.symmetric(vertical: isDesktop ? 15 : 10),
                          border: OutlineInputBorder(),
                        ),
                        obscureText: true,
                      ),
                    ),

                  SizedBox(height: isDesktop ? 20 : 15), // Responsive spacing between button and text

                  // Row for Sign In/Sign Up Button and text for toggle form
                  Column(
                    children: [
                      // First Row: Text Button (left side)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          TextButton(
                            onPressed: toggleForm,
                            child: Text(
                              isSignIn
                                  ? "Don't have an account?"
                                  : "Already have an account?",
                              style: TextStyle(
                                fontSize: buttonFontSize - 6, // Make the font size very small
                                color: Colors.blue, // Optional: Change text color
                              ),
                            ),
                          ),
                        ],
                      ),

                      // Add vertical space after the text button
                      SizedBox(height: 10), // Adjust vertical space if needed

                      // Second Row: Sign In/Sign Up Button with Icon (right side)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end, // Align button to the right
                        children: [
                          ElevatedButton.icon(
                            onPressed: () {},
                            icon: Icon(Icons.cloud, size: buttonFontSize), // Cloud icon inside the button
                            label: Text(
                              isSignIn ? "Sign In" : "Sign Up",
                              style: TextStyle(fontSize: buttonFontSize), // Adjust text size
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue, // Set background color
                              foregroundColor: Colors.white, // Set text color to white
                              padding: EdgeInsets.symmetric(horizontal: isDesktop ? 40 : 20, vertical: 15),
                              textStyle: TextStyle(fontSize: buttonFontSize), // Adjust text size
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.zero, // No rounded corners, rectangular shape
                              ),
                            ),
                          ),
                        ],
                      ),

                      // Add vertical space after the button
                      SizedBox(height: 20), // Adjust vertical space if needed
                    ],
                  ),

                  // Divider and 'or' text
                  SizedBox(height: isDesktop ? 30 : 15), // Responsive spacing
                  Row(
                    children: [
                      Expanded(
                        child: Divider(
                          color: Colors.black, // Divider color
                          thickness: 1, // Divider thickness
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10), // Padding around 'or' text
                        child: Text(
                          'OR',
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: buttonFontSize),
                        ),
                      ),
                      Expanded(
                        child: Divider(
                          color: Colors.black, // Divider color
                          thickness: 1, // Divider thickness
                        ),
                      ),
                    ],
                  ),

                  // Google sign-in button
                  SizedBox(height: isDesktop ? 20 : 10),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(vertical: 12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.grey.withOpacity(0.4)),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Replacing the Icon with the Google logo
                        Image.asset(
                          'assets/icons/google.jpg', // Path to your image
                          height: isDesktop ? 24 : 20,  // Adjust size based on screen size
                          width: isDesktop ? 24 : 20,   // Adjust size based on screen size
                        ),
                        SizedBox(width: 10),
                        Text(
                          'Google',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: buttonFontSize,
                          ),
                        ),
                      ],
                    ),
                  ),

                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
