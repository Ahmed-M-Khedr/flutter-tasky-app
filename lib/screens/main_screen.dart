import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tasky_app/screens/completed_tasks_screen.dart';
import 'package:tasky_app/screens/home_screen.dart';
import 'package:tasky_app/screens/profile_screen.dart';
import 'package:tasky_app/screens/todo_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});
  static const route = '/mainScreen';

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  List<Widget> screen = [
    HomeScreen(),
    TodoScreen(),
    CompletedTasksScreen(),
    ProfileScreen(),
  ];

  int _indexScreen = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        onTap: (int? index) {
          setState(() {
            _indexScreen = index ?? 0;
          });
        },
        currentIndex: _indexScreen,
        type: BottomNavigationBarType.fixed,
        backgroundColor: Color(0xff181818),
        selectedItemColor: Color(0XFF15B86C),
        unselectedItemColor: Color(0XFFFFFCFC),
        items: [
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/images/Home.svg',
              colorFilter: ColorFilter.mode(
                _indexScreen == 0 ? Color(0XFF15B86C) : Color(0XFFFFFCFC),
                BlendMode.srcIn,
              ),
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/images/ToDo.svg',
              colorFilter: ColorFilter.mode(
                _indexScreen == 1 ? Color(0XFF15B86C) : Color(0XFFFFFCFC),
                BlendMode.srcIn,
              ),
            ),
            label: 'To Do',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/images/Complet.svg',
              colorFilter: ColorFilter.mode(
                _indexScreen == 2 ? Color(0XFF15B86C) : Color(0XFFFFFCFC),
                BlendMode.srcIn,
              ),
            ),
            label: 'Completed',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/images/Profile.svg',
              colorFilter: ColorFilter.mode(
                _indexScreen == 3 ? Color(0XFF15B86C) : Color(0XFFFFFCFC),
                BlendMode.srcIn,
              ),
            ),
            label: 'Profile',
          ),
        ],
      ),
      body: SafeArea(child: screen[_indexScreen]),
    );
  }
}
