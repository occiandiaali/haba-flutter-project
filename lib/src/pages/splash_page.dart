import 'dart:async';

import 'package:flutter/material.dart';
import 'package:haba/src/pages/user_auth_page.dart';
import 'package:haba/src/utils/check_connection.dart';
import 'package:simple_connection_checker/simple_connection_checker.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  StreamSubscription? subscription;
  bool isConnected = false;

  Future _proceedIn(BuildContext context) async {
    await Future.delayed(const Duration(seconds: 7)).then((value) {
      Navigator.pushReplacement(context, MaterialPageRoute(
          builder: (context) => const UserAuthPage()));
    });
  }

  @override
  void initState() {
    super.initState();
    InternetConnectionUtil.checkInternetAccess(isConnected);
    SimpleConnectionChecker simpleConnectionChecker = SimpleConnectionChecker()
    ..setLookUpAddress('google.com');
    subscription = simpleConnectionChecker.onConnectionChange.listen((connected) {
      if (mounted) {
        setState(() {
          isConnected = connected;
        });
        if (isConnected == true) {
          _proceedIn(context);
        }
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    subscription?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.deepOrangeAccent,
        // height: MediaQuery.of(context).size.height,
        // width: MediaQuery.of(context).size.width,
        child: Center(
          child: isConnected == true ? Stack(
            children: [
              Image.asset(
                "assets/images/haba_teal.jpg",
                fit: BoxFit.fill,
                height: MediaQuery.of(context).size.height * 0.6,
                width: MediaQuery.of(context).size.width,
              ),
              const Center(child: CircularProgressIndicator(color: Colors.white,),),
            ],
          ) : Stack(
            children: [
              Image.asset(
                "assets/images/no_internet.jpg",
                fit: BoxFit.fill,
                // height: MediaQuery.of(context).size.height,
                // width: MediaQuery.of(context).size.width,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
