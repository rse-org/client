// ignore: avoid_web_libraries_in_flutter

import 'package:flutter/material.dart';

import 'tos/all.dart';

class TOSScreen extends StatefulWidget {
  const TOSScreen({super.key});

  @override
  State<TOSScreen> createState() => _TOSScreenState();
}

class _TOSScreenState extends State<TOSScreen> {
  @override
  Widget build(BuildContext context) {
    return const TOS();
  }
}
