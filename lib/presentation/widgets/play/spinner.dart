import 'package:flutter/material.dart';
import 'package:rse/all.dart';

class Spinner extends StatefulWidget {
  const Spinner({super.key});

  @override
  State<Spinner> createState() => _SpinnerState();
}

class _SpinnerState extends State<Spinner> with TickerProviderStateMixin {
  late AnimationController controller;
  bool determinate = false;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: H(context) * .7,
      child: Center(
        child: CircularProgressIndicator(
          value: controller.value,
          semanticsLabel: 'Progress indicator',
        ),
      ),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..addListener(() {
        setState(() {});
      });
    controller.repeat();
    super.initState();
  }
}
