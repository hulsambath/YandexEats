import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yandex_eats_clone/auth/cubit/auth_cubit.dart';
import 'package:yandex_eats_clone/auth/login/login.dart';

class SignupFooter extends StatelessWidget {
  const SignupFooter({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text('Already have an Accout? '),
        Tappable.faded(
          fadeStrength: FadeStrength.lg,
          child: Text(
            'Login',
            style: context.bodyMedium?.copyWith(fontWeight: FontWeight.bold),
          ),
          onTap: () => context.read<AuthCubit>().changeAuth(showLogin: true),
        ),
      ],
    );
  }
}
