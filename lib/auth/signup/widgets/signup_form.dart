import 'dart:developer';

import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_field/form_field.dart';
import 'package:yandex_eats_clone/auth/signup/cubit/signup_cubit.dart';

class SignupForm extends StatefulWidget {
  const SignupForm({super.key});

  @override
  State<SignupForm> createState() => _SignupFormState();
}

class _SignupFormState extends State<SignupForm> {
  final _formKey = GlobalKey<ShadFormState>();

  late ValueNotifier<bool> _obscure;

  @override
  void initState() {
    super.initState();
    _obscure = ValueNotifier(true);
  }

  @override
  void dispose() {
    _obscure.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = context.select(
      (SignUpCubit cubit) => cubit.state.submissionStatus.isLoading,
    );

    return ShadForm(
      key: _formKey,
      enabled: !isLoading,
      child: ConstrainedBox(
        constraints: const BoxConstraints(
          maxWidth: 350,
        ),
        child: Column(
          children: [
            ShadInputFormField(
              id: 'email',
              prefix: const Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: AppSpacing.sm,
                  vertical: AppSpacing.sm,
                ),
                child: Icon(
                  LucideIcons.mail,
                  size: AppSpacing.lg,
                ),
              ),
              decoration: const ShadDecoration(
                secondaryBorder: ShadBorder.none,
                secondaryErrorBorder: ShadBorder.none,
                secondaryFocusedBorder: ShadBorder.none,
              ),
              onPressedOutside: (event) => FocusScope.of(context).unfocus(),
              label: const Text('Email'),
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.next,
              placeholder: const Text('Enter your email'),
              validator: (value) {
                final email = Email.dirty(value);

                return email.errorMessage;
              },
            ),
            const SizedBox(height: AppSpacing.md),
            ShadInputFormField(
              id: 'username',
              prefix: const Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: AppSpacing.sm,
                  vertical: AppSpacing.sm,
                ),
                child: Icon(
                  LucideIcons.user,
                  size: AppSpacing.lg,
                ),
              ),
              decoration: const ShadDecoration(
                secondaryBorder: ShadBorder.none,
                secondaryErrorBorder: ShadBorder.none,
                secondaryFocusedBorder: ShadBorder.none,
              ),
              onPressedOutside: (event) => FocusScope.of(context).unfocus(),
              label: const Text('Username'),
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.next,
              placeholder: const Text('Enter your username'),
              validator: (value) {
                final email = Username.dirty(value);

                return email.errorMessage;
              },
            ),
            const SizedBox(height: AppSpacing.md),
            ValueListenableBuilder(
              valueListenable: _obscure,
              builder: (context, obscure, child) {
                return ShadInputFormField(
                  id: 'password',
                  decoration: const ShadDecoration(
                    secondaryBorder: ShadBorder.none,
                    secondaryErrorBorder: ShadBorder.none,
                    secondaryFocusedBorder: ShadBorder.none,
                  ),
                  prefix: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: AppSpacing.sm),
                    child: ShadImage.square(
                      LucideIcons.lock,
                      size: AppSpacing.lg,
                    ),
                  ),
                  suffix: ShadButton.ghost(
                    size: ShadButtonSize.sm,
                    width: AppSpacing.xlg + AppSpacing.sm,
                    height: AppSpacing.xlg,
                    padding: EdgeInsets.zero,
                    onPressed: () {
                      _obscure.value = !_obscure.value;
                    },
                    icon: ShadImage.square(
                      obscure ? LucideIcons.eye : LucideIcons.eyeOff,
                      size: AppSpacing.xlg,
                    ),
                  ),
                  onPressedOutside: (event) => FocusScope.of(context).unfocus(),
                  label: const Text('Password'),
                  keyboardType: TextInputType.visiblePassword,
                  textInputAction: TextInputAction.done,
                  placeholder: const Text('Enter your password'),
                  obscureText: obscure,
                  validator: (value) {
                    final password = Password.dirty(value);
                    return password.errorMessage;
                  },
                );
              },
            ),
            const SizedBox(height: AppSpacing.xxlg),
            BlocBuilder<SignUpCubit, SignUpState>(
              builder: (context, state) {
                final isLoading = state.submissionStatus.isLoading;
                return ShadButton(
                  width: double.maxFinite,
                  enabled: !isLoading,
                  mainAxisAlignment: MainAxisAlignment.center,
                  icon: !isLoading
                      ? const SizedBox.shrink()
                      : const SizedBox.square(
                          dimension: AppSpacing.lg,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                          ),
                        ),
                  onPressed: isLoading
                      ? null
                      : () {
                          if (!(_formKey.currentState?.saveAndValidate() ??
                              false)) {
                            return;
                          }

                          final fields = _formKey.currentState!.value;
                          final email = fields['email'] as String;
                          final username = fields['username'] as String;
                          final password = fields['password'] as String;

                          log('Email: $email');
                          log('Username: $username');
                          log('Password: $password');

                          context.read<SignUpCubit>().onSubmit(
                                email: email,
                                username: username,
                                password: password,
                              );
                        },
                  child: Text(isLoading ? '' : 'Sign Up'),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
