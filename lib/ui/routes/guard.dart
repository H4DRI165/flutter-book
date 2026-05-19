import 'package:auto_route/auto_route.dart';

import '../../app.dart';

class AuthGuard extends AutoRouteGuard {
  AuthGuard({required this.authRepository});

  final AuthRepository authRepository;

  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) {
    if (authRepository.isLoggedIn) {
      resolver.next(true);
    } else {
      resolver.redirect(const LoginRoute());
    }
  }
}
