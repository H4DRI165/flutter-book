import 'package:auto_route/auto_route.dart';
import '../ui.dart';

part 'routes.gr.dart';

@AutoRouterConfig()
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
    
    AutoRoute(page: LandingRoute.page, initial: true),
    AutoRoute(page: MainMenuRoute.page),
    AutoRoute(page: ConstrainRoute.page),
  ];
}
