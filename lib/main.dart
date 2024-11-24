import 'dart:async';
import 'dart:developer';

import 'package:starter_template/job.dart';

// This Appwrite function will be executed every time your function is triggered
Future<dynamic> main(final context) async {
  try {
    await run();
  } catch (e) {
    log('$e', error: e);
  }
}
