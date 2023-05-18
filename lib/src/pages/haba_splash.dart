import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:haba/src/features/splash/bloc/splash_screen_bloc.dart';

import 'home_page.dart';


class HabaSplash extends StatefulWidget {
  const HabaSplash({Key? key}) : super(key: key);

  @override
  State<HabaSplash> createState() => _HabaSplashState();
}

class _HabaSplashState extends State<HabaSplash> {

  @override
  void initState() {
    super.initState();
    _dispatchEvent(context);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider<SplashScreenBloc>(
        create: (context) => SplashScreenBloc(),
        child: BlocBuilder<SplashScreenBloc, SplashScreenState>(
          builder: (context, state) {
            if (state is Initial || state is Loading) {
              return Container(
                color: Colors.deepOrangeAccent,
                // height: MediaQuery.of(context).size.height,
                // width: MediaQuery.of(context).size.width,
                child: Center(
                  child: Stack(
                    children: [
                      Image.asset(
                        "assets/images/haba_teal.jpg",
                        fit: BoxFit.fill,
                        height: MediaQuery.of(context).size.height * 0.6,
                        width: MediaQuery.of(context).size.width,
                      ),
                      const Center(child: CircularProgressIndicator(color: Colors.white,),),
                    ],
                  ),
                ),
              );
            } else if (state is Loaded) {
              return const HomePage();
            }
            return Container();
          },
        ),
      ),
    );
  }

  void _dispatchEvent(BuildContext context) {
    BlocProvider.of<SplashScreenBloc>(context).add(
      NavigationEvent(),
    );
  }
}

