import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

// ignore: must_be_immutable
class Addtodo extends StatefulWidget {
  void Function({required String todotext}) addTodo;
  Addtodo({super.key, required this.addTodo});

  @override
  State<Addtodo> createState() => _AddtodoState();
}

class _AddtodoState extends State<Addtodo> {
  TextEditingController todotext = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text("Add Todo",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        TextField(
          onSubmitted: (value) {
            if (todotext.text.isNotEmpty) {
              widget.addTodo(todotext: todotext.text);
            }
            todotext.text = "";
          },
          autofocus: true,
          controller: todotext,
          decoration: const InputDecoration(
            contentPadding: EdgeInsets.all(10),
            hintText: "Enter your todo",
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(20.0)),
            ),
          ),
        ),
        ElevatedButton(
            onPressed: () {
              if (todotext.text.isNotEmpty) {
                widget.addTodo(todotext: todotext.text);
              }

              todotext.text = "";
            },
            child: const Text("Add",
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold)))
      ],
    );
  }
}
