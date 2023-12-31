import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:rse/all.dart';

class ArrowBackButton extends StatelessWidget {
  final String screenCode;
  final String root;
  const ArrowBackButton(
      {super.key, required this.screenCode, required this.root});

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (BuildContext c) {
        return IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            BlocProvider.of<NavBloc>(c).add(NavChanged(screenCode));
            c.go(root);
          },
        );
      },
    );
  }
}
