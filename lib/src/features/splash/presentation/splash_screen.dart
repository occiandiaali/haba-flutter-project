import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:haba/src/features/splash/presentation/widgets/splash_screen_widget.dart';
import 'package:haba/src/pages/home_page.dart';
import 'package:haba/src/utils/check_connection.dart';
import 'package:haba/src/utils/show_snackbar.dart';
import 'package:simple_connection_checker/simple_connection_checker.dart';

import '../bloc/splash_screen_bloc.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  // StreamSubscription? subscription;
  // late bool hasConnection;

  // @override
  // void initState() {
  //   super.initState();
  //   checkConnection();
  //   SimpleConnectionChecker simpleConnectionChecker = SimpleConnectionChecker()
  //   ..setLookUpAddress('pub.dev');
  //   subscription = simpleConnectionChecker.onConnectionChange.listen((connected) {
  //     setState(() {
  //       hasConnection = connected;
  //     });
  //   });
  // }
  //
  // @override
  // void dispose() {
  //   subscription?.cancel();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(context),
    );
  }

  BlocProvider<SplashScreenBloc> _buildBody(BuildContext context) {
    return BlocProvider(
        create: (context) => SplashScreenBloc(),
      child: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Center(
          child: BlocBuilder<SplashScreenBloc, SplashScreenState>(
            builder: (context, state) {
              if ((state is Initial) || (state is Loading)) {
                return const SplashScreenWidget();
              } else if (state is Loaded) {
                return const HomePage();
              }
              // else {
              //   const AlertDialog(
              //     title: Text('Connectivity issue'),
              //     content: Text('Check your internet connection'),
              //     actions: [
              //       TextButton(onPressed: null, child: Text('OK'))
              //     ],
              //   );
              // }
              return Container();
            },
          ),
        ),
      ),
    );
  }
}

