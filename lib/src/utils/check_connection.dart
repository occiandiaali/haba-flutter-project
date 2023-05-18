import 'package:flutter/material.dart';
import 'package:simple_connection_checker/simple_connection_checker.dart';

// Future<bool> checkConnection() async {
//   bool connection = await SimpleConnectionChecker.isConnectedToInternet();
//   return connection;
// }

class InternetConnectionUtil {
  static void checkInternetAccess(bool connection) async {
    connection = await SimpleConnectionChecker.isConnectedToInternet();
  }

  static var connectionSnackBarAlert = const SnackBar(
      content: Text("It looks like you're not connected to the internet!"));
}



