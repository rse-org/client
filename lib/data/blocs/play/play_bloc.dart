import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:rse/all.dart';

part 'play_event.dart';
part 'play_state.dart';

class PlayBloc extends Bloc<PlayEvent, PlayState> {
  final PlayService playService;

  PlayBloc({required this.playService}) : super(Authenticated()) {
    on<SwitchQuestionType>((event, emit) async {
      try {
        // await playService
      } catch (e) {
        // something else
      }
    });
  }
}
