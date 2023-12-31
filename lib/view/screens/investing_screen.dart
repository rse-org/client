import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rse/all.dart';

class InvestingScreen extends StatefulWidget {
  final String title;

  const InvestingScreen({Key? key, required this.title}) : super(key: key);

  @override
  InvestingScreenState createState() => InvestingScreenState();
}

class InvestingScreenState extends State<InvestingScreen>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
      mobile: _buildTabContainer(context),
      desktop: _buildTabContainer(context),
    );
  }

  SingleChildScrollView buildSingleChildScrollView(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          // ignore: prefer_const_constructors
          if (kIsWeb) WebAd(type: 'display'),
          BlocConsumer<PortfolioBloc, PortfolioState>(
            builder: (context, state) {
              if (state is PortfolioLoading) {
                return const CircularProgressIndicator();
              } else if (state is PortfolioLoadedSuccess) {
                final p = state.portfolio;
                return Column(
                  children: [
                    InvestmentGroup(
                        title: context.l.stocks,
                        num: p.stocks != null ? p.stocks!.length : 0,
                        securities: p.stocks != null ? p.stocks! : []),
                    InvestmentGroup(
                        title: context.l.crypto,
                        num: p.cryptos != null ? p.cryptos!.length : 0,
                        securities: p.cryptos != null ? p.cryptos! : []),
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
    );
  }

  @override
  void initState() {
    super.initState();
    setScreenName('/investing');
  }

  Widget _buildTabContainer(BuildContext context) {
    getTextSize() {
      if (isS(context)) {
        return 14.0;
      } else if (isM(context)) {
        return 13.0;
      } else {
        return 12.0;
      }
    }

    return DefaultTabController(
      length: 1,
      child: Column(
        children: [
          TabBar(
            isScrollable: isS(context),
            labelStyle: TextStyle(
              fontSize: getTextSize(),
              fontWeight: FontWeight.w600,
            ),
            tabs: [
              Tab(text: context.l.investing),
              // Tab(text: context.l.spending),
              // Tab(text: context.l.crypto),
              // Tab(text: context.l.transfers),
            ],
          ),
          Expanded(
            child: TabBarView(
              children: [
                buildSingleChildScrollView(context),
                // Text(context.l.spending),
                // Text(context.l.investing),
                // Text(context.l.transfers),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
