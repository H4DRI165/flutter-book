import 'package:auto_route/auto_route.dart';
import '../ui.dart';

part 'routes.gr.dart';

@AutoRouterConfig()
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
    AutoRoute(page: LandingRoute.page, initial: true),
    AutoRoute(page: LoginRoute.page),
    AutoRoute(page: ForgotPasswordRoute.page),
    AutoRoute(page: MainMenuRoute.page),
    AutoRoute(page: ConstrainIntroRoute.page),
    AutoRoute(page: ConstrainTightRoute.page),
  ];
}
