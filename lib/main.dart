import 'dart:async';
import 'dart:developer';

import 'package:starter_template/job.dart';

// This Appwrite function will be executed every time your function is triggered
Future<dynamic> main(final context) async {
  try {
    final result = await run();
    return context.res.json({"code": 200, "message": result});
  } catch (e) {
    log('$e', error: e);
    return context.res.json({
      "error": {"code": 500, "message": "$e"}
    });
  }
}
