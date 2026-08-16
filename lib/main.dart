import 'package:flutter/material.dart';
import 'DetailScreen.dart';
import 'todo.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  // 📌 1. [ห้องครัว] สร้าง "ลังข้อมูลของจริง" เก็บข้อมูล 3 รายการไว้ที่นี่
  List<Todo> todos = [
    Todo('Buy groceries', 'Milk, Bread, Eggs', false),
    Todo('Walk the dog', 'Take the dog for a walk in the park', false),
    Todo('Read a book', 'Finish reading "Flutter for Beginners', false),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todo App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.blue,
          foregroundColor: Colors.white,
        ),
      ),
      // 📌 2. เรียกใช้งาน TodosScreen และ "ยื่นลังข้อมูล" โยนส่งไปให้
      home: TodosScreen(todos: todos), 
    );
  }
}

class TodosScreen extends StatefulWidget {
  // 📌 3. [หน้าร้าน] สร้าง Constructor บังคับว่าใครเรียกหน้านี้ต้องส่ง todos มาด้วยนะ
  const TodosScreen({super.key, required this.todos});
  
  // 📌 4. สร้าง "ตะกร้าเปล่า" (ไม่ได้ใส่ = []) มารอรับลังข้อมูลที่ถูกส่งมาจาก MyApp
  final List<Todo> todos;

  @override
  State<TodosScreen> createState() => _TodosScreenState();
}

class _TodosScreenState extends State<TodosScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Todos')),
      body: ListView.builder(
        // 📌 5. ใช้ widget.todos เพื่อแอบไปหยิบลังข้อมูลจากตะกร้าหน้าร้าน มาเช็กว่ามีของกี่ชิ้น
        itemCount: widget.todos.length,
        itemBuilder: (context, index) {
          return ListTile(
            // 📌 6. index จะรันเอง (0, 1, 2) ทำให้มันไปดึง title มาถูกตัวตามรอบที่วน
            title: Text(widget.todos[index].title),
            leading:
                widget.todos[index].isCompleted
                    ? Icon(Icons.check_circle, color: Colors.green)
                    : Icon(Icons.circle, color: Colors.grey),
            onTap: () async {
              // 📌 7. [SEND] ขาไป: ยื่นกล่องข้อมูลตัวที่ถูกกด (ส่งแค่ก้อน index นั้น) ไปให้ DetailScreen
              // และใช้คำว่า await เพื่อสั่งให้หน้าแรก "หยุดนั่งรอ" จนกว่า DetailScreen จะทำงานเสร็จ
              final result = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DetailScreen(todo: widget.todos[index]),
                ),
              );
              
              // 📌 8. [RECEIVE] ขากลับ: พอ DetailScreen ปิดลง ค่าที่โยนกลับมาจะอยู่ในตัวแปร result
              setState(() {
                if (result == null) return; 
                widget.todos[index].isCompleted = result; // เอาค่าใหม่ทับค่าเดิมในตะกร้า
              }); // setState จะกระตุ้นให้หน้าจอวาดใหม่ ไอคอนเลยเปลี่ยนสี
            },
          );
        },
      ),
    );
  }
}