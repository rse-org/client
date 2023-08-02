import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_signin_button/button_list.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:rse/all.dart';
import 'package:slider_button/slider_button.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        BlocConsumer<AuthBloc, AuthState>(
          listener: (context, state) {},
          builder: (context, state) {
            if (FirebaseAuth.instance.currentUser != null) {
              return Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 20,
                  horizontal: 10,
                ),
                child: SliderButton(
                  width: 125,
                  height: 50,
                  shimmer: false,
                  buttonSize: 50,
                  highlightedColor: Colors.red,
                  action: () {
                    BlocProvider.of<AuthBloc>(context).add(SignOutRequested());
                    haltAndFire(
                        milliseconds: 100,
                        fn: () => Navigator.of(context).pop());
                  },
                  label: Text(
                    context.l.sign_out,
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.red,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  icon: const Icon(
                    Icons.logout,
                    color: Colors.red,
                  ),
                ),
              );
            }
            return Center(
              child: Column(
                children: [
                  SignInButton(
                    Buttons.Google,
                    text: 'Sign up/in with Google',
                    onPressed: () {
                      BlocProvider.of<AuthBloc>(context).add(
                        GoogleSignInRequested(),
                      );
                    },
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }
}
