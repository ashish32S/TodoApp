import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todoapps/addTodo.dart';
import 'package:todoapps/todoList.dart';
import 'package:url_launcher/url_launcher.dart';

class Mainscreen extends StatefulWidget {
  const Mainscreen({super.key});

  @override
  State<Mainscreen> createState() => _MainscreenState();
}

class _MainscreenState extends State<Mainscreen> {
  List<String> todolist = ["qedff"];
  void addTodo({required String todotext}) {
    if (todolist.contains(todotext)) {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text("Todo Already Exist"),
              content: const Text("this todo data alerdy exits"),
              actions: [
                InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: const Text("Close"))
              ],
            );
          });
      return;
    }

    setState(() {
      todolist.insert(0, todotext);
    });
    updateLocalData();
    Navigator.pop(context);
  }

  void updateLocalData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('todolist', todolist);
  }

  void loadData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    todolist = (prefs.getStringList('todolist') ?? []).toList();
    setState(() {});
  }

  void showAddButton() {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Padding(
            padding: MediaQuery.of(context).viewInsets,
            child: Container(
              padding: const EdgeInsets.all(20),
              height: 300,
              child: Addtodo(addTodo: addTodo),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
          shape: const CircleBorder(),
          backgroundColor: Colors.blueGrey[900],
          // ignore: sort_child_properties_last
          child: const Icon(
            Icons.add,
            color: Colors.white,
          ),
          onPressed: showAddButton),
      drawer: Drawer(
          child: Column(
        children: [
          Container(
            color: Colors.blueGrey,
            height: 180,
            width: double.infinity,
            child: const Center(
                child: Text(
              "Todo App",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                  fontWeight: FontWeight.bold),
            )),
          ),
          ListTile(
            onTap: () {
              launchUrl(Uri.parse("https://www.linkedin.com/in/ashish32/"));
            },
            leading: const Icon(Icons.person),
            title: const Text(
              "About Me",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          ListTile(
            onTap: () {
              launchUrl(Uri.parse("mailto: ashishsingh923692@gmail.com"));
            },
            leading: const Icon(Icons.email),
            title: const Text(
              "Contant Me",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ],
      )),
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Todo App ',
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
        ),
      ),
      body: TodoListBulder(
        todolist: todolist,
        updateLocalData: updateLocalData,
      ),
    );
  }
}
