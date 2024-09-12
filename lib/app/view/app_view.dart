import 'package:flutter/material.dart';
// import 'package:yandex_eats_clone/app/route/app_router.dart';
import 'package:yandex_eats_clone/auth/auth.dart';

class AppView extends StatelessWidget {
  const AppView({super.key});
  @override
  Widget build(BuildContext context) {
    // final route = AppRouter().router;

    return ShadApp.material(
      debugShowCheckedModeBanner: false,
      title: 'Yandex Eats Clone',
      themeMode: ThemeMode.system,
      theme: const AppTheme().theme,
      darkTheme: const AppDarkTheme().theme,
      materialThemeBuilder: (context, theme) {
        return theme.copyWith(
          appBarTheme: theme.appBarTheme.copyWith(
            surfaceTintColor: AppColors.transparent,
          ),
          textTheme: theme.brightness == Brightness.light
              ? const AppTheme().textTheme
              : const AppDarkTheme().textTheme,
          snackBarTheme: const SnackBarThemeData(
            behavior: SnackBarBehavior.floating,
          ),
          bottomNavigationBarTheme: const BottomNavigationBarThemeData(
            type: BottomNavigationBarType.fixed,
          ),
        );
      },
      home: const AuthScreen(),
    );
  }
}
