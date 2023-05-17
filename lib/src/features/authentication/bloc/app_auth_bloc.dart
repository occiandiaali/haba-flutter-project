import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import './../data/repository/app_auth_repo.dart';

part 'app_auth_event.dart';
part 'app_auth_state.dart';

class AppAuthBloc extends Bloc<AppAuthEvent, AppAuthState> {
  final AppAuthRepo authRepo;
  AppAuthBloc({required this.authRepo}) : super(UnAuthenticated()) {

    on<SignInRequested>((event, emit) async {
      emit(Loading());
      try {
        await authRepo.signInWithEmail(
            email: event.email,
            password: event.password,
        );
        emit(Authenticated());
      } catch (e) {
        emit(AuthError(e.toString()));
        emit(UnAuthenticated());
      }
    });

    on<SignUpRequested>((event, emit) async {
      emit(Loading());
      try {
        await authRepo.registerUser(
          email: event.email,
          password: event.password,
        );
        emit(Authenticated());
      } catch (e) {
        emit(AuthError(e.toString()));
        emit(UnAuthenticated());
      }
    });

    on<SignOutRequested>((event, emit) async {
      emit(Loading());
      await authRepo.signOut();
      emit(UnAuthenticated());
    });
  }
}
