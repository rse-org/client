import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_signin_button/button_list.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:go_router/go_router.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:rse/all.dart';

class ResultDialog extends StatefulWidget {
  final Result result;
  const ResultDialog({super.key, required this.result});

  @override
  State<ResultDialog> createState() => _ResultDialogState();
}

class _ResultDialogState extends State<ResultDialog> {
  String request = '';
  bool adError = false;
  bool isNotAuth = false;
  InterstitialAd? _interstitialAd;
  @override
  Widget build(BuildContext context) {
    if (request != '' && adError && isNotAuth) return _showLoginPrompt();
    return _show();
  }

  @override
  void initState() {
    super.initState();
    if (!kIsWeb) {
      _loadMobileInterstitialAd();
    }
    LocalStorageService.playSaveResult(widget.result);
    LocalStorageService.playIncrementCompleted();
  }

  logResult() {
    logEvent({'name': 'play_results_request', 'score': widget.result.score});
  }

  void onAdLoaded(ad) {
    ad.fullScreenContentCallback = FullScreenContentCallback(
      onAdDismissedFullScreenContent: (ad) {
        if (request == 'Exit') {
          _exit();
        } else if (request == 'Result') {
          logResult();
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
  }

  _buildAuthPrompt() {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        if (state is Authenticated) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              const Text('Thank you!'),
              const SizedBox(height: 20),
              IntrinsicHeight(
                child: Column(
                  children: [
                    const Spacer(),
                    IconButton(
                      iconSize: 40,
                      icon: const Icon(
                        Icons.exit_to_app,
                      ),
                      onPressed: () {
                        _buttonPress('Result');
                      },
                    ),
                    Text('Results', style: T(context, 'bodySmall'))
                  ],
                ),
              ),
            ],
          );
        }
        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            buildText(
              context,
              'headlineSmall',
              context.l.signup_message_google,
            ),
            const SizedBox(height: 20),
            SignInButton(
              Buttons.Google,
              text: context.l.signup_button_google,
              onPressed: () {
                BlocProvider.of<AuthBloc>(context).add(
                  GoogleSignInRequested(),
                );
              },
            ),
          ],
        );
      },
    );
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
                _buttonPress(title);
              },
            ),
            Text(title, style: T(context, 'bodySmall'))
          ],
        ),
      ),
    );
  }

  _buttonPress(r) {
    p(widget.result.toJson());
    setState(() {
      request = r;
    });
    if (kIsWeb) {
      if (r == 'Exit') {
        _exit();
      } else if (r == 'Result') {
        // Todo: Add prompt for account if not created yet.
        // Also show add on Web when Adsense done.
        logResult();
      } else if (r == 'Replay') {
        BlocProvider.of<PlayBloc>(context).add(PlayInitialized());
      }
    } else {
      if (adError) {
        p('Ad Error: No ad despite mobile $r', icon: 'e');
        if (r == 'Exit') {
          _exit();
        } else if (r == 'Result') {
          logResult();
          if (FirebaseAuth.instance.currentUser != null) {
            BlocProvider.of<PlayBloc>(context).add(PlayInitial());
            BlocProvider.of<NavBloc>(context).add(QuizResults());
            GoRouter.of(context).go('/play/result');
            BlocProvider.of<PlayBloc>(context)
                .add(PlayResultCalculated(widget.result));
          } else {
            setState(() {
              isNotAuth = true;
            });
          }
        } else if (r == 'Replay') {
          BlocProvider.of<PlayBloc>(context).add(PlayInitialized());
        }
      } else {
        _interstitialAd?.show();
      }
    }
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
        onAdLoaded: onAdLoaded,
        onAdFailedToLoad: (err) {
          p('Failed to load an interstitial ad: ${err.message}', icon: 'e');
          setState(() {
            adError = true;
          });
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
            ),
            SizedBox(
              height: 20,
              child: FutureBuilder(
                future: LocalStorageService.playCompletedCount(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return const SizedBox();
                  }
                  if (snapshot.connectionState == ConnectionState.done) {
                    return Text(
                      'Congrats on your ${snapshot.data} completed lessons!',
                    );
                  }
                  return const SizedBox();
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  _showLoginPrompt() {
    return Dialog(
      child: SizedBox(
        height: H(context) * .5,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Wrap(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: _buildAuthPrompt(),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
