import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_repository/user_repository.dart';
import 'package:yandex_eats_clone/app/view/app_view.dart';
import 'package:yandex_eats_clone/auth/signup/cubit/signup_cubit.dart';

class App extends StatelessWidget {
  const App({required this.userRepository, super.key});

  final UserRepository userRepository;

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider.value(
          value: userRepository,
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (_) => SignUpCubit(userRepository: userRepository),
          ),
          BlocProvider(
            create: (_) => SignUpCubit(userRepository: userRepository),
          ),
        ],
        child: const AppView(),
      ),
    );
  }
}
