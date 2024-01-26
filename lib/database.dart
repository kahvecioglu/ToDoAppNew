import 'package:hive/hive.dart';

class ToDoDataBase {
  List todolist = [];

  // boxumuzun referansı
  final _mybox = Hive.box("mybox");

  // bu uygulamayı ilk kez açıyorsanız bu yöntemi çalıştırır
  void createInitialData() {
    todolist = [
      ["Make tutorial", false],
      ["Do exercise", false]
    ];
  }

  // database den veri alır
  void loadData() {
    todolist = _mybox.get("TODOLIST");
  }

  // database yi günceller
  void uptadeDataBase() {
    _mybox.put("TODOLIST", todolist);
  }
}
