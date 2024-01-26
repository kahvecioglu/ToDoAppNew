import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:todo_app_new/database.dart';
import 'package:todo_app_new/dialog_box.dart';
import 'package:todo_app_new/todo_tile.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // boxun referansı
  final _mybox = Hive.box("mybox");
  final _contoller = TextEditingController();
  ToDoDataBase db = ToDoDataBase();

  @override
  void initState() {
    // uygulama ilk açıldığında , varsayılan veriler oluşur
    if (_mybox.get("TODOLIST") == null) {
      db.createInitialData();
    } else {
      // mevcut veriler varsa
      db.loadData();
    }
    super.initState();
  }

  void checkBoxChanged(bool? value, int index) {
    setState(() {
      db.todolist[index][1] = !db.todolist[index][1];
    });
    db.uptadeDataBase();
  }

  void saveNewTask() {
    setState(() {
      db.todolist.add([_contoller.text, false]);
    });
    Navigator.of(context).pop();
    db.uptadeDataBase();
  }

  void CreatNewTask() {
    showDialog(
      context: context,
      builder: (context) {
        return DialogBox(
          controllerDialog: _contoller,
          onSave: saveNewTask,
          onCancel: () => Navigator.of(context).pop(),
        );
      },
    );
  }

  void deleteTask(int index) {
    setState(() {
      db.todolist.removeAt(index);
    });
    db.uptadeDataBase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.yellow[200],
        floatingActionButton: FloatingActionButton(
          onPressed: CreatNewTask,
          backgroundColor: Colors.yellow,
          child: Icon(Icons.add),
        ),
        appBar: AppBar(
          backgroundColor: Colors.yellow,
          title: Text("To Do"),
        ),
        body: ListView.builder(
          itemCount: db.todolist.length,
          itemBuilder: (context, index) {
            return ToDoTile(
              taskname: db.todolist[index][0],
              taskcompleted: db.todolist[index][1],
              onChanged: (value) => checkBoxChanged(value, index),
              deleteFunction: (context) {
                deleteTask(index);
              },
            );
          },
        ));
  }
}
