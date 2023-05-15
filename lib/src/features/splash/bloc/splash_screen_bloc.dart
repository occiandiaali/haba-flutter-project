import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'splash_screen_event.dart';
part 'splash_screen_state.dart';

class SplashScreenBloc extends Bloc<SplashScreenEvent, SplashScreenState> {
  SplashScreenBloc() : super(Initial()) {
    on<GoToHomeScreenEvent>((event, emit) async {
      emit(Loading());
      try {
        // [TODO]: Check internet connectivity here?

        // Simulate the above
        await Future.delayed(const Duration(seconds: 6));
          emit(Loaded());

      } catch (e) {
        emit(Loading());
      }
    });
}


}
