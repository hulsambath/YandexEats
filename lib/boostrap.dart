import 'dart:async';
import 'dart:developer';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:yandex_eats_clone/auth/login/login.dart';

Future<void> boostrap(FutureOr<Widget> Function() builder) async {
  await runZonedGuarded(
    () async {
      WidgetsFlutterBinding.ensureInitialized();
      SystemUiOverlayTheme.setPortraitOrientation();

      await Firebase.initializeApp();
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
