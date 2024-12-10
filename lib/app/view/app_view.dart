import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:yandex_eats_clone/home/view/home_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
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
      home: const MyHomePage(
        title: 'kdet',
      ),
    );
  }
}
