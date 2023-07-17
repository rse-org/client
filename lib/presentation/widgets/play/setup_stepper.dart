import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rse/all.dart';

class SetupStepper extends StatefulWidget {
  const SetupStepper({super.key});

  @override
  State<SetupStepper> createState() => _SetupStepperState();
}

class _SetupStepperState extends State<SetupStepper> {
  int _index = 0;
  String cat = '';
  String diff = '';
  bool start = false;

  @override
  Widget build(BuildContext context) {
    final finalStep = diff != '' && cat != '';

    return Stepper(
      currentStep: _index,
      controlsBuilder: stepController,
      onStepCancel: () {
        if (_index > 0) {
          setState(() {
            _index -= 1;
          });
        }
      },
      onStepContinue: () {
        if (_index <= 1) {
          setState(() {
            _index += 1;
          });
        }
      },
      onStepTapped: (int index) {
        setState(() {
          _index = index;
        });
      },
      steps: <Step>[
        Step(
          title: Text(getDiff()),
          content: buildDifficulties(),
        ),
        Step(
          title: Text(getCat()),
          content: buildCategories(),
        ),
        Step(
          title: getFinalTitle(finalStep),
          content: getFinalPrompt(finalStep),
        ),
      ],
    );
  }

  Widget stepController(_, ControlsDetails details) {
    if (details.currentStep == 2) {
      if (start) return const SizedBox();
      return Row(
        children: <Widget>[
          ElevatedButton(
            onPressed: () async {
              if (diff != '' && cat != '') {
                setState(() {
                  start = true;
                });
                await Future.delayed(const Duration(seconds: 3));
                startQuiz();
              }
            },
            child: const Text('Play'),
          )
        ],
      );
    }
    return Row(
      children: <Widget>[
        TextButton(
          onPressed: details.onStepContinue,
          child: const Text('Next'),
        ),
        TextButton(
          onPressed: details.onStepCancel,
          child: const Text('Cancel'),
        ),
      ],
    );
  }

  buildDifficulties() {
    return Column(
      children: [
        Picker(pick: pickDiff, val: 'Easy', picked: diff),
        Picker(pick: pickDiff, val: 'Medium', picked: diff),
        Picker(pick: pickDiff, val: 'Hard', picked: diff),
      ],
    );
  }

  buildCategories() {
    return Column(
      children: [
        Picker(pick: pickCat, val: 'Personal', picked: cat),
        Picker(pick: pickCat, val: 'Corporate', picked: cat),
        Picker(pick: pickCat, val: 'Public', picked: cat),
      ],
    );
  }

  pickDiff(d) {
    logPlayDifficultySelect(d);
    setState(() {
      diff = d;
      _index++;
    });
  }

  pickCat(c) async {
    logPlayCategorySelect(c);
    setState(() {
      cat = c;
      _index++;
    });
  }

  getFinalTitle(finalStep) {
    if (!finalStep && !start) return const Text('Play');
    if (!start && finalStep) return const Text('Ready');
    return const Row(children: [Text('Starting:  '), CountDownTimer(time: 3)]);
  }

  getFinalPrompt(finalStep) {
    if (finalStep && start) return const Text('Good luck!');
    if (finalStep) return const SizedBox();
    return const Text('Please choose difficulty & category');
  }

  getDiff() => diff != '' ? 'Difficulty: $diff' : 'Choose your difficulty';
  getCat() => cat != '' ? 'Category: $cat' : 'Choose your category';

  startQuiz() {
    logPlayStart();
    BlocProvider.of<NavBloc>(context).add(StartQuiz());
  }
}
