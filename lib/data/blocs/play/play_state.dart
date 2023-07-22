part of 'play_bloc.dart';

@immutable
abstract class PlayState extends Equatable {}

class PlaySetup extends PlayState {
  @override
  List<Object?> get props => [];
}

class Preparing extends PlayState {
  Preparing();
  @override
  List<Object?> get props => [];
}

class Playing extends PlayState {
  Playing();
  @override
  List<Object?> get props => [];
}

class PlayError extends PlayState {
  final String error;

  PlayError(this.error);
  @override
  List<Object?> get props => [error];
}
