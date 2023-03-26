import 'package:flutter/material.dart';
import 'package:space_x_demo/2_application/pages/launch_detail_page/launch_detail_page.dart';
import 'package:space_x_demo/2_application/pages/launch_list_page/launch_list_page.dart';

class AppRouter {
  Route? onGenerateRoute(RouteSettings routeSetting) {
    switch (routeSetting.name) {
      case '/home':
        return MaterialPageRoute(
          builder: (_) => const LaunchListWrapper(),
          settings: routeSetting,
        );
      case '/detail':
        final args = routeSetting.arguments as Map<String, dynamic>;
        return MaterialPageRoute(
          builder: (_) => LaunchDetailPageWrapper(args: args),
          settings: routeSetting,
        );
      default:
        return null;
    }
  }
}
