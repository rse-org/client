import 'package:flutter/material.dart';
import 'package:rse/all.dart';

class Watchlist extends StatelessWidget {
  final List<Watch> watched;
  const Watchlist({super.key, required this.watched});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: SizedBox(
        width: getWidth(context),
        height: H(context),
        child: Container(
          margin: getMargin(context),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(width: 2, color: C(context, 'outline')),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                child: ScrollConfiguration(
                  behavior: ScrollConfiguration.of(context)
                      .copyWith(scrollbars: false),
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: watched.length,
                    itemBuilder: (BuildContext context, int index) {
                      final item = watched[index];
                      return WatchItem(item);
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  getMargin(context) {
    double val;
    if (isS(context)) {
      val = 5;
    } else if (isM(context)) {
      val = 5;
    } else if (isL(context)) {
      val = 30;
    } else {
      val = 40;
    }
    return EdgeInsets.all(val);
  }

  getWidth(context) {
    double val;
    if (isS(context)) {
      val = .1;
    } else if (isM(context)) {
      val = .3;
    } else if (isL(context)) {
      val = .3;
    } else {
      val = .25;
    }
    return W(context) * val;
  }
}
