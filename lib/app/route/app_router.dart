import 'package:go_router/go_router.dart';
import 'package:yandex_eats_clone/app/app.dart';
import 'package:yandex_eats_clone/auth/auth.dart';

class AppRouter {
  final router = GoRouter(
  initialLocation: '/auth',
    routes: [
      GoRoute(
        path: AppRoutes.auth.routes,
        name: AppRoutes.auth.name,
        builder: (context, state) => const AuthScreen(),
      ),
    ],
  );
}
