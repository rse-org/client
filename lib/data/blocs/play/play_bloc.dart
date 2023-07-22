import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:rse/all.dart';

part 'play_event.dart';
part 'play_state.dart';

class PlayBloc extends Bloc<PlayEvent, PlayState> {
  final PlayService playService;

  PlayBloc({required this.playService}) : super(PlaySetup()) {
    on<PlayInitialized>((event, emit) async {
      try {
        // await playService
      } catch (e) {
        // something else
      }
    });
    on<PickedDifficulty>((event, emit) async {
      try {
        // await playService
      } catch (e) {
        // something else
      }
    });
    on<PickedCategory>((event, emit) async {
      try {
        // await playService
      } catch (e) {
        // something else
      }
    });
    on<PlayStarted>((event, emit) async {
      try {
        // await playService
      } catch (e) {
        // something else
      }
    });
    on<QuestionAnswered>((event, emit) async {
      try {
        // await playService
      } catch (e) {
        // something else
      }
    });
    on<HitNext>((event, emit) async {
      try {
        // await playService
      } catch (e) {
        // something else
      }
    });
    on<HitPrev>((event, emit) async {
      try {
        // await playService
      } catch (e) {
        // something else
      }
    });
    on<PlayDone>((event, emit) async {
      try {
        // await playService
      } catch (e) {
        // something else
      }
    });
    on<ResultsCalculated>((event, emit) async {
      try {
        // await playService
      } catch (e) {
        // something else
      }
    });
  }
}
