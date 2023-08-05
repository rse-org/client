import 'dart:collection';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_signin_button/button_list.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:intl/intl.dart';
import 'package:rse/all.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:table_calendar/table_calendar.dart';

final kEvents = LinkedHashMap<DateTime, List<Event>>(
  equals: isSameDay,
  hashCode: getHashCode,
)..addAll(_kEventSource);

final kFirstDay = DateTime(kToday.year, kToday.month - 12, kToday.day);

final kLastDay = DateTime(kToday.year, kToday.month, kToday.day);

final kToday = DateTime.now();

final _kEventSource = {
  for (var item in List.generate(50, (index) => index))
    DateTime.utc(kFirstDay.year, kFirstDay.month, item * 5): List.generate(
      item % 4 + 1,
      (index) => Event('Event $item | ${index + 1}'),
    )
}..addAll({
    kToday: [
      const Event('Today\'s Event 1'),
      const Event('Today\'s Event 2'),
    ],
  });

List<DateTime> daysInRange(DateTime first, DateTime last) {
  final dayCount = last.difference(first).inDays + 1;
  return List.generate(
    dayCount,
    (index) => DateTime.utc(first.year, first.month, first.day + index),
  );
}

int getHashCode(DateTime key) {
  return key.day * 1000000 + key.month * 10000 + key.year;
}

class Event {
  final String title;

  const Event(this.title);

  @override
  String toString() => title;
}

class StreakCalendar extends StatefulWidget {
  const StreakCalendar({super.key});

  @override
  StreakCalendarState createState() => StreakCalendarState();
}

