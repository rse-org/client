import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:rse/all.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  DateTime start = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: BlocConsumer<PlayBloc, PlayState>(
          listener: (context, state) {},
          builder: (context, state) {
            // Todo: Style dialog for score.
            // return _buildResultDialog(context, state);
            if (state is PlayRoundFinished) {
              return _buildCompletedScreen(context, state.result);
            }
            return _buildQuestionContainer(context);
          },
        ),
      ),
    );
  }

  Expanded buildCrossAndTimerBar(BuildContext context) {
    return Expanded(
      flex: 1,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () {
              BlocProvider.of<NavBloc>(context).add(EndQuiz());
            },
            child: const Icon(Icons.close),
          ),
          const CountDownTimer(time: 60),
        ],
      ),
    );
  }

  buildPrompt(length, int i) {
    return Text(
      '${i + 1} of $length',
      style: const TextStyle(
        fontSize: 15,
        decoration: TextDecoration.none,
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    setScreenName('/play/game');
    BlocProvider.of<PlayBloc>(context).add(PlayInitialized());
  }

  onAnswer(a, last) {
    BlocProvider.of<PlayBloc>(context).add(QuestionAnswered(ans: a));
    if (last) {
      BlocProvider.of<PlayBloc>(context).add(PlayDone(start));
    }
  }

  Dialog _buildCompletedScreen(BuildContext context, result) {
    final r = result;
    final score = r.score;
    return Dialog(
      child: SizedBox(
        height: H(context) * .5,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      '${_getPromptFromGrade(r.grade)}',
                      style: T(context, 'displaySmall'),
                    ),
                    RatingBarIndicator(
                      itemCount: 5,
                      itemSize: 50.0,
                      rating: _getStars(r.grade),
                      direction: Axis.horizontal,
                      unratedColor: Colors.amber.withAlpha(50),
                      itemBuilder: (context, index) => const Icon(
                        Icons.star,
                        color: Colors.amber,
                      ),
                    ),
                    Text(
                      '$score%',
                      style: const TextStyle(fontSize: 25),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Spacer(),
                Column(
                  children: [
                    IconButton(
                      iconSize: 40,
                      icon: const Icon(
                        Icons.exit_to_app,
                      ),
                      onPressed: () {
                        BlocProvider.of<PlayBloc>(context).add(PlayInitial());
                        BlocProvider.of<NavBloc>(context).add(EndQuiz());
                      },
                    ),
                    Text('Done', style: T(context, 'bodySmall'))
                  ],
                ),
                const Spacer(),
                _buildResultButton(r),
                const Spacer(),
                Column(
                  children: [
                    IconButton(
                      iconSize: 40,
                      icon: const Icon(
                        Icons.replay,
                      ),
                      onPressed: () {
                        BlocProvider.of<PlayBloc>(context)
                            .add(PlayInitialized());
                      },
                    ),
                    Text('Replay', style: T(context, 'bodySmall'))
                  ],
                ),
                const Spacer(),
              ],
            )
          ],
        ),
      ),
    );
  }

  _buildQuestion(state) {
    final i = state.idx;
    final q = state.currentQuestion;
    final questions = state.questions;
    final length = questions.length;
    final prompt = buildPrompt(length, i);
    final last = length == 1 + i;
    if (q.type == 'mc') {
      return MCQuestion(
        q: q,
        prompt: prompt,
        onAnswer: (a) => onAnswer(a, last),
      );
    }
    return MCCQuestion(
      q: q,
      prompt: prompt,
      key: UniqueKey(),
      onAnswer: (a) => onAnswer(a, last),
    );
  }

  _buildQuestionContainer(context) {
    return BlocBuilder<PlayBloc, PlayState>(
      builder: (context, state) {
        if (state is QuestionsLoadSuccess) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              buildCrossAndTimerBar(context),
              Expanded(
                flex: 13,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: _buildQuestion(state),
                ),
              ),
            ],
          );
        }
        return const SizedBox();
      },
    );
  }

  _buildResultButton(r) {
    if (kIsWeb) {
      return Column(
        children: [
          IconButton(
            iconSize: 40,
            icon: const Icon(
              Icons.description,
            ),
            onPressed: () {
              logResultsRequest(r);
            },
          ),
          Text('Results', style: T(context, 'bodySmall'))
        ],
      );
    } else {
      return AdInterstitial(onPress: () => logResultsRequest(r));
    }
  }

  _getPromptFromGrade(grade) {
    String val;
    switch (grade) {
      case 'A':
        val = 'Excellent!';
        break;
      case 'B':
        val = 'Great!';
        break;
      case 'C':
        val = 'A for effort!';
        break;
      case 'D':
        val = 'Needs improvement!';
        break;
      default:
        val = 'Lost a lot of money!';
    }
    return val;
  }

  _getStars(grade) {
    double val;
    switch (grade) {
      case 'A':
        val = 5;
        break;
      case 'B':
        val = 4;
        break;
      case 'C':
        val = 3;
        break;
      case 'D':
        val = 2;
        break;
      default:
        val = 1;
    }
    return val;
  }
}
