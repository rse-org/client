import 'package:flutter_test/flutter_test.dart';
import 'package:rse/all.dart';

void main() {
  testFormatOneMinute();
}

void testFormatOneMinute() {
  test('Formats 60 seconds as 1:00', () {
    expect(
      formatTimeDifference(
        const Duration(seconds: 60),
      ),
      equals('00:01:00'),
    );
  });
  test('Formats 180 seconds as 3:00', () {
    expect(
      formatTimeDifference(
        const Duration(seconds: 180),
      ),
      equals('00:03:00'),
    );
  });
  test('Formats 1 hour as 60:00', () {
    expect(
      formatTimeDifference(
        const Duration(hours: 1),
      ),
      equals('01:00:00'),
    );
  });
}
