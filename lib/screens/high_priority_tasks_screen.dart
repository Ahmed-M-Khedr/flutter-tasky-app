import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tasky_app/models/task_model.dart';
import 'package:tasky_app/widgets/list_tasks.dart';

class HighPriorityTasksScreen extends StatefulWidget {
  const HighPriorityTasksScreen({super.key});
  static const route = '/high_priority';

  @override
  State<HighPriorityTasksScreen> createState() =>
      _HighPriorityTasksScreenState();
}

class _HighPriorityTasksScreenState extends State<HighPriorityTasksScreen> {
  List<TaskModel> highPriorityTasks = [];
  int totalTasks = 0;
  int totalTasksDone = 0;
  double precent = 0;
  @override
  void initState() {
    super.initState();
    _loadTasks();
    _calculatePrecent();
  }

  void _loadTasks() async {
    // setState(() {
    //   isLoading = true;
    // });
    // await Future.delayed(Duration(seconds: 2));
    print('loading highPriorityTasks...');
    final prefs = await SharedPreferences.getInstance();
    final taskStr = prefs.getString('tasks');

    // التأكد من أن القيمة ليست فارغة وليست نصاً فارغاً
    if (taskStr != null && taskStr.isNotEmpty) {
      // 1. تحويل النص إلى List ديناميكية أولاً
      final decodedList =
          jsonDecode(taskStr) as List<dynamic>; // تحويل النص إلى List ديناميكية
      setState(() {
        highPriorityTasks = decodedList
            .map((item) => TaskModel.fromJson(item))
            .where((e) => e.isHighPriority)
            .toList(); //

        highPriorityTasks = highPriorityTasks.reversed.toList();
        _calculatePrecent();
        // isLoading = false;
      });
    } else {
      // في حال عدم وجود أي مهام مخزنة مسبقاً
      setState(() {
        highPriorityTasks = [];
      });
    }
  }

  void _calculatePrecent() {
    totalTasks = highPriorityTasks.length;
    totalTasksDone = highPriorityTasks.where((e) => e.isDone).length;
    precent = totalTasks == 0 ? 0 : totalTasksDone / totalTasks;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('High Priority Tasks')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Expanded(
              child: ListTasks(
                tasks: highPriorityTasks,
                onTap: (bool? value, int? index) async {
                  setState(() {
                    highPriorityTasks[index!].isDone = value ?? false;
                  });
                  final prefs = await SharedPreferences.getInstance();
                  final allData = prefs.getString('tasks');
                  if (allData != null) {
                    List<TaskModel> allDataList = (jsonDecode(allData) as List)
                        .map((element) => TaskModel.fromJson(element))
                        .toList();
                    final newIndex = allDataList.indexWhere(
                      (e) => e.id == highPriorityTasks[index!].id,
                    );
                    allDataList[newIndex] = highPriorityTasks[index!];
                    await prefs.setString('tasks', jsonEncode(allDataList));
                    _loadTasks();
                  }
                },
                emptyMessage: 'No Task Found',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
