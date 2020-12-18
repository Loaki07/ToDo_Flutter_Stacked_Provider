import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:todo_flutter_stacked_provider/app/routes/router.gr.dart';
import 'package:todo_flutter_stacked_provider/app/locator.dart';
import 'package:todo_flutter_stacked_provider/model/todo_model.dart';

class HomeViewModel extends FutureViewModel<List<ToDoModel>> {
  final _todos = <ToDoModel>[];

  List<ToDoModel> get todos => _todos;

  String input;
  bool isChecked = false;
  final NavigationService _navigationService = locator<NavigationService>();

  void addToDo() {
    _todos.add(ToDoModel(todo: input, isChecked: false));
    notifyListeners();
  }

  void setCheckBoxToTrue(bool newValue) {
    isChecked = newValue;
    notifyListeners();
  }

  @override
  void onData(List<ToDoModel> data) {
    super.onData(data);
    print(data);
    _todos.addAll(data);
    notifyListeners();
  }

  Future<List<ToDoModel>> getDataFromServer() async {
    // MAKE ACTUAL API REQUEST HERE
    await Future.delayed(const Duration(seconds: 2));
    const stimulateError = true;
    if (stimulateError) {
      throw Exception("Error occoured during the API request");
    }
    return [
      ToDoModel(todo: 'Item1', isChecked: false),
      ToDoModel(todo: 'Item2', isChecked: false),
      ToDoModel(todo: 'Item2', isChecked: true),
    ];
  }

  @override
  Future<List<ToDoModel>> futureToRun() {
    // Get data from the server
    return getDataFromServer();
  }
}
