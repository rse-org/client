import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rse/all.dart';

class PlaySetupScreen extends StatefulWidget {
  const PlaySetupScreen({super.key});

  @override
  State<PlaySetupScreen> createState() => _PlaySetupScreenState();
}

class _PlaySetupScreenState extends State<PlaySetupScreen> {
  int _index = 2;
  bool start = false;
  String diff = 'Easy';
  String cat = 'Personal';

  @override
  Widget build(BuildContext context) {
    if (kIsWeb) return buildContent();
    return AdBanner(
      child: buildContent(),
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

  buildContent() {
    final finalStep = diff != '' && cat != '';
    final l = context.l;
    // const String assetName = 'assets/play-learn.svg';
    return Column(
      children: [
        // Padding(
        //   padding: const EdgeInsets.symmetric(vertical: 50.0, horizontal: 10),
        //   child: SizedBox(
        //     width: W(context) * .9,
        //     height: H(context) * .2,
        //     child: SvgPicture.asset(assetName, semanticsLabel: 'Play - Learn'),
        //   ),
        // ),
        Container(
          child: getTitle(getQuote()),
        ),
        Stepper(
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

  getCat(l) => cat != '' ? '${l.category}: $cat' : l.choose_category;

  getDiff(l) => diff != '' ? '${l.difficulty}: $diff' : l.choose_difficulty;

  getFinalPrompt(l, finalStep) {
    if (finalStep && start) return Text(l.good_luck);
    if (finalStep) return const SizedBox();
    return Text(l.please_choose_diff_cat);
  }

  getFinalTitle(l, finalStep) {
    if (!finalStep && !start) return Text(l.play);
    if (!start && finalStep) return Text(l.ready);
    return Row(children: [
      Text(l.starting),
      const CountDownTimer(time: kDebugMode ? 0 : 3)
    ]);
  }

  getQuote() {
    final quotes = [
      '\n\nA journey \nof a thousand\nmiles begins\nwith one step...',
      '\n\nMoney \ngrows on \nthe tree of \npersistence...',
      '\n\nIt takes \nas much \nenergy to wish \nas it does to plan...',
      "\n\nWealth is \nnot about having \na lot of money; \nit's about having a lot of options.",
      '\n\nYou either \nmaster money, \nor, on some level, \nmoney masters you...',
      "\n\nYou can \nbe young without money, \nbut you can't \nbe old without it...",
    ];
    quotes.shuffle();
    return quotes.first;
  }

  getTitle(t) {
    Widget quote = Text(
      t,
      style: const TextStyle(
        height: 1,
        fontSize: 40,
        letterSpacing: 0,
        color: Color(0xFFFFFFFF),
        fontWeight: FontWeight.w900,
      ),
    );

    quote = quote.animate(adapter: ValueAdapter(0.5)).shimmer(
      colors: [
        const Color(0xFF000000),
        const Color(0xFFFFD700),
      ],
    );

    quote = quote
        .animate(onPlay: (controller) => controller.repeat(reverse: true))
        .saturate(delay: 1.seconds, duration: 2.seconds)
        .then()
        .tint(
          color: const Color(0xFFFFFFFF),
        )
        .then(delay: 1.5.seconds)
        .blurXY(end: 24)
        .fadeOut();

    return quote;
  }

  pickCat(c) async {
    logEvent({'name': 'play_category_select', 'category': c});
    setState(() {
      cat = c;
      _index++;
    });
  }

  pickDiff(d) {
    logEvent({'name': 'play_difficulty_select', 'difficulty': d});
    setState(() {
      diff = d;
      _index++;
    });
  }

  startQuiz() {
    logPlayStart();
    BlocProvider.of<NavBloc>(context).add(StartQuiz());
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
            ),
            onPressed: () async {
              if (diff != '' && cat != '') {
                setState(() {
                  start = true;
                });
                haltAndFire(
                  fn: startQuiz,
                  milliseconds: kDebugMode ? 10 : 3000,
                );
              }
            },
            child: Text(l.play),
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
}
