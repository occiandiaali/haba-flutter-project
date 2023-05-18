import 'package:flutter/material.dart';

class NoInternetPage extends StatelessWidget {
  const NoInternetPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        // height: MediaQuery.of(context).size.height,
        // width: MediaQuery.of(context).size.width,
        child: Stack(
          children: [
            Image.asset(
              "assets/images/no_internet.jpg",
              fit: BoxFit.fill,
              // height: MediaQuery.of(context).size.height,
              // width: MediaQuery.of(context).size.width,
            ),
            Center(
              child: Ink(
                decoration: const ShapeDecoration(
                    color: Colors.deepOrange,
                    shape: CircleBorder()),
                child: IconButton(
                  padding: const EdgeInsets.all(12.0),
                  color: Colors.white,
                  highlightColor: Colors.deepOrangeAccent,
                  onPressed: () {},
                  icon: const Icon(Icons.refresh_rounded),
                  iconSize: 32,
                  tooltip: "Try Again",
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

