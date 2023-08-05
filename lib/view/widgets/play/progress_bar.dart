import 'package:flutter/material.dart';
import 'package:primer_progress_bar/primer_progress_bar.dart';
import 'package:rse/all.dart';

class ProgressBar extends StatelessWidget {
  const ProgressBar({super.key});

  @override
  Widget build(BuildContext context) {
    final segments = [
      Segment(
        color: Colors.green,
        value: 24,
        label: Text(context.l.income),
        valueLabel: const Text('24%'),
      ),
      Segment(
        color: Colors.lime,
        value: 11,
        label: Text(context.l.spending),
        valueLabel: const Text('11%'),
      ),
      Segment(
        color: Colors.purple,
        value: 9,
        label: Text(context.l.savings),
        valueLabel: const Text('9%'),
      ),
      Segment(
        color: Colors.lightBlue,
        value: 6,
        label: Text(context.l.investing),
        valueLabel: const Text('6%'),
      ),
      Segment(
        color: Colors.orange,
        value: 4,
        label: Text(context.l.protection),
        valueLabel: const Text('4%'),
      ),
    ];
    return Container(
      height: isS(context) ? 200 : 300,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: C(context, 'outline'),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.all(getPadding(context)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              context.l.progress,
              style: T(context, 'headlineSmall'),
            ),
            FutureBuilder(
              future: LocalStorageService.getCompletedCount(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return const SizedBox();
                }
                if (snapshot.connectionState == ConnectionState.done) {
                  return Text(
                    '${context.l.lessons_completed}: ${snapshot.data}',
                  );
                }
                return const SizedBox();
              },
            ),
            const Spacer(),
            Text(
              context.l.topics_covered,
              style: T(context, 'titleLarge'),
            ),
            PrimerProgressBar(segments: segments)
          ],
        ),
      ),
    );
  }

  getPadding(context) {
    if (isS(context)) {
      return 10.0;
    }
    return 80.0;
  }
}
