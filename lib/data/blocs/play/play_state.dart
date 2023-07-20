part of 'play_bloc.dart';

@immutable
abstract class PlayState extends Equatable {}

class Loading extends PlayState {
  @override
  List<Object?> get props => [];
}

class Authenticated extends PlayState {
  Authenticated();
  @override
  List<Object?> get props => [];
}

class PlayError extends PlayState {
  final String error;

  PlayError(this.error);
  @override
  List<Object?> get props => [error];
}
