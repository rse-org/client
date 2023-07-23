part of 'play_bloc.dart';

class PlayError extends PlayState {
  final String error;

  PlayError(this.error);
  @override
  List<Object?> get props => [error];
}

class Playing extends PlayState {
  Playing();
  @override
  List<Object?> get props => [];
}

class PlaySetup extends PlayState {
  @override
  List<Object?> get props => [];
}

@immutable
abstract class PlayState extends Equatable {}

class Preparing extends PlayState {
  Preparing();
  @override
  List<Object?> get props => [];
}
