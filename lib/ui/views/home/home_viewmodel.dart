import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:todo_flutter_stacked_provider/app/routes/router.gr.dart';
import 'package:todo_flutter_stacked_provider/app/locator.dart';

class HomeViewModel extends BaseViewModel {
  List<String> _todos = ["Item1", "Item2", "Item3", "Item4", "Item5"];
  List<String> get todos => _todos;

  String input;
  final NavigationService _navigationService = locator<NavigationService>();

  void addToDo() {
    _todos.add(input);
    notifyListeners();
  }
}