class StreakCalendarState extends State<StreakCalendar> {
  int? streak;
  DateTime? _rangeEnd;
  DateTime? _rangeStart;
  DateTime? _selectedDay;
  List<String> _markedDates = [];
  DateTime _focusedDay = DateTime.now();
  late final ValueNotifier<List<Event>> _selectedEvents;
  CalendarFormat _calendarFormat = CalendarFormat.month;
  RangeSelectionMode _rangeSelectionMode = RangeSelectionMode.toggledOff;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: H(context),
      width: W(context),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              if (streak != null)
                Text(
                  // Todo: Fix the Placeholders, plurals, and selects to work with script to generate translations.
                  '${context.l.current_streak}: $streak',
                  style: T(context, 'headlineSmall'),
                ),
              if (streak == null)
                Text(
                  context.l.play_to_start,
                  style: T(context, 'headlineSmall'),
                )
            ],
          ),
          TableCalendar<Event>(
            lastDay: kLastDay,
            firstDay: kFirstDay,
            rangeEndDay: _rangeEnd,
            focusedDay: _focusedDay,
            rangeStartDay: _rangeStart,
            eventLoader: _getEventsForDay,
            onDaySelected: _onDaySelected,
            // calendarFormat: CalendarFormat.month,
            calendarFormat: _calendarFormat,
            onRangeSelected: _onRangeSelected,
            rangeSelectionMode: _rangeSelectionMode,
            startingDayOfWeek: StartingDayOfWeek.monday,
            selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
            onPageChanged: (focusedDay) {
              _focusedDay = focusedDay;
            },
            headerStyle: const HeaderStyle(
              formatButtonVisible: false,
            ),
            calendarStyle: const CalendarStyle(
              outsideDaysVisible: false,
            ),
            onFormatChanged: (format) {
              if (_calendarFormat != format) {
                p(_calendarFormat);
                setState(() {
                  _calendarFormat = format;
                });
              }
            },
            calendarBuilders: CalendarBuilders(
              defaultBuilder: (context, date, _) {
                final day = parseDateToString(date.toString());
                final activeDay = _markedDates.contains(day);
                if (activeDay) {
                  return Container(
                    margin: const EdgeInsets.all(4),
                    alignment: Alignment.center,
                    decoration: const BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                    ),
                    child: Text(
                      date.day.toString(),
                      style: const TextStyle(color: Colors.white),
                    ),
                  );
                }
                return null;
              },
            ),
          ),
          const SizedBox(height: 8.0),
          _buildAuthPrompt(),

          // Fix: After we decide what to show
          // Expanded(
          //   child: ValueListenableBuilder<List<Event>>(
          //     valueListenable: _selectedEvents,
          //     builder: (context, value, _) {
          //       return ListView.builder(
          //         itemCount: value.length,
          //         itemBuilder: (context, index) {
          //           return Container(
          //             margin: const EdgeInsets.symmetric(
          //               horizontal: 12.0,
          //               vertical: 4.0,
          //             ),
          //             decoration: BoxDecoration(
          //               border: Border.all(),
          //               borderRadius: BorderRadius.circular(12.0),
          //             ),
          //             child: ListTile(
          //               onTap: () => {
          //                 // print('${value[index]}')
          //               },
          //               title: Text('${value[index]}'),
          //             ),
          //           );
          //         },
          //       );
          //     },
          //   ),
          // ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _selectedEvents.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _selectedDay = _focusedDay;
    _selectedEvents = ValueNotifier(_getEventsForDay(_selectedDay!));
    _setStreak();
  }

  String parseDateToString(String str) {
    DateTime d = DateTime.parse(str);
    String format = DateFormat('yyyy-MM-dd').format(d);
    return format;
  }

  _buildAuthPrompt() {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {},
      builder: (context, state) {
        if (FirebaseAuth.instance.currentUser != null) {
          return const SizedBox(height: 0);
        }
        return Column(
          children: [
            const SizedBox(height: 20),
            buildText(
              context,
              'headlineSmall',
              context.l.signup_message_google,
            ),
            const SizedBox(height: 20),
            SignInButton(
              Buttons.Google,
              text: context.l.signup_button_google,
              onPressed: () {
                BlocProvider.of<AuthBloc>(context).add(
                  GoogleSignInRequested(),
                );
              },
            ),
          ],
        );
      },
    );
  }

  int _countConsecutive(List<String> list) {
    int max = 0, consecutive = 0;
    DateTime current = DateTime.now();
    List<DateTime> dates = list.toSet().map((d) => DateTime.parse(d)).toList();
    dates.sort((a, b) => b.compareTo(a));
    for (int i = 0; i < dates.length; i++) {
      Duration diff = current.difference(dates[i]);
      if (!(diff.inDays == 1 || diff.inDays == 0)) break;
      consecutive++;
      current = dates[i];
      if (consecutive > max) max = consecutive;
    }
    return max;
  }

  List<Event> _getEventsForDay(DateTime day) {
    return kEvents[day] ?? [];
  }

  List<Event> _getEventsForRange(DateTime start, DateTime end) {
    final days = daysInRange(start, end);

    return [
      for (final d in days) ..._getEventsForDay(d),
    ];
  }

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    if (!isSameDay(_selectedDay, selectedDay)) {
      setState(() {
        _rangeEnd = null;
        _rangeStart = null;
        _focusedDay = focusedDay;
        _selectedDay = selectedDay;
        _rangeSelectionMode = RangeSelectionMode.toggledOff;
      });

      _selectedEvents.value = _getEventsForDay(selectedDay);
    }
  }

  void _onRangeSelected(DateTime? start, DateTime? end, DateTime focusedDay) {
    setState(() {
      _selectedDay = null;
      _focusedDay = focusedDay;
      _rangeStart = start;
      _rangeEnd = end;
      _rangeSelectionMode = RangeSelectionMode.toggledOn;
    });

    if (start != null && end != null) {
      _selectedEvents.value = _getEventsForRange(start, end);
    } else if (start != null) {
      _selectedEvents.value = _getEventsForDay(start);
    } else if (end != null) {
      _selectedEvents.value = _getEventsForDay(end);
    }
  }

  _setStreak() async {
    final prefs = await SharedPreferences.getInstance();
    final List<String> dates = prefs.getStringList('streak dates') ?? [];
    if (dates.isNotEmpty) {
      _markedDates = dates.map((s) => parseDateToString(s)).toList();
      final max = _countConsecutive(_markedDates);
      setState(() {
        streak = max;
        _markedDates = _markedDates;
      });
    }
  }
}
