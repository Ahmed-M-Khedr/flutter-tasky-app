import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tasky_app/models/task_model.dart';
import 'package:tasky_app/widgets/list_tasks.dart';

class CompletedTasksScreen extends StatefulWidget {
  const CompletedTasksScreen({super.key});

  @override
  State<CompletedTasksScreen> createState() => _TodoScreenState();
}

class _TodoScreenState extends State<CompletedTasksScreen> {
  List<TaskModel> tasks = [];

  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _loadTasks();
  }

  void _loadTasks() async {
    // setState(() {
    //   isLoading = true;
    // });
    // await Future.delayed(Duration(seconds: 2));
    print('loading tasks...');
    final prefs = await SharedPreferences.getInstance();
    final taskStr = prefs.getString('tasks');

    // التأكد من أن القيمة ليست فارغة وليست نصاً فارغاً
    if (taskStr != null && taskStr.isNotEmpty) {
      // 1. تحويل النص إلى List ديناميكية أولاً
      final decodedList =
          jsonDecode(taskStr) as List<dynamic>; // تحويل النص إلى List ديناميكية
      setState(() {
        tasks = decodedList
            .map((item) => TaskModel.fromJson(item))
            .where((item) => item.isDone)
            .toList(); //
        // isLoading = false;
      });
    } else {
      // في حال عدم وجود أي مهام مخزنة مسبقاً
      setState(() {
        tasks = [];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: Text(
            'Completed Tasks',
            style: TextStyle(
              color: Color(0XFFFFFCFC),
              fontSize: 22,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: ListTasks(
              emptyMessage: 'No Task Found',
              tasks: tasks,
              onTap: (bool? value, int? index) async {
                setState(() {
                  tasks[index!].isDone = value ?? false;
                });
                final prefs = await SharedPreferences.getInstance();
                final allData = prefs.getString('tasks');
                if (allData != null) {
                  List<TaskModel> allDataList = (jsonDecode(allData) as List)
                      .map((element) => TaskModel.fromJson(element))
                      .toList();
                  final newIndex = allDataList.indexWhere(
                    (e) => e.id == tasks[index!].id,
                  );
                  allDataList[newIndex] = tasks[index!];
                  await prefs.setString('tasks', jsonEncode(allDataList));
                  _loadTasks();
                }
              },
            ),
          ),
        ),
      ],
    );
  }
}
