import 'dart:developer' as dev;

import 'package:firebase_authentication_client/firebase_authentication_client.dart';
import 'package:token_storage/token_storage.dart';
import 'package:user_repository/user_repository.dart';
import 'package:yandex_eats_clone/app/app.dart';
import 'package:yandex_eats_clone/boostrap.dart';

void main() async {
  await boostrap(() async {
    final tokenStorage = InMemoryTokenStorage();
    final firebaseAuthenticationClient = FirebaseAuthenticationClient(
      tokenStorage: tokenStorage,
    );

    final userRepository = UserRepository(
      authenticationClient: firebaseAuthenticationClient,
    );

    dev.log('${(await userRepository.user.first).email}');

    return App(
      userRepository: userRepository,
    );
  });
}
