import 'package:flutter_test/flutter_test.dart';
import 'package:rse/all.dart';

void main() {
  testRoundDown0From1();
  testRoundDown5From6();
  testRoundDown30From31();
  testRoundDown10From11();
  testGetLowestFromOne();
  testGetLowestFromSeries();
  testGetLowestFromMany();
  testGetHighestFromMany();
  testGetHighestFromSeries();
  testGetHighestFromOne();
}

void testGetHighestFromMany() {
  test('Found highest with lower item in series', () {
    CandleStick lowest = CandleStick.defaultCandleStick();
    CandleStick mid = CandleStick.fromJson(
      {
        'l': 5,
        'h': 5,
        'o': 5,
        'c': 5,
        'time': DateTime.now().toString(),
      },
    );
    CandleStick highest = CandleStick.fromJson({
      'l': 10,
      'h': 10,
      'o': 10,
      'c': 10,
      'time': DateTime.now().toString()
    });
    List<CandleStick> input = [lowest, mid, highest];
    expect(getHighestVal(input), equals(highest.l));
  });
}

void testGetHighestFromOne() {
  test('Found highest with single item in series', () {
    CandleStick item = CandleStick.defaultCandleStick();
    List<CandleStick> input = [item];
    expect(getHighestVal(input), equals(item.l));
  });
}

void testGetHighestFromSeries() {
  test('Found highest with lower item in series', () {
    CandleStick lowest = CandleStick.defaultCandleStick();
    CandleStick highest = CandleStick.fromJson({
      'l': 10,
      'h': 10,
      'o': 10,
      'c': 10,
      'time': DateTime.now().toString()
    });
    List<CandleStick> input = [highest, lowest];
    expect(getHighestVal(input), equals(highest.l));
  });
}

void testGetLowestFromMany() {
  test('Found lowest with higher item in series', () {
    CandleStick lowest = CandleStick.defaultCandleStick();
    CandleStick mid = CandleStick.fromJson(
      {
        'l': 5,
        'h': 5,
        'o': 5,
        'c': 5,
        'time': DateTime.now().toString(),
      },
    );
    CandleStick highest = CandleStick.fromJson({
      'l': 10,
      'h': 10,
      'o': 10,
      'c': 10,
      'time': DateTime.now().toString()
    });
    List<CandleStick> input = [lowest, mid, highest];
    expect(getLowestVal(input), equals(lowest.l));
  });
}

void testGetLowestFromOne() {
  test('Found lowest with single item in series', () {
    CandleStick lowest = CandleStick.defaultCandleStick();
    List<CandleStick> input = [lowest];
    expect(getLowestVal(input), equals(lowest.l));
  });
}

void testGetLowestFromSeries() {
  test('Found lowest with higher item in series', () {
    CandleStick lowest = CandleStick.defaultCandleStick();
    CandleStick higher = CandleStick.fromJson({
      'l': 10,
      'h': 10,
      'o': 10,
      'c': 10,
      'time': DateTime.now().toString()
    });
    List<CandleStick> input = [higher, lowest];
    expect(getLowestVal(input), equals(lowest.l));
  });
}

void testRoundDown0From1() {
  test('Time rounds to 00 from 01', () {
    var over = DateTime.parse('2018-08-16T11:01:00.000');
    var rounded = DateTime.parse('2018-08-16T11:00:00.000');
    expect(roundDownToNearest5Minutes(over), equals(rounded));
  });
}

void testRoundDown10From11() {
  test('Time rounds to 10 from 11', () {
    var over = DateTime.parse('2018-08-16T11:11:00.000');
    var rounded = DateTime.parse('2018-08-16T11:10:00.000');
    expect(roundDownToNearest5Minutes(over), equals(rounded));
  });
}

void testRoundDown30From31() {
  test('Time rounds to 30 from 31', () {
    var over = DateTime.parse('2018-08-16T11:31:00.000');
    var rounded = DateTime.parse('2018-08-16T11:30:00.000');
    expect(roundDownToNearest5Minutes(over), equals(rounded));
  });
}

void testRoundDown5From6() {
  test('Time rounds to 05 from 06', () {
    var over = DateTime.parse('2018-08-16T11:06:00.000');
    var rounded = DateTime.parse('2018-08-16T11:05:00.000');
    expect(roundDownToNearest5Minutes(over), equals(rounded));
  });
}
