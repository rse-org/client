import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

const bool isWeb = kIsWeb;

bool isL(BuildContext context) {
  return MediaQuery.of(context).size.width <= 1366;
}

bool isM(BuildContext context) {
  return MediaQuery.of(context).size.width <= 820;
}

bool isS(BuildContext context) {
  return MediaQuery.of(context).size.width <= 431;
}

bool isXL(BuildContext context) {
  return MediaQuery.of(context).size.width > 1366;
}

class ResponsiveLayout extends StatelessWidget {
  final Widget mobile;
  final Widget desktop;

  const ResponsiveLayout(
      {super.key, required this.mobile, required this.desktop});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (isS(context)) {
          return Container(
            color: Colors.transparent,
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: mobile,
            ),
          );
        } else if (isM(context)) {
          return Container(
            color: Colors.transparent,
            child: Padding(padding: const EdgeInsets.all(10), child: desktop),
          );
        } else if (isL(context)) {
          return Container(
            color: Colors.transparent,
            child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 50, vertical: 10),
                child: desktop),
          );
        } else {
          return Container(
            color: Colors.transparent,
            child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 200, vertical: 10),
                child: desktop),
          );
        }
      },
    );
  }
}
