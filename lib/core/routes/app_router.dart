import 'package:auto_route/auto_route.dart';
import 'package:trinity_lecture_app/core/routes/app_router.gr.dart';

@AutoRouterConfig()
class AppRouter extends $AppRouter {
  @override
  List<AutoRoute> routes = [
    AutoRoute(page: SplashRoute.page, initial: true),
    AutoRoute(page: CalcRoute.page)
  ];
}
