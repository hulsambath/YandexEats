import 'dart:developer';

import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_field/form_field.dart';
import 'package:yandex_eats_clone/auth/login/cubit/login_cubit.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<ShadFormState>();

  late ValueNotifier<bool> _obscure;

  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

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
      (LoginCubit cubit) => cubit.state.submissionStatus.isLoading,
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
              controller: email,
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
            ValueListenableBuilder(
              valueListenable: _obscure,
              builder: (context, obscure, child) {
                return ShadInputFormField(
                  id: 'password',
                  controller: password,
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
            BlocBuilder<LoginCubit, LoginState>(
              builder: (context, state) {
                return ShadButton(
                  width: double.maxFinite,
                  mainAxisAlignment: MainAxisAlignment.center,
                  icon: !isLoading
                      ? SizedBox.fromSize()
                      : const Padding(
                          padding: EdgeInsets.only(right: AppSpacing.md),
                          child: SizedBox.square(
                            dimension: AppSpacing.lg,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          ),
                        ),
                  onPressed: () {
                    if (!(_formKey.currentState?.saveAndValidate() ?? false)) {
                      return;
                    }

                    final fields = _formKey.currentState!.value;
                    final email = fields['email'] as String;
                    final password = fields['password'] as String;

                    log('Email: $email');
                    log('Password: $password');
                    context
                        .read<LoginCubit>()
                        .onSubmit(email: email, password: password);
                  },
                  child: Text(isLoading ? '' : 'Login'),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
