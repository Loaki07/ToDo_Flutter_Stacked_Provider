import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:stacked/stacked.dart';
import 'package:todo_flutter_stacked_provider/model/todo_model.dart';
import 'package:todo_flutter_stacked_provider/ui/views/home/home_viewmodel.dart';

class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeViewModel>.reactive(
      builder: (context, model, child) => FutureBuilder(
        future: Hive.openBox('todos'),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              return Text(snapshot.error.toString());
            } else {
              return Scaffold(
                appBar: AppBar(
                  title: const Text('To Do\'s'),
                ),
                floatingActionButton: FloatingActionButton(
                  onPressed: () {
                    // print("From HomeView");
                    // print(model.data);
                    // print(model.todos);
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
                      // final items = model.todos.map((item) {
                      //   const tempList = <ToDoModel>[];
                      //   if (!item.isChecked) {
                      //     tempList.add(item);
                      //   }
                      //   return tempList;
                      // }).toList();
                      final item = model.todos[index];
                      // print(items);
                      return Dismissible(
                        key: Key(item.todo.toString()),
                        child: Card(
                          elevation: 4,
                          margin: EdgeInsets.all(8),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: ListTile(
                            title: Text(item.todo.toString()),
                            leading: Checkbox(
                              value: item.isChecked,
                              activeColor: Colors.green,
                              onChanged: (value) =>
                                  model.setCheckBoxToTrue(index, value),
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
              );
            }
          } else {
            return Scaffold();
          }
        },
      ),
      viewModelBuilder: () => HomeViewModel(),
    );
  }
}
