// ignore: file_names
import 'package:flutter/material.dart';
import 'todo.dart';

class DetailScreen extends StatelessWidget {
  // In the constructor, require a Todo.
  const DetailScreen({super.key, required this.todo});

  // Declare a field that holds the Todo.
  final Todo todo;

  @override
  Widget build(BuildContext context) {
    // Use the Todo to create the UI.
    return Scaffold(
      appBar: AppBar(title: Text(todo.title)),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(todo.description),
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 150,
                child: ElevatedButton(
                  onPressed: () {
                    // Handle the button press, e.g., mark as completed
                    todo.isCompleted = !todo.isCompleted;
                    Navigator.pop(context, todo.isCompleted); // Go back to the previous screen
                  },
                  child: Text(todo.isCompleted ? 'Not Done' : 'Done'),
                ),
              ),
              SizedBox(width: 20),
              SizedBox(
                width: 150,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context, todo.isCompleted); // Go back to the previous screen
                  },
                  child: const Text('Close'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}