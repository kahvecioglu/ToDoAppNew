import 'package:flutter/material.dart';
import 'package:todo_app_new/my_button.dart';

class DialogBox extends StatelessWidget {
  final controllerDialog;
  VoidCallback onSave;
  VoidCallback onCancel;
  DialogBox(
      {super.key,
      required this.controllerDialog,
      required this.onSave,
      required this.onCancel});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Container(
        height: 150,
        child:
            Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          TextField(
            controller: controllerDialog,
            decoration: InputDecoration(
                border: OutlineInputBorder(), hintText: "Add a new task"),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              MyButton(text: "Save", onPressed: onSave),
              SizedBox(
                width: 10,
              ),
              MyButton(text: "Cancel", onPressed: onCancel)
            ],
          )
        ]),
      ),
      backgroundColor: Colors.yellow,
    );
  }
}
