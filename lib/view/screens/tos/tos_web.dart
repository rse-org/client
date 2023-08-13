// ignore: avoid_web_libraries_in_flutter
import 'dart:html';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';

class TOS extends StatelessWidget {
  const TOS({super.key});
  @override
  Widget build(BuildContext context) {
    ui.platformViewRegistry.registerViewFactory(
        'hello-html',
        (int viewId) => IFrameElement()
          ..width = '640'
          ..height = '360'
          ..src = 'assets/tos.html'
          ..style.border = 'none');

    return Container(
      color: Colors.white,
      child: const Padding(
        padding: EdgeInsets.all(25),
        child: SizedBox(
          width: 640,
          height: 360,
          child: HtmlElementView(viewType: 'hello-html'),
        ),
      ),
    );
  }
}
