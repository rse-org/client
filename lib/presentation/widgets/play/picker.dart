import 'package:flutter/material.dart';

class Picker extends StatelessWidget {
  final String val;
  final Function pick;
  final String picked;

  const Picker(
      {super.key, required this.pick, required this.val, required this.picked});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: TextButton(
        style: ButtonStyle(
          minimumSize: MaterialStateProperty.all(
            const Size(double.infinity, 50),
          ),
          backgroundColor: MaterialStateProperty.all<Color>(
            picked == val ? Colors.green : Colors.transparent,
          ),
          foregroundColor: MaterialStateProperty.all<Color>(
            picked == val ? Colors.white : Colors.green,
          ),
          side: MaterialStateProperty.all<BorderSide>(
            const BorderSide(
              color: Colors.green,
            ),
          ),
        ),
        onPressed: () {
          pick(val);
        },
        child: Text(val),
      ),
    );
  }
}
