// ignore_for_file: prefer_const_constructors
import 'package:test/test.dart';
import 'package:token_storage/token_storage.dart';

void main() {
  group('TokenStorage', () {
    test('can be instantiated', () {
      expect(InMemoryTokenStorage(), isNotNull);
    });
  });
}