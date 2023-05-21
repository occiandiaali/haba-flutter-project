//import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:haba/src/features/authentication/bloc/app_auth_bloc.dart';

import 'package:haba/src/pages/home_page.dart';
// import 'package:haba/src/utils/check_connection.dart';
// import 'package:haba/src/utils/show_snackbar.dart';
// import 'package:simple_connection_checker/simple_connection_checker.dart';


//import '../bloc/splash_screen_bloc.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  // StreamSubscription? subscription;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<AppAuthBloc, AppAuthState>(
          builder: (context, state) {
            if (state is Loading) {
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
            if (state is UnAuthenticated) {

            }
            return Container();
          },
        listener: (context, state) {
          if (state is Authenticated) {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => const HomePage()));
          }

          if (state is AuthError) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.error)));
          }
        },
      ),
    );
      // body: BlocListener<AppAuthBloc, AppAuthState>(
      //   listener: (context, state) {
      //     if (state is Authenticated) {
      //       Navigator.pushReplacement(context,
      //       MaterialPageRoute(builder: (context) => const HomePage()));
      //     }
      //     if (state is AuthError) {
      //       ScaffoldMessenger.of(context)
      //           .showSnackBar(
      //         SnackBar(content: Text(state.error)));
      //     }
      //   },
      //   child: BlocConsumer<AppAuthBloc, AppAuthState>(
      //     listener: (context, state) {},
      //     builder: (context, state) {
      //       if (state is Loading) {
      //         return SizedBox(
      //           height: MediaQuery.of(context).size.height,
      //           width: MediaQuery.of(context).size.width,
      //           child: Center(
      //             child: Image.asset(
      //               "assets/images/haba_teal.jpg",
      //               fit: BoxFit.fill,
      //               height: MediaQuery.of(context).size.height,
      //               width: MediaQuery.of(context).size.width,
      //             ),
      //           ),
      //         );
      //       }
      //       if (state is UnAuthenticated) {
      //         Navigator.pushReplacement(context,
      //             MaterialPageRoute(builder: (context) => const LoginPage()));
      //       }
      //       return Container();
      //     },
      //   ),
      // ),

  }
}

