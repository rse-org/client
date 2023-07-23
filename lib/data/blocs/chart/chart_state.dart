import 'package:equatable/equatable.dart';
import 'package:rse/all.dart';

class ChartFocusSuccess extends ChartState {
  final Chart chart;
  ChartFocusSuccess(this.chart);

  @override
  List<Object?> get props => [chart];
}

class ChartInitial extends ChartState {
  final Chart chart;
  ChartInitial(this.chart);

  @override
  List<Object?> get props => [chart];
}

abstract class ChartState extends Equatable {
  @override
  List<Object?> get props => [];
}

class ChartUpdateSuccess extends ChartState {
  final Chart chart;
  ChartUpdateSuccess(this.chart);

  @override
  List<Object?> get props => [chart];
}
