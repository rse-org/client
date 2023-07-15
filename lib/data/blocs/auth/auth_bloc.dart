import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:rse/all.dart';

// import 'package:meta/meta.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthService authService;

  AuthBloc({required this.authService}) : super(UnAuthenticated()) {
    on<SignInRequested>((event, emit) async {
      emit(Loading());
      try {
        await authService.signIn(email: event.email, password: event.password);
        emit(Authenticated(FirebaseAuth.instance.currentUser!));
      } catch (e) {
        emit(AuthError(e.toString()));
        emit(UnAuthenticated());
      }
    });
    on<SignUpRequested>((event, emit) async {
      emit(Loading());
      try {
        await authService.signUp(
            name: event.name, email: event.email, password: event.password);
        emit(Authenticated(FirebaseAuth.instance.currentUser!));
      } catch (e) {
        emit(AuthError(e.toString()));
        emit(UnAuthenticated());
      }
    });

    on<ProfileImageChangeRequested>((event, emit) async {
      emit(Loading());
      try {
        await FirebaseAuth.instance.currentUser?.updatePhotoURL(event.url);
        emit(UserDataChange());
      } catch (e) {
        emit(AuthError(e.toString()));
      }
    });
    on<GoogleSignInRequested>((event, emit) async {
      emit(Loading());
      try {
        await authService.signInWithGoogle();
        emit(Authenticated(FirebaseAuth.instance.currentUser!));
      } catch (e) {
        emit(AuthError(e.toString()));
        emit(UnAuthenticated());
      }
    });
    on<SignOutRequested>((event, emit) async {
      emit(Loading());
      await authService.signOut();
      emit(UnAuthenticated());
    });
  }
}
