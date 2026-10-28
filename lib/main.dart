import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tasky_app/screens/high_priority_tasks_screen.dart';
import 'package:tasky_app/screens/home_screen.dart';
import 'package:tasky_app/screens/main_screen.dart';
import 'package:tasky_app/screens/welcome_screen.dart';
import 'package:tasky_app/screens/add_task_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final SharedPreferences prefs = await SharedPreferences.getInstance();

  final String? userName = prefs.getString('userName');
  runApp(MyApp(userName: userName));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.userName});

  // This widget is the root of your application.

  final String? userName; // Replace with your desired user name

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Color(0xff181818),
        appBarTheme: AppBarTheme(
          backgroundColor: Color(0xff181818),
          foregroundColor: Color(0XFFFFFCFC),
        ),
      ),

      title: 'Tasky',
      routes: {
        '/': userName == null
            ? (context) => WelcomeScreen()
            : (context) => MainScreen(),
        WelcomeScreen.route: (context) => WelcomeScreen(),
        HomeScreen.route: (context) => HomeScreen(),
        AddTaskScreen.route: (context) => AddTaskScreen(),
        MainScreen.route: (context) => MainScreen(),
        HighPriorityTasksScreen.route: (context) => HighPriorityTasksScreen()
      },
      initialRoute: '/',
    );
  }
}
