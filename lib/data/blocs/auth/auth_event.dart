part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class ProfileImageChangeRequested extends AuthEvent {
  final String? url;

  ProfileImageChangeRequested(this.url);
}

class SignInRequested extends AuthEvent {
  final String email;
  final String password;

  SignInRequested(this.email, this.password);
}

class SignUpRequested extends AuthEvent {
  final String name;
  final String email;
  final String password;

  SignUpRequested(this.name, this.email, this.password);
}

class GoogleSignInRequested extends AuthEvent {}

class SignOutRequested extends AuthEvent {}
