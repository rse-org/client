import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:rse/all.dart';

class AdInterstitial extends StatefulWidget {
  final Function onPress;
  const AdInterstitial({super.key, required this.onPress});

  @override
  State<AdInterstitial> createState() => _AdInterstitialState();
}

class _AdInterstitialState extends State<AdInterstitial> {
  InterstitialAd? _interstitialAd;

  @override
  Widget build(BuildContext context) {
    p('AdInterstitial', icon: '🏦');
    return Column(
      children: [
        IconButton(
          iconSize: 40,
          icon: const Icon(
            Icons.description,
          ),
          onPressed: () {
            widget.onPress();
            _interstitialAd?.show();
          },
        ),
        Text('Results', style: T(context, 'bodySmall'))
      ],
    );
  }

  @override
  void dispose() {
    _interstitialAd?.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _loAdInterstitialAd();
  }

  void _loAdInterstitialAd() {
    InterstitialAd.load(
      adUnitId: AdHelper.interstitialAdUnitId,
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) {
          ad.fullScreenContentCallback = FullScreenContentCallback(
            onAdDismissedFullScreenContent: (ad) {
              _moveToHome();
            },
          );

          setState(() {
            _interstitialAd = ad;
          });
        },
        onAdFailedToLoad: (err) {
          p('Failed to load an interstitial ad: ${err.message}');
        },
      ),
    );
  }

  _moveToHome() {
    BlocProvider.of<PlayBloc>(context).add(PlayInitial());
    BlocProvider.of<NavBloc>(context).add(EndQuiz());
  }
}
