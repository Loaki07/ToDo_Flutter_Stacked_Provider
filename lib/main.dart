import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:todo_flutter_stacked_provider/app/locator.dart';
import 'package:todo_flutter_stacked_provider/app/routes/router.gr.dart'
    as AutoRouter;
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:todo_flutter_stacked_provider/model/todo_model.dart';

void main() async {
  // var appDocumentDirectory;
  WidgetsFlutterBinding.ensureInitialized();
  // if (kIsWeb) {
  //   // Set web-specific directory
  // } else {
  //   appDocumentDirectory =
  //       await path_provider.getApplicationDocumentsDirectory();
  // }
  setupLocator();
  Hive.initFlutter();
  Hive.registerAdapter(ToDoModelAdapter());
  await Hive.openBox<ToDoModel>('todosTry2');
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // final todosBox = Hive.box('todos');
    return MaterialApp(
      title: 'To Do App',
      initialRoute: AutoRouter.Routes.homeView,
      onGenerateRoute: AutoRouter.Router().onGenerateRoute,
      navigatorKey: locator<NavigationService>().navigatorKey,
    );
  }
}
