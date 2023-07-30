import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:rse/all.dart';

class AdInterstitial extends StatefulWidget {
  final Widget child;
  final bool show;
  const AdInterstitial({super.key, required this.child, required this.show});

  @override
  State<AdInterstitial> createState() => _AdInterstitialState();
}

class _AdInterstitialState extends State<AdInterstitial> {
  InterstitialAd? _interstitialAd;

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }

  @override
  void dispose() {
    _interstitialAd?.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _loadInterstitialAd();
  }

  // @override
  void onGameOver() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Game over!'),
          content: const Text('Score: 5/5'),
          actions: [
            ElevatedButton(
              child: Text('close'.toUpperCase()),
              onPressed: () {
                if (_interstitialAd != null) {
                  _interstitialAd?.show();
                } else {
                  _moveToHome();
                }
              },
            ),
          ],
        );
      },
    );
  }

  void _loadInterstitialAd() {
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
