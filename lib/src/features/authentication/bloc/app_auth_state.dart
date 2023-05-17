part of 'app_auth_bloc.dart';

@immutable
abstract class AppAuthState extends Equatable {}

class Loading extends AppAuthState {
  @override
  List<Object?> get props => [];
}

class Authenticated extends AppAuthState {
  @override
  List<Object?> get props => [];
}

class UnAuthenticated extends AppAuthState {
  @override
  List<Object?> get props => [];
}

class AuthError extends AppAuthState {
  final String error;

  AuthError(this.error);

  @override
  List<Object?> get props => [error];
}
