import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

// supabase creds
const supabaseUrl = 'https://eblmdswbxxaoxchdxwgt.supabase.co';
final supabaseKey = dotenv.env['SUPABASE_ANON_KEY'];

// Simple preloader inside Center widget
const preloader = Center(child: CircularProgressIndicator(color: Colors.deepOrangeAccent,),);

// Simple sized box to space out form elements
const formSpacer = SizedBox(width: 16.0, height: 16.0,);

// Some padding for use by forms
const formPadding = EdgeInsets.symmetric(vertical: 20, horizontal: 16);

// Error message when unexpected error occurs
const unexpectedErrorMessage = 'Unexpected error occurred';

// Basic app theme
final appTheme = ThemeData.light().copyWith(
  primaryColorDark: Colors.deepOrange,
  appBarTheme: const AppBarTheme(
    elevation: 1,
    backgroundColor: Colors.deepOrangeAccent,
    iconTheme: IconThemeData(color: Colors.black26),
    titleTextStyle: TextStyle(
      color: Colors.black,
      fontSize: 18,
      fontFamily: 'Cera Pro',
    ),
  ),
  primaryColor: Colors.deepOrange,
  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(
      foregroundColor: Colors.deepOrangeAccent,
    ),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      foregroundColor: Colors.white,
      backgroundColor: Colors.deepOrange,
    ),
  ),
  inputDecorationTheme: InputDecorationTheme(
    floatingLabelStyle: const TextStyle(
      color: Colors.deepOrange,
    ),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(
        color: Colors.grey,
        width: 2,
      ),
    ),
    focusColor: Colors.deepOrange,
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(
        color: Colors.deepOrangeAccent,
        width: 2,
      ),
    ),
  ),
);
