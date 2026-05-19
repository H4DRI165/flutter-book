import 'package:auto_route/auto_route.dart';
import '../ui.dart';

export 'guard.dart';
export 'routes.gr.dart';

@AutoRouterConfig()
class AppRouter extends RootStackRouter {
  AppRouter({required this.authRepository});

  final AuthRepository authRepository;

  @override
  List<AutoRoute> get routes => [
    AutoRoute(page: SplashRoute.page, initial: true),
    AutoRoute(page: LandingRoute.page),
    AutoRoute(page: LoginRoute.page),
    AutoRoute(page: RegisterRoute.page),
    AutoRoute(page: ForgotPasswordRoute.page),

    AutoRoute(
      page: MainMenuRoute.page,
      guards: [AuthGuard(authRepository: authRepository)],
    ),
    AutoRoute(
      page: ConstrainIntroRoute.page,
      guards: [AuthGuard(authRepository: authRepository)],
    ),
    AutoRoute(
      page: ConstrainTightRoute.page,
      guards: [AuthGuard(authRepository: authRepository)],
    ),
    AutoRoute(
      page: ConstrainLooseRoute.page,
      guards: [AuthGuard(authRepository: authRepository)],
    ),
    AutoRoute(
      page: ConstrainUnboundedRoute.page,
      guards: [AuthGuard(authRepository: authRepository)],
    ),
  ];
}
