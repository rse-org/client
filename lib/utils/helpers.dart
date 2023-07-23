import 'dart:developer' as devtools show log;

import 'package:flutter/foundation.dart';

// Toggle print statements everywhere more easily.
// Sometimes we do need to see print statements in prod.
void p(v, {error = false}) {
  if (kDebugMode) {
    print('${error ? '❗️' : 'ℹ️'} $v');
  }
}

extension Log on Object {
  void log([String tag = '']) {
    devtools.log(toString(), name: tag);
  }
}
