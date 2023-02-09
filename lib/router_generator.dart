import 'package:flutter/material.dart';

import 'screens/detail_item_screen.dart';
import 'screens/list_item_screen.dart';
import 'screens/splash_screen.dart';

class Routers {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case '/listItem':
        return MaterialPageRoute(builder: (_) => const ListItemScreen());
      case '/detailItem':
        return MaterialPageRoute(builder: (_) => const DetailItemScreen());
      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Error'),
        ),
        body: const Center(
          child: Text('ERROR'),
        ),
      );
    });
  }
}
