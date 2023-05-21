import 'package:flutter/material.dart';

// extension ShowSnackBar on BuildContext {
//   void showSnackBar({
//     required String message,
//     Color backgroundColor = Colors.white,
//   }) {
//     ScaffoldMessenger.of(this).showSnackBar(
//         SnackBar(
//           content: Text(message),
//           backgroundColor: backgroundColor,
//         )
//     );
//   }
//   void showErrorSnackBar({required String message}) {
//     showSnackBar(message: message, backgroundColor: Colors.red);
//   }
// }

void showSnackBar({
  context,
  required String message,
  Color backgroundColor = Colors.white,
}) {
  ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: backgroundColor,
      )
  );
}