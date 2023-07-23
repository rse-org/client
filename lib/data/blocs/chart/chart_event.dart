import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:rse/all.dart';

@immutable
abstract class ChartEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class ChartFocused extends ChartEvent {
  final Chart chart;
  ChartFocused(this.chart);

  @override
  List<Object?> get props => [chart];
}

class ChartUpdate extends ChartEvent {
  final Chart chart;
  ChartUpdate(this.chart);

  @override
  List<Object?> get props => [chart];
}
