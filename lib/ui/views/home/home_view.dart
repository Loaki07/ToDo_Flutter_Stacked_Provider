import 'dart:js';

import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:todo_flutter_stacked_provider/ui/views/home/home_viewmodel.dart';

class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeViewModel>.reactive(
      builder: (context, model, child) => Scaffold(
        appBar: AppBar(
          title: const Text('To Do\'s'),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            print("From HomeView");
            print(model.data);
            print(model.todos);
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: Text('Add Todolist'),
                  content: TextField(
                    onChanged: (String value) {
                      model.input = value;
                    },
                  ),
                  actions: <Widget>[
                    FlatButton(
                      onPressed: model.addToDo,
                      child: Text('Add'),
                    )
                  ],
                );
              },
            );
          },
          child: Icon(
            Icons.add,
            color: Colors.white,
          ),
        ),
        body: Center(
          child: ListView.builder(
            itemCount: model.todos.length,
            itemBuilder: (context, index) {
              return Dismissible(
                key: Key(model.todos[index].todo.toString()),
                child: Card(
                  elevation: 4,
                  margin: EdgeInsets.all(8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: ListTile(
                    title: Text(model.todos[index].todo.toString()),
                    leading: Checkbox(
                      value: model.isChecked,
                      activeColor: Colors.green,
                      onChanged: model.setCheckBoxToTrue,
                    ),
                    trailing: IconButton(
                      icon: Icon(
                        Icons.delete,
                        color: Colors.red,
                      ),
                      onPressed: null,
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
      viewModelBuilder: () => HomeViewModel(),
    );
  }
}
