import 'package:flutter/material.dart';

// ignore: must_be_immutable
class TodoListBulder extends StatefulWidget {
  List<String> todolist;
  void Function() updateLocalData;
  TodoListBulder(
      {super.key, required this.todolist, required this.updateLocalData});

  @override
  State<TodoListBulder> createState() => _TodoListBulderState();
}

class _TodoListBulderState extends State<TodoListBulder> {
  void oneItemClicked({required int index}) {
    showModalBottomSheet(
        context: context,
        builder: (content) {
          return Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            child: ElevatedButton(
                onPressed: () {
                  setState(() {
                    widget.todolist.removeAt(index);
                  });
                  widget.updateLocalData();
                  Navigator.pop(context);
                },
                child: const Text("Mark as Done")),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return (widget.todolist.isEmpty)
        ? const Center(child: Text("No data in you Todo List"))
        : ListView.builder(
            itemCount: widget.todolist.length,
            itemBuilder: (BuildContext content, int index) {
              return Dismissible(
                key: UniqueKey(),
                background: Container(
                  color: Colors.green,
                  child: const Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Icon(Icons.check),
                      ),
                    ],
                  ),
                ),
                secondaryBackground: Container(
                  color: Colors.red,
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Icon(Icons.delete),
                      ),
                    ],
                  ),
                ),
                onDismissed: (direction) {
                  setState(() {
                    widget.todolist.removeAt(index);
                  });
                  widget.updateLocalData();
                },
                child: ListTile(
                  onTap: () {
                    oneItemClicked(index: index);
                  },
                  title: Text(
                    widget.todolist[index],
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                ),
              );
            });
  }
}
