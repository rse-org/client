// ignore: avoid_web_libraries_in_flutter
import 'dart:html' as html;
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:rse/all.dart';

String adArticleHtml = '''
<script async src="https://pagead2.googlesyndication.com/pagead/js/adsbygoogle.js?client=ca-pub-4473907527318574"
     crossorigin="anonymous"></script>
<ins class="adsbygoogle"
     style="display:block; text-align:center;"
     data-ad-layout="in-article"
     data-ad-format="fluid"
     data-ad-client="ca-pub-4473907527318574"
     data-ad-slot="9723705210"></ins>
<script>
     (adsbygoogle = window.adsbygoogle || []).push({});
</script>
''';

String adDisplayHtml = '''
<script async src="https://pagead2.googlesyndication.com/pagead/js/adsbygoogle.js?client=ca-pub-4473907527318574"
     crossorigin="anonymous"></script>
<!-- Display Ad Unit -->
<ins class="adsbygoogle"
     style="display:block"
     data-ad-client="ca-pub-4473907527318574"
     data-ad-slot="8602195236"
     data-ad-format="auto"
     data-full-width-responsive="true"></ins>
<script>
     (adsbygoogle = window.adsbygoogle || []).push({});
</script>
''';

String adFeedHtml = '''
<script async src="https://pagead2.googlesyndication.com/pagead/js/adsbygoogle.js?client=ca-pub-4473907527318574"
     crossorigin="anonymous"></script>
<ins class="adsbygoogle"
     style="display:block"
     data-ad-format="fluid"
     data-ad-layout-key="-ef+6k-30-ac+ty"
     data-ad-client="ca-pub-4473907527318574"
     data-ad-slot="7263077309"></ins>
<script>
     (adsbygoogle = window.adsbygoogle || []).push({});
</script>
''';

String adMultiplexHtml = '''
<script async src="https://pagead2.googlesyndication.com/pagead/js/adsbygoogle.js?client=ca-pub-4473907527318574"
     crossorigin="anonymous"></script>
<ins class="adsbygoogle"
     style="display:block"
     data-ad-format="autorelaxed"
     data-ad-client="ca-pub-4473907527318574"
     data-ad-slot="8410623548"></ins>
<script>
     (adsbygoogle = window.adsbygoogle || []).push({});
</script>
''';

String viewID = '388273837';

// ignore: must_be_immutable
class WebAd extends StatefulWidget {
  String type;
  WebAd({Key? key, required this.type}) : super(key: key);

  @override
  State<WebAd> createState() => _WebAdState();
}

class _WebAdState extends State<WebAd> {
  @override
  Widget build(BuildContext context) {
    ui.platformViewRegistry.registerViewFactory(
        viewID,
        (int id) => html.IFrameElement()
          ..style.width = '100%'
          ..style.height = '100%'
          ..srcdoc = getType()
          ..style.border = 'none');

    return SizedBox(
      height: 100,
      width: W(context),
      child: HtmlElementView(
        viewType: viewID,
      ),
    );
  }

  getType() {
    String val;
    switch (widget.type) {
      case 'article':
        val = adArticleHtml;
      case 'multi':
        val = adMultiplexHtml;
      case 'display':
        val = adDisplayHtml;
      default:
        val = adFeedHtml;
    }
    return val;
  }
}
