import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:haba/src/features/splash/bloc/splash_screen_bloc.dart';

class SplashScreenWidget extends StatefulWidget {
  const SplashScreenWidget({Key? key}) : super(key: key);

  @override
  State<SplashScreenWidget> createState() => _SplashScreenWidgetState();
}

class _SplashScreenWidgetState extends State<SplashScreenWidget> {

  @override
  void initState() {
    super.initState();
  //  _dispatchEvent(context); // dispatches goToHomeScreen event
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Center(
        child: Image.asset(
            "assets/images/haba_teal.jpg",
          fit: BoxFit.fill,
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
        ),
      ),
    );
  }

  // void _dispatchEvent(BuildContext context) {
  //   BlocProvider.of<SplashScreenBloc>(context).add(
  //     GoToHomeScreenEvent(),
  //   );
  // }
}

