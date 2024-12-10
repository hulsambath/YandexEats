import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_repository/user_repository.dart';
import 'package:yandex_eats_clone/auth/login/login.dart';
import 'package:yandex_eats_clone/auth/signup/cubit/signup_cubit.dart';
import 'package:yandex_eats_clone/auth/signup/signup.dart';
import 'package:yandex_eats_clone/auth/signup/widgets/signup_footer.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SignUpCubit(
        userRepository: context.read<UserRepository>(),
      ),
      child: const SignupView(),
    );
  }
}

class SignupView extends StatefulWidget {
  const SignupView({super.key});

  @override
  State<SignupView> createState() => _SignupViewState();
}

class _SignupViewState extends State<SignupView> {
  @override
  Widget build(BuildContext context) {
    return const AppScaffold(
      body: AppConstrainedScrollView(
        padding: EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.md,
        ),
        child: Column(
          children: [
            SizedBox(height: kTextTabBarHeight),
            SizedBox(height: AppSpacing.xlg),
            SignupForm(),
            Spacer(),
            SignupFooter(),
          ],
        ),
      ),
    );
  }
}
