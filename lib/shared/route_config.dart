import 'package:find_my_ca/features/auth/auth.dart';
import 'package:go_router/go_router.dart';

final router = GoRouter(routes: [
  GoRoute(
    path: '/',
    builder: (context, state) => const Auth(),
  )
]);
