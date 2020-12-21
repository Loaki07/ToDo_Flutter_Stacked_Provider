import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:todo_flutter_stacked_provider/app/routes/router.gr.dart';
import 'package:todo_flutter_stacked_provider/app/locator.dart';
import 'package:todo_flutter_stacked_provider/model/todo_model.dart';

class HomeViewModel extends FutureViewModel<List<ToDoModel>> {
  final Box<ToDoModel> todosBox = Hive.box('todosTry2');
  final _todos = <ToDoModel>[];

  List<ToDoModel> get todos => _todos;

  String input;
  final NavigationService _navigationService = locator<NavigationService>();
  final DialogService _dialogService = locator<DialogService>();

  void addToDo() {
    ToDoModel newTodo = ToDoModel(todo: input, isChecked: false);
    todosBox.add(newTodo);
    _todos.add(newTodo);
    _navigationService.back();
    notifyListeners();
  }

  void setCheckBoxToTrue(int index, bool newValue) {
    _todos[index].isChecked = newValue;
    final item = todosBox.getAt(index);
    print(item);
    todosBox.putAt(index, _todos[index]);
    print(_todos[index].isChecked);
    notifyListeners();
  }

  @override
  void onData(List<ToDoModel> data) {
    super.onData(data);
    _todos.addAll(data);
    _todos.sort((a, b) {
      if (!b.isChecked) {
        return 1;
      }
      return -1;
    });
    print("sorted data $_todos");
    notifyListeners();
  }

  Future<List<ToDoModel>> _getDataFromServer() async {
    // MAKE ACTUAL API REQUEST HERE
    await Future.delayed(const Duration(seconds: 2));
    const stimulateError = false;
    if (stimulateError) {
      throw Exception("Error occoured during the API request");
    }
    List<ToDoModel> dataFromHive = todosBox.values.toList();
    print('data from hive $dataFromHive');
    return dataFromHive;
  }

  @override
  Future<List<ToDoModel>> futureToRun() {
    // Get data from the server
    return _getDataFromServer();
  }

  @override
  void onError(error) {
    super.onError(error);
    _dialogService.showDialog(title: 'Error from DB', description: error);
    error ?? Error();
  }
}
