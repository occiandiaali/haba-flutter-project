
import 'package:flutter/material.dart';

class FloatingTopBar extends StatelessWidget {

  final VoidCallback open;

  const FloatingTopBar({Key? key, required this.open})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: open,
          child: Container(
            padding: const EdgeInsets.all(6.0),
            margin: const EdgeInsets.only(bottom: 8.0),
            decoration: BoxDecoration(
                color: Colors.white38, borderRadius: BorderRadius.circular(50)
            ),
            child: const Icon(
              Icons.account_circle_rounded,
              size: 56,
            ),
          ),
        ),
        const SizedBox(height: 60),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 14.0),
          margin: const EdgeInsets.only(top: 18.0),
          decoration: BoxDecoration(
            color: Colors.black26.withOpacity(0.4),
            borderRadius: BorderRadius.circular(24),
          ),
          child: const Text("Hello, username",
              overflow: TextOverflow.fade,
              style: TextStyle(
                fontFamily: 'Cera Pro',
                fontWeight: FontWeight.w600,
                letterSpacing: 0.6,
                color: Colors.white,
              )),
        ),
      ],
    );
  }
}
