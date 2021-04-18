import 'package:flutter/material.dart';
import './main.dart';
import './details_page.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      case '/':
        return MaterialPageRoute(
            builder: (_) =>
                MyHomePage()); //prebuilt page route krote hole => nahole direct function body
      case '/details':
        if (args is String) {
          return MaterialPageRoute(
              builder: (_) => DetailsPage(
                    args,
                  ));
        }
        return _errorRoute();

      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Error Route Not Found'),
        ),
        body: Center(
          child: Text('Error'),
        ),
      );
    });
  }
}
