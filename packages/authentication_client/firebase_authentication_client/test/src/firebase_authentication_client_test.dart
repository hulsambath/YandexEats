// ignore_for_file: prefer_const_constructors

import 'package:firebase_authentication_client/firebase_authentication_client.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:token_storage/token_storage.dart';

void main() {
  group('FirebaseAuthenticationClient', () {
    test('can be instantiated', () {
      expect(
        FirebaseAuthenticationClient(tokenStorage: InMemoryTokenStorage()),
        isNotNull,
      );
    });
  });
}
