import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rse/all.dart';

void main() {
  testWidgets('Design guide screen', (tester) async {
    await tester.pumpWidget(const DesignGuideScreen());
    final titleFinder = find.text('Body Small');
    expect(titleFinder, findsOneWidget);
  });
  testWidgets('Design guide screen', (tester) async {
    await tester.pumpWidget(const DesignGuideScreen());
    final buttonFinder = find.byType(Tab);
    buttonFinder.last.hitTestable(at: Alignment.center);
    final titleFinder = find.text('Body Small');
    expect(titleFinder, findsOneWidget);
  });
}
