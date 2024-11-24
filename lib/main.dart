import 'dart:async';
import 'package:starter_template/job.dart';

// This Appwrite function will be executed every time your function is triggered
Future<dynamic> main(final context) async {
  try {
    await run(context);
    return context.res.json({"code": 200});
  } catch (e) {
    context.log('$e', error: e);
    return context.res.json({
      "error": {"code": 500, "message": "$e"}
    });
  }
}
