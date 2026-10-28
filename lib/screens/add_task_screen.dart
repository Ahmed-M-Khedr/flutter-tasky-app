import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tasky_app/models/task_model.dart';

class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({super.key});
  static const route = '/add_task';

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  final TextEditingController nameTaskController = TextEditingController();
  final TextEditingController descController = TextEditingController();

  final GlobalKey<FormState> _key = GlobalKey<FormState>();

  bool isHighPriority = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('New Task')),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Form(
          key: _key,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Task Name',
                        style: TextStyle(
                          color: Color(0XFFFFFCFC),
                          fontSize: 19,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      SizedBox(height: 8),
                      TextFormField(
                        controller: nameTaskController,
                        style: TextStyle(color: Color(0XFFFFFCFC)),
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Color(0xFF282828),
                          hintText: 'Finish UI design for login screen',
                          hintStyle: TextStyle(color: Color(0xFF6D6D6D)),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(22),
                            borderSide: BorderSide.none,
                          ),
                        ),
                        cursorColor: Color(0XFFFFFCFC),
                        validator: (value) {
                          if (value!.trim().isEmpty) {
                            return 'Please Enter Task Name';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 20),
                      Text(
                        'Task Description',
                        style: TextStyle(
                          color: Color(0XFFFFFCFC),
                          fontSize: 19,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      SizedBox(height: 8),
                      TextFormField(
                        controller: descController,
                        maxLines: 5,
                        style: TextStyle(color: Color(0XFFFFFCFC)),
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Color(0xFF282828),
                          hintText:
                              'Finish onboarding UI and hand off to devs by Thursday.',
                          hintStyle: TextStyle(color: Color(0xFF6D6D6D)),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(22),
                            borderSide: BorderSide.none,
                          ),
                        ),
                        cursorColor: Color(0XFFFFFCFC),
                      ),
                      SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'High Priority',
                            style: TextStyle(
                              color: Color(0XFFFFFCFC),
                              fontSize: 19,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          Switch(
                            value: isHighPriority,
                            onChanged: (bool value) {
                              setState(() {
                                isHighPriority = value;
                              });
                            },
                            activeTrackColor: Color(0XFF15B86C),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton.icon(
                onPressed: () async {
                  if (_key.currentState!.validate()) {
                    final prefs = await SharedPreferences.getInstance();
                    
                    final getTaskStr = prefs.getString(
                      'tasks',
                    ); // استرجاع النص المخزن مسبقاً من SharedPreferences
                    List<dynamic> listTaskJson =
                        []; // إنشاء قائمة فارغة لتخزين المهام

                    if (getTaskStr != null) {
                      // التأكد من أن النص المخزن ليس فارغاً قبل محاولة تحويله إلى List
                      listTaskJson = jsonDecode(
                        getTaskStr,
                      ); // تحويل النص إلى List ديناميكية
                    }
                    TaskModel task = TaskModel(
                      id: listTaskJson.length + 1,
                      taskName: nameTaskController.text.trim(),
                      taskDescription: descController.text.trim(),
                      isHighPriority: isHighPriority,
                    );

                    task.isDone = false; // تعيين القيمة الافتراضية لـ isDone

                    listTaskJson.add(
                      task.toJson(),
                    ); // إضافة المهمة الجديدة إلى القائمة
                    final listTaskStr = jsonEncode(listTaskJson);
                    await prefs.setString('tasks', listTaskStr);
                    Navigator.of(
                      context,
                    ).pop(true); // العودة إلى الشاشة السابقة بعد إضافة المهمة
                  }
                },
                label: Text(
                  'Add Task',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
                icon: Icon(Icons.add),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0XFF15B86C),
                  foregroundColor: Color(0XFFFFFCFC),
                  fixedSize: Size(MediaQuery.of(context).size.width, 40),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
