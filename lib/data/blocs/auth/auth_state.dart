part of 'auth_bloc.dart';

@immutable
abstract class AuthState extends Equatable {}

class Loading extends AuthState {
  @override
  List<Object?> get props => [0];
}

class UserDataChange extends AuthState {
  @override
  List<Object?> get props => [1];
}

class Authenticated extends AuthState {
  final User currentUser;
  Authenticated(this.currentUser);
  @override
  List<Object?> get props => [2];
}

class UnAuthenticated extends AuthState {
  @override
  List<Object?> get props => [3];
}

// If any error occurs the state is changed to AuthError.
class AuthError extends AuthState {
  final String error;

  AuthError(this.error);
  @override
  List<Object?> get props => [error];
}
