import 'package:flutter/material.dart';
import 'DetailScreen.dart';
import 'todo.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  // Using a static list of todos for demonstration.
  List<Todo> todos = [
    Todo('Buy groceries', 'Milk, Bread, Eggs', false),
    Todo('Walk the dog', 'Take the dog for a walk in the park', false),
    Todo('Read a book', 'Finish reading "Flutter for Beginners', false),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // ตกแต่ง
      title: 'Todo App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.blue,
          foregroundColor: Colors.white,
        ),
      ),
      home: TodosScreen(todos: todos), // Passing list of todos to TodosScreen
    );
  }
}

class TodosScreen extends StatefulWidget {
  // Requiring the list of todos.
  const TodosScreen({super.key, required this.todos});
  final List<Todo> todos;

  @override
  State<TodosScreen> createState() => _TodosScreenState();
}

class _TodosScreenState extends State<TodosScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Todos')),
      //passing in the ListView.builder
      body: ListView.builder(
        itemCount: widget.todos.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(widget.todos[index].title),
            leading:
                widget.todos[index].isCompleted
                    ? Icon(Icons.check_circle, color: Colors.green)
                    : Icon(Icons.circle, color: Colors.grey),
            onTap: () async {
              final result = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DetailScreen(todo: widget.todos[index]),
                ),
              );
              setState(() {
                if (result == null) return; // If no result, do nothing
                widget.todos[index].isCompleted = result; // Reset completion status
              }); // Refresh the UI             
            },
          );
        },
      ),
    );
  }
}