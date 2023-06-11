import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:rse/data/cubits/portfolio_cubit.dart';
import 'package:rse/presentation/widgets/all.dart';

class InvestingSummaryScreen extends StatefulWidget {
  final String title;

  const InvestingSummaryScreen({Key? key, required this.title}) : super(key: key);

  @override
  InvestingSummaryScreenState createState() => InvestingSummaryScreenState();
}

class InvestingSummaryScreenState extends State<InvestingSummaryScreen>
    with SingleTickerProviderStateMixin {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 200, vertical: 50),
        child: Center(
          child: Column(
            children: [
              BlocConsumer<PortfolioCubit, PortfolioState>(
                builder: (context, state) {
                  if (state is PortfolioLoading) {
                    return const CircularProgressIndicator();
                  } else if (state is PortfolioLoaded) {
                    final p = state.portfolio;
                    return Column(
                      children: [
                        InvestmentGroup(
                          title: 'Stocks',
                          current: p.current,
                          num: p.stocks.length,
                          securities: p.stocks
                        ),
                        InvestmentGroup(
                          title: 'Cryptos',
                          current: p.current,
                          num: p.cryptos.length,
                          securities: p.cryptos
                        ),
                      ],
                    );
                  } else if (state is PortfolioError) {
                    return Text('Error: ${state.errorMessage}');
                  } else {
                    return const Text('Unknown state');
                  }
                },
                listener: (context, state) {
                  // Listener logic goes here if needed
                },
                buildWhen: (previous, current) {
                  return true;
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

