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
    if (isS(context)) {
      return const EdgeInsets.all(5);
    } else if (isM(context)) {
      return const EdgeInsets.all(5);
    } else if (isL(context)) {
      return const EdgeInsets.all(30);
    } else {
      return const EdgeInsets.all(40);
    }
  }

  getWidth(context) {
    var w = W(context);
    if (isS(context)) {
      return w * .1;
    } else if (isM(context)) {
      return w * .3;
    } else if (isL(context)) {
      return w * .3;
    } else {
      return w * .25;
    }
  }
}
