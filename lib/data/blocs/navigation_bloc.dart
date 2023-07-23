import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

final defaultStates = [0, 0, 0, 0, 0];

class EndQuiz extends NavEvent {}

class NavBloc extends Bloc<NavEvent, NavState> {
  final tabStates = defaultStates;
  NavBloc() : super(NavChangeSuccess('0-0', defaultStates)) {
    on<NavChanged>((e, emit) async {
      final indexes = e.location.split('-');
      tabStates[int.parse(indexes[0])] = int.parse(indexes[1]);
      emit(NavChangeSuccess(e.location, tabStates));
    });
    on<StartQuiz>((e, emit) async {
      emit(QuizStartSuccess(tabStates));
    });
    on<EndQuiz>((e, emit) async {
      emit(QuizFinishSuccess(tabStates));
    });
  }
}

class NavChanged extends NavEvent {
  final String location;

  NavChanged(this.location);

  @override
  List<Object?> get props => [location];
}

class NavChangeSuccess extends NavState {
  final String location;
  @override
  final List<int> states;

  NavChangeSuccess(this.location, this.states);

  @override
  List<Object?> get props => [location, states];
}

abstract class NavEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

abstract class NavState extends Equatable {
  List<int> get states;
}

class QuizFinishSuccess extends NavState {
  @override
  final List<int> states;
  QuizFinishSuccess(this.states);

  @override
  List<Object?> get props => [states];
}

class QuizStartSuccess extends NavState {
  @override
  final List<int> states;
  QuizStartSuccess(this.states);

  @override
  List<Object?> get props => [states];
}

class StartQuiz extends NavEvent {}
