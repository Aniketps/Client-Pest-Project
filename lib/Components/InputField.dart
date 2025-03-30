import 'package:flutter/material.dart';

class InputField{
  static TextField customeInputText(String hint){
    return TextField(
      decoration: InputDecoration(
        labelText: "Comment",
        hintStyle: TextStyle(color: Colors.grey[500]),
        filled: true,
        fillColor: Colors.white,
        contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
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
    );
  }
}