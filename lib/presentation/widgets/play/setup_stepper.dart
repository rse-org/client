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
    final l = context.l;

    return Stepper(
      currentStep: _index,
      controlsBuilder: (_, details) => stepController(l, details),
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
          title: Text(getDiff(l)),
          content: buildDifficulties(l),
        ),
        Step(
          title: Text(getCat(l)),
          content: buildCategories(l),
        ),
        Step(
          title: getFinalTitle(l, finalStep),
          content: getFinalPrompt(l, finalStep),
        ),
      ],
    );
  }

  Widget stepController(
    l,
    ControlsDetails details,
  ) {
    if (details.currentStep == 2) {
      if (start) return const SizedBox();
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          ElevatedButton(
            style: ButtonStyle(
              minimumSize: MaterialStateProperty.all(
                Size(isS(context) ? 300 : 1000, 50),
              ),
              backgroundColor: MaterialStateProperty.all<Color>(
                Colors.green,
              ),
              foregroundColor: MaterialStateProperty.all<Color>(
                Colors.green,
              ),
              side: MaterialStateProperty.all<BorderSide>(
                const BorderSide(
                  color: Colors.green,
                ),
              ),
            ),
            onPressed: () async {
              if (diff != '' && cat != '') {
                setState(() {
                  start = true;
                });
                await Future.delayed(const Duration(seconds: 3));
                startQuiz();
              }
            },
            child: Text(l.play, style: const TextStyle(color: Colors.white)),
          ),
        ],
      );
    }
    return Row(
      children: <Widget>[
        TextButton(
          onPressed: details.onStepContinue,
          child: Text(l.next),
        ),
        TextButton(
          onPressed: details.onStepCancel,
          child: Text(l.cancel),
        ),
      ],
    );
  }

  buildDifficulties(l) {
    return Column(
      children: [
        Picker(pick: pickDiff, val: l.easy, picked: diff),
        Picker(pick: pickDiff, val: l.medium, picked: diff),
        Picker(pick: pickDiff, val: l.hard, picked: diff),
      ],
    );
  }

  buildCategories(l) {
    return Column(
      children: [
        Picker(pick: pickCat, val: l.personal, picked: cat),
        Picker(pick: pickCat, val: l.corporate, picked: cat),
        Picker(pick: pickCat, val: l.public, picked: cat),
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

  getFinalTitle(l, finalStep) {
    if (!finalStep && !start) return Text(l.play);
    if (!start && finalStep) return Text(l.ready);
    return Row(children: [Text(l.starting), const CountDownTimer(time: 3)]);
  }

  getFinalPrompt(l, finalStep) {
    if (finalStep && start) return Text(l.good_luck);
    if (finalStep) return const SizedBox();
    return Text(l.please_choose_diff_cat);
  }

  getDiff(l) => diff != '' ? '${l.difficulty}: $diff' : l.choose_difficulty;
  getCat(l) => cat != '' ? '${l.category}: $cat' : l.choose_category;

  startQuiz() {
    logPlayStart();
    BlocProvider.of<NavBloc>(context).add(StartQuiz());
  }
}
