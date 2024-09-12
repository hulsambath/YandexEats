import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yandex_eats_clone/auth/cubit/auth_cubit.dart';
import 'package:yandex_eats_clone/auth/login/login.dart';

class LoginFooter extends StatelessWidget {
  const LoginFooter({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("Don't have an Accout? "),
        Tappable.faded(
          fadeStrength: FadeStrength.lg,
          child: Text(
            'Sign Up',
            style: context.bodyMedium?.copyWith(fontWeight: FontWeight.bold),
          ),
          onTap: () => context.read<AuthCubit>().changeAuth(showLogin: false),
        ),
      ],
    );
  }
}
