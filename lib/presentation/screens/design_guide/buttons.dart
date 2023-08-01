import 'package:flutter/material.dart';
import 'package:rse/all.dart';

class CustomButtons extends StatefulWidget {
  const CustomButtons({super.key});

  @override
  State<CustomButtons> createState() => _CustomButtonsState();
}

class IconButtons extends StatelessWidget {
  const IconButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(4.0),
      child: Row(
        children: <Widget>[
          _ButtonTypesGroup(enabled: true),
          _ButtonTypesGroup(enabled: false),
        ],
      ),
    );
  }
}

class _ButtonTypesGroup extends StatelessWidget {
  final bool enabled;

  const _ButtonTypesGroup({required this.enabled});

  @override
  Widget build(BuildContext context) {
    final VoidCallback? onPressed = enabled ? () {} : null;

    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Column(
        children: <Widget>[
          IconButton(
            icon: const Icon(
              Icons.filter_drama,
            ),
            onPressed: onPressed,
          ),
          IconButton.filled(
            onPressed: onPressed,
            icon: const Icon(
              Icons.filter_drama,
            ),
          ),
          IconButton.filledTonal(
            onPressed: onPressed,
            icon: const Icon(
              Icons.filter_drama,
            ),
          ),
          IconButton.outlined(
            onPressed: onPressed,
            icon: const Icon(
              Icons.filter_drama,
            ),
          ),
        ],
      ),
    );
  }
}

class _CustomButtonsState extends State<CustomButtons> {
  Calendar calendarView = Calendar.day;
  Set<Sizes> selection = <Sizes>{Sizes.large, Sizes.extraLarge};
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 5),
        TextButton(
          onPressed: () {},
          child: const Text('TextButton Col'),
        ),
        ElevatedButton(
          onPressed: () {},
          child: const Text('ElevatedButton Col'),
        ),
        const SizedBox(height: 5),
        OutlinedButton(
          onPressed: () {},
          child: const Text('OutlinedButton Col'),
        ),
        const SizedBox(height: 5),
        FilledButton(
          onPressed: () {},
          child: const Text('FilledButton Col'),
        ),
        const SizedBox(height: 5),
        const IconButtons(),
        const SizedBox(height: 5),
        Column(
          children: [
            SegmentedButton<Calendar>(
              segments: const <ButtonSegment<Calendar>>[
                ButtonSegment<Calendar>(
                  value: Calendar.day,
                  label: Text('Day'),
                  icon: Icon(Icons.calendar_view_day),
                ),
                ButtonSegment<Calendar>(
                  value: Calendar.week,
                  label: Text('Week'),
                  icon: Icon(Icons.calendar_view_week),
                ),
                ButtonSegment<Calendar>(
                  value: Calendar.month,
                  label: Text('Month'),
                  icon: Icon(Icons.calendar_view_month),
                ),
                ButtonSegment<Calendar>(
                  value: Calendar.year,
                  label: Text('Year'),
                  icon: Icon(Icons.calendar_today),
                ),
              ],
              selected: <Calendar>{calendarView},
              onSelectionChanged: (Set<Calendar> newSelection) {
                setState(() {
                  calendarView = newSelection.first;
                });
              },
            ),
            const SizedBox(height: 10),
            SegmentedButton<Sizes>(
              segments: const <ButtonSegment<Sizes>>[
                ButtonSegment<Sizes>(
                  value: Sizes.extraSmall,
                  label: Text('XS'),
                ),
                ButtonSegment<Sizes>(
                  value: Sizes.small,
                  label: Text('S'),
                ),
                ButtonSegment<Sizes>(
                  value: Sizes.medium,
                  label: Text('M'),
                ),
                ButtonSegment<Sizes>(
                  value: Sizes.large,
                  label: Text('L'),
                ),
                ButtonSegment<Sizes>(
                  value: Sizes.extraLarge,
                  label: Text('XL'),
                ),
              ],
              selected: selection,
              onSelectionChanged: (Set<Sizes> newSelection) {
                setState(
                  () {
                    selection = newSelection;
                  },
                );
              },
              multiSelectionEnabled: true,
            ),
          ],
        ),
        const SizedBox(height: 50),
      ],
    );
  }
}
