import 'package:flutter/material.dart';
import 'package:flutter_bloc_boilerplate/src/statics/router.dart';
import 'package:flutter_bloc_boilerplate/src/statics/routes.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      onGenerateRoute: Router.generateRoute,
      initialRoute: Routes.home,
    );
  }
}