import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tasky_app/models/task_model.dart';
import 'package:tasky_app/screens/add_task_screen.dart';
import 'package:tasky_app/widgets/achieved_tasks_widget.dart';
import 'package:tasky_app/widgets/high_priority_tasks_widget.dart';
import 'package:tasky_app/widgets/sliver_list_tasks_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  static const route = '/home';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? userName = 'Defualt';
  List<TaskModel> tasks = [];
  bool isLoading = false;
  int totalTasks = 0;
  int totalTasksDone = 0;
  double precent = 0;
  @override
  void initState() {
    super.initState();
    _loadUserName();
    _loadTasks();
    _calculatePrecent();
  }

  Future<void> _loadUserName() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      userName = prefs.getString('userName');
    });
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
        tasks = decodedList.map((item) => TaskModel.fromJson(item)).toList(); //
        _calculatePrecent();
        // isLoading = false;
      });
    } else {
      // في حال عدم وجود أي مهام مخزنة مسبقاً
      setState(() {
        tasks = [];
      });
    }
  }

  void _calculatePrecent() {
    totalTasks = tasks.length;
    totalTasksDone = tasks.where((e) => e.isDone).length;
    precent = totalTasks == 0 ? 0 : totalTasksDone / totalTasks;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ListTile(
                    leading: CircleAvatar(
                      backgroundImage: AssetImage('assets/images/ahmed.png'),
                    ),
                    title: Text(
                      'Good Evening, $userName',
                      style: GoogleFonts.lobster(
                        color: Color(0xFFFFFCFC),
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    subtitle: Text(
                      'One Task at a time. One Step closer to your goals.',
                      style: TextStyle(
                        color: Color(0xFF6C6C6C),
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    trailing: CircleAvatar(
                      backgroundColor: Color.fromARGB(255, 46, 46, 46),
                      child: Icon(Icons.light_mode, color: Color(0xFFFFFCFC)),
                    ),
                  ),
                  Text(
                    'Yuhuu, Your work is',
                    style: TextStyle(
                      color: Color(0xFFFFFCFC),
                      fontSize: 32,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        'almost Done!',
                        style: TextStyle(
                          color: Color(0xFFFFFCFC),
                          fontSize: 32,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      SizedBox(width: 16),
                      SvgPicture.asset(
                        'assets/images/hand.svg',
                        width: 28,
                        height: 28,
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  AchievedTasks(
                    totalTasks: totalTasks,
                    totalTasksDone: totalTasksDone,
                    precent: precent,
                  ),
                  SizedBox(height: 8),
                  HighPriorityTasks(
                    tasks: tasks,
                    onTap: (bool? value, int? index) async {
                      setState(() {
                        tasks[index!].isDone = value ?? false;
                        _calculatePrecent();
                      });
                      final prefs = await SharedPreferences.getInstance();
                      final updateTask = tasks
                          .map((element) => element.toJson())
                          .toList();
                      await prefs.setString('tasks', jsonEncode(updateTask));
                      _calculatePrecent();
                    },
                    refresh: () {
                      _loadTasks();
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 24, bottom: 16),
                    child: Text(
                      'My Tasks',
                      style: TextStyle(
                        color: Color(0XFFFFFCFC),
                        fontSize: 20,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SliverListTasksWidget(
              emptyMessage: 'No Data',
              tasks: tasks,
              onTap: (bool? value, int? index) async {
                setState(() {
                  tasks[index!].isDone = value ?? false;
                  _calculatePrecent();
                });
                final prefs = await SharedPreferences.getInstance();
                final updateTask = tasks
                    .map((element) => element.toJson())
                    .toList();
                await prefs.setString('tasks', jsonEncode(updateTask));
                _calculatePrecent();
              },
            ),
          ],
        ),
      ),

      floatingActionButton: SizedBox(
        width: 167,
        height: 40,
        child: FloatingActionButton.extended(
          onPressed: () async {
            final dynamic result = await Navigator.pushNamed(
              context,
              AddTaskScreen.route,
            );
            if (result != null && result == true) {
              _loadTasks(); // إعادة تحميل المهام بعد العودة من شاشة إضافة مهمة جديدة
            }
          },
          backgroundColor: Color(0XFF15B86C),
          foregroundColor: Color(0XFFFFFCFC),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(33),
          ),

          label: Text(
            'Add New Task',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
          icon: Icon(Icons.add),
        ),
      ),
    );
  }
}
