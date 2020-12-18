import 'package:hive/hive.dart';
part 'todo_model.g.dart';

@HiveType(typeId: 1)
class ToDoModel extends HiveObject {
  @HiveField(0)
  final String todo;
  @HiveField(1)
  bool isChecked;

  ToDoModel({this.todo, this.isChecked});

  @override
  String toString() {
    return todo;
  }

  toJson() => {"todo": this.todo, "isChecked": this.isChecked};
}
