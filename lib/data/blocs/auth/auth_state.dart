part of 'auth_bloc.dart';

class Authenticated extends AuthState {
  final User currentUser;
  Authenticated(this.currentUser);
  @override
  List<Object?> get props => [2];
}

class AuthError extends AuthState {
  final String error;

  AuthError(this.error);
  @override
  List<Object?> get props => [error];
}

@immutable
abstract class AuthState extends Equatable {}

class Loading extends AuthState {
  @override
  List<Object?> get props => [0];
}

class UnAuthenticated extends AuthState {
  @override
  List<Object?> get props => [3];
}

class UserDataChange extends AuthState {
  @override
  List<Object?> get props => [1];
}
