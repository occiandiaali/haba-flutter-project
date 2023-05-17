part of 'app_auth_bloc.dart';

abstract class AppAuthEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class SignInRequested extends AppAuthEvent {
  final String email;
  final String password;

  SignInRequested(this.email, this.password);
}

class SignUpRequested extends AppAuthEvent {
  final String email;
  final String password;

  SignUpRequested(this.email, this.password);
}

class SignOutRequested extends AppAuthEvent {}
