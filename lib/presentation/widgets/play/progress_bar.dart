import 'package:flutter/material.dart';
import 'package:primer_progress_bar/primer_progress_bar.dart';
import 'package:rse/all.dart';

const segments = [
  Segment(
    color: Colors.green,
    value: 24,
    label: Text('Dart'),
    valueLabel: Text('24%'),
  ),
  Segment(
    color: Colors.lime,
    value: 11,
    label: Text('CSS'),
    valueLabel: Text('11%'),
  ),
  Segment(
    color: Colors.purple,
    value: 9,
    label: Text('HTML'),
    valueLabel: Text('9%'),
  ),
  Segment(
    color: Colors.lightBlue,
    value: 6,
    label: Text('Typescript'),
    valueLabel: Text('6%'),
  ),
  Segment(
    color: Colors.orange,
    value: 4,
    label: Text('Javascript'),
    valueLabel: Text('4%'),
  ),
  Segment(
    color: Colors.grey,
    value: 4,
    label: Text('Shell'),
    valueLabel: Text('4%'),
  ),
  Segment(
    color: Colors.indigo,
    value: 4,
    label: Text('Java'),
    valueLabel: Text('4%'),
  ),
  Segment(
    color: Colors.red,
    value: 4,
    label: Text('Objective-C'),
    valueLabel: Text('4%'),
  ),
  Segment(
    color: Colors.teal,
    value: 2,
    label: Text('Rust'),
    valueLabel: Text('2%'),
  ),
  Segment(
    color: Colors.brown,
    value: 2,
    label: Text('Swift'),
    valueLabel: Text('2%'),
  ),
];

class ProgressBar extends StatelessWidget {
  const ProgressBar({super.key});

  getPadding(context) {
    if (isS(context)) {
      return 10;
    }
    return 80;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: isS(context) ? 200 : 300,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: T(context, 'outline'),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.all(getPadding(context)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Progress',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: isS(context) ? 20 : 30,
              ),
            ),
            const Spacer(),
            const PrimerProgressBar(segments: segments)
          ],
        ),
      ),
    );
  }
}
