import 'package:flutter/material.dart';
import 'package:flutter_bloc_boilerplate/src/model/git_item.dart';
import 'package:flutter_bloc_boilerplate/src/presentation/details/details_page.dart';
import 'package:flutter_bloc_boilerplate/src/presentation/home/home_page.dart';
import 'package:flutter_bloc_boilerplate/src/statics/routes.dart';

class Router {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.home:
        return MaterialPageRoute(builder: (_) => HomePage.getLaunchPage());

      case Routes.details:
        var data = settings.arguments as GitItem;
        return MaterialPageRoute(builder: (_) => DetailsPage.getLaunchPage(data));

      default:
        return MaterialPageRoute(builder: (_) => HomePage.getLaunchPage());
    }
  }
}
