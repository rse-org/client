import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rse/all.dart';
import 'package:rse/view/widgets/play/result_dialog.dart';

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
            if (state is PlayRoundFinished) {
              return ResultDialog(result: state.result);
            }
            return _buildQuestionContainer(context);
          },
        ),
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

  Expanded _buildCrossAndTimerBar(BuildContext context) {
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
              _buildCrossAndTimerBar(context),
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
}
