import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:rse/all.dart';

class ResultDialog extends StatefulWidget {
  final Result result;
  const ResultDialog({super.key, required this.result});

  @override
  State<ResultDialog> createState() => _ResultDialogState();
}

class _ResultDialogState extends State<ResultDialog> {
  InterstitialAd? _interstitialAd;
  String request = '';
  @override
  Widget build(BuildContext context) {
    return _show();
  }

  @override
  void initState() {
    super.initState();
    if (!kIsWeb) {
      _loadMobileInterstitialAd();
    }
  }

  _buildButton(title, icon) {
    return Expanded(
      child: IntrinsicHeight(
        child: Column(
          children: [
            const Spacer(),
            IconButton(
              iconSize: 40,
              icon: icon,
              onPressed: () {
                _showMobileAds(title);
              },
            ),
            Text(title, style: T(context, 'bodySmall'))
          ],
        ),
      ),
    );
  }

  _exit() {
    BlocProvider.of<PlayBloc>(context).add(PlayInitial());
    BlocProvider.of<NavBloc>(context).add(EndQuiz());
  }

  _getPromptFromGrade(grade) {
    String val;
    switch (grade) {
      case 'A':
        val = 'Excellent!';
        break;
      case 'B':
        val = 'Great!';
        break;
      case 'C':
        val = 'A for effort!';
        break;
      case 'D':
        val = 'Needs improvement!';
        break;
      default:
        val = 'Lost a lot';
    }
    return val;
  }

  _getStars(grade) {
    double val;
    switch (grade) {
      case 'A':
        val = 5;
        break;
      case 'B':
        val = 4;
        break;
      case 'C':
        val = 3;
        break;
      case 'D':
        val = 2;
        break;
      default:
        val = 1;
    }
    return val;
  }

  void _loadMobileInterstitialAd() {
    InterstitialAd.load(
      adUnitId: AdHelper.interstitialAdUnitId,
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) {
          ad.fullScreenContentCallback = FullScreenContentCallback(
            onAdDismissedFullScreenContent: (ad) {
              if (request == 'Exit') {
                _exit();
              } else if (request == 'Result') {
                logResultsRequest(widget.result);
                _interstitialAd?.dispose();
                haltAndFire(milliseconds: 100, fn: _loadMobileInterstitialAd);
              } else if (request == 'Replay') {
                _interstitialAd?.dispose();
                haltAndFire(milliseconds: 100, fn: _loadMobileInterstitialAd);
                BlocProvider.of<PlayBloc>(context).add(PlayInitialized());
              }
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

  _show() {
    final r = widget.result;
    final score = r.score.toStringAsFixed(2);
    return Dialog(
      child: SizedBox(
        height: H(context) * .5,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      '${_getPromptFromGrade(r.grade)}',
                      style: T(context, 'displaySmall'),
                    ),
                    RatingBarIndicator(
                      itemCount: 5,
                      itemSize: 50.0,
                      rating: _getStars(r.grade),
                      direction: Axis.horizontal,
                      unratedColor: Colors.amber.withAlpha(50),
                      itemBuilder: (context, index) => const Icon(
                        Icons.star,
                        color: Colors.amber,
                      ),
                    ),
                    Text(
                      '$score%',
                      style: const TextStyle(fontSize: 25),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                _buildButton(
                  'Exit',
                  const Icon(
                    Icons.exit_to_app,
                  ),
                ),
                _buildButton(
                  'Result',
                  const Icon(
                    Icons.description,
                  ),
                ),
                _buildButton(
                  'Replay',
                  const Icon(
                    Icons.replay,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  _showAd() {
    if (!kIsWeb) _interstitialAd?.show();
  }

  _showMobileAds(r) {
    if (kIsWeb) {
      if (r == 'Exit') {
        _exit();
      } else if (r == 'Result') {
        logResultsRequest(widget.result);
      } else if (r == 'Replay') {
        BlocProvider.of<PlayBloc>(context).add(PlayInitialized());
      }
    }
    setState(() {
      request = r;
    });
    _showAd();
  }
}
