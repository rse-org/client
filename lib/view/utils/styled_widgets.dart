import 'package:flutter/material.dart';
import 'package:rse/all.dart';

buildText(context, size, text) {
  return Column(
    children: [
      Text(
        text,
        style: T(context, size),
      ),
      const SizedBox(height: 5),
    ],
  );
}
