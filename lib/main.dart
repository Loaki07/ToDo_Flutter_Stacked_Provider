import 'package:flutter/material.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:todo_flutter_stacked_provider/app/locator.dart';
import 'package:todo_flutter_stacked_provider/app/routes/router.gr.dart'
    as AutoRouter;

void main() {
  setupLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'To Do App',
      initialRoute: AutoRouter.Routes.homeView,
      onGenerateRoute: AutoRouter.Router().onGenerateRoute,
      navigatorKey: locator<NavigationService>().navigatorKey,
    );
  }
}
