import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';

Future<void> boostrap(FutureOr<Widget> Function() builder) async {
  await runZonedGuarded(
    () async {
      WidgetsFlutterBinding.ensureInitialized();
      runApp(
        await builder(),
      );
    },
    (error, stackTrace) {
      log(
        '$error',
        name: 'Error',
        stackTrace: stackTrace,
      );
    },
  );
}
