import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tasky_app/screens/main_screen.dart';

class WelcomeScreen extends StatelessWidget {
  WelcomeScreen({super.key});

  static const route = '/welcome';

  final TextEditingController nameController = TextEditingController();
  final GlobalKey<FormState> _key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Form(
              key: _key,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        'assets/images/logo.svg',
                        width: 42,
                        height: 42,
                      ),
                      SizedBox(width: 16),
                      Text(
                        'Tasky',
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.w400,
                          color: Color(0XFFFFFFFF),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 160),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Welcome To Tasky ',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w400,
                          color: Color(0xFFFFFCFC),
                        ),
                      ),
                      SizedBox(width: 8),
                      SvgPicture.asset(
                        'assets/images/hand.svg',
                        width: 28,
                        height: 28,
                      ),
                    ],
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Your productivity journey starts here.',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: Color(0xFFFFFCFC),
                    ),
                  ),
                  SizedBox(height: 24),
                  SvgPicture.asset(
                    'assets/images/pana.svg',
                    width: 215,
                    height: 204,
                  ),
                  SizedBox(height: 28),
                  Row(
                    children: [
                      SizedBox(width: 18),
                      Text(
                        'Full Name',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: Color(0xFFFFFCFC),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: TextFormField(
                      controller: nameController,
                      validator: (String? value) {
                        if (value == null || value.trim().isEmpty) {
                          return "Please Enter Your Full Name!! ";
                        }
                        return null;
                      },
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        hintText: 'e.g. Sarah Khalid',
                        hintStyle: TextStyle(color: Color(0xFF6D6D6D)),
                        filled: true,
                        fillColor: Color(0xFF282828),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: BorderSide.none,
                        ),
                      ),
                      cursorColor: Colors.white,
                    ),
                  ),
                  SizedBox(height: 24),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Color(0xFFFFFCFC),
                        backgroundColor: Color(0xFF15B86C),
                        fixedSize: Size(MediaQuery.of(context).size.width, 40),
                      ),
                      onPressed: () async {
                        if (_key.currentState?.validate() ?? false) {
                          final pref = await SharedPreferences.getInstance();
                         await pref.setString('userName', nameController.text);
                          Navigator.pushReplacementNamed(context, MainScreen.route);
                        }
                      },
                      child: Text(
                        'Let’s Get Started',
                        style: TextStyle(
                          color: Color(0xFFFFFCFC),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
