import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rse/all.dart';

class ChartBloc extends Bloc<ChartEvent, ChartState> {
  late Chart chart;
  final AssetBloc assetBloc;
  final PortfolioBloc portfolioBloc;

  ChartBloc(
      {required this.chart,
      required this.assetBloc,
      required this.portfolioBloc})
      : super(ChartInitial(chart)) {
    assetBloc.stream.listen((state) {
      if (state is AssetLoaded) {
        updateChart(state.asset, state.asset.sym);
      }
    });
    portfolioBloc.stream.listen((state) {
      if (state is PortfolioLoadedSuccess) {
        updateChartPortfolio(state.portfolio);
      }
    });
    on<ChartFocused>((e, emit) {
      emit(ChartFocusSuccess(e.chart));
    });
    on<ChartUpdate>((e, emit) {
      emit(ChartUpdateSuccess(e.chart));
    });
  }

  void chartPortfolio(Portfolio p) {
    final newChart = chart.copyWith(
      data: p.series,
      sym: 'Investing',
      period: p.period,
      startValue: p.series.first.y,
      latestValue: p.series.last.y,
    );
    chart = newChart;
    add(ChartUpdate(newChart));
  }

  void hoveredChart(CandleStick c, double xOffSet) {
    final newChart = chart.copyWith(
      candle: c,
      time: c.time,
      xOffSet: xOffSet,
      focusedValue: c.c,
    );

    chart = newChart;
    add(ChartFocused(newChart));
  }

  void hoveredLineChart(DataPoint p, double xOffSet) {
    final newChart = chart.copyWith(
      time: p.x,
      xOffSet: xOffSet,
      focusedValue: p.y,
    );
    chart = newChart;
    add(ChartFocused(newChart));
  }

  void updateChart(Asset a, String sym) {
    final series = a.current;
    final point = DataPoint(series.last.time, series.last.c);
    final newChart = chart.copyWith(
      sym: sym,
      candle: series.last,
      latestValue: point.y,
      candleSeries: series,
      startValue: series.first.o,
    );
    chart = newChart;
    add(ChartUpdate(newChart));
  }

  void updateChartPortfolio(Portfolio p) {
    final newChart = chart.copyWith(
      sym: 'Investing',
      data: p.series,
      startValue: p.series.first.y,
      latestValue: p.series.last.y,
    );
    chart = newChart;
    add(ChartUpdate(newChart));
  }

  void updateChartPortfolioValues(Portfolio p) {
    final newChart = chart.copyWith(
      sym: 'Investing',
      data: p.series,
      startValue: p.series.last.y,
      latestValue: p.meta!.totalValue,
    );
    chart = newChart;
    add(ChartUpdate(newChart));
  }
}
