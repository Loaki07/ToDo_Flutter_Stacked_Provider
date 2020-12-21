import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo_flutter_stacked_provider/model/todo_model.dart';

Future setUpHive() async {
  Hive.initFlutter();
  Hive.registerAdapter(ToDoModelAdapter());
}
