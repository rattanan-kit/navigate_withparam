import 'package:flutter/material.dart';
import 'todo.dart';

class DetailScreen extends StatelessWidget {
  // 📌 9. หน้านี้ก็สร้างตะกร้าเปล่ามารอรับของเหมือนกัน แต่คราวนี้รับแค่ Todo "ชิ้นเดียว"
  const DetailScreen({super.key, required this.todo});
  final Todo todo;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(todo.title)),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(todo.description),
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 150,
                child: ElevatedButton(
                  onPressed: () {
                    // 📌 10. สลับสถานะในกล่อง เช่น จาก false ให้กลายเป็น true หรือ true เป็น false
                    todo.isCompleted = !todo.isCompleted;
                    
                    // 📌 11. [RETURN] ขากลับ: ปิดหน้าตัวเองทิ้ง (pop) 
                    // แล้วแนบค่า todo.isCompleted โยนกลับไปให้หน้าแรกที่กำลัง await รออยู่!
                    Navigator.pop(context, todo.isCompleted); 
                  },
                  child: Text(todo.isCompleted ? 'Not Done' : 'Done'),
                ),
              ),
              SizedBox(width: 20),
              SizedBox(
                width: 150,
                child: ElevatedButton(
                  onPressed: () {
                    // ปิดหน้าเฉยๆ โยนค่าเดิมกลับไป
                    Navigator.pop(context, todo.isCompleted); 
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