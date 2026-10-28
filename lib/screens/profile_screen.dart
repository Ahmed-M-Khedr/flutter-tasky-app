import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool isDarkMode = true;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'My Profile',
            style: TextStyle(
              color: Color(0xFFFFFCFC),
              fontSize: 22,
              fontWeight: FontWeight.w400,
            ),
          ),
          SizedBox(height: 24),
          Center(
            child: Column(
              children: [
                Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    CircleAvatar(
                      backgroundImage: AssetImage('assets/images/ahmed.png'),
                      radius: 34,
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                        width: 38,
                        height: 38,
                        decoration: BoxDecoration(
                          color: Color(0xFF282828),
                          borderRadius: BorderRadius.circular(100),
                        ),
                        child: Icon(
                          Icons.camera_alt_outlined,
                          color: Color(0xFFFFFCFC),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 6),
                Text(
                  'Ahmed Mohamed',
                  style: TextStyle(
                    color: Color(0xFFFFFCFC),
                    fontSize: 20,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                Text(
                  'One task at a time. One step closer.',
                  style: TextStyle(
                    color: Color(0xFFC6C6C6),
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 24),
          Text(
            'Profile Info',
            style: TextStyle(
              color: Color(0xFFFFFCFC),
              fontSize: 20,
              fontWeight: FontWeight.w400,
            ),
          ),
          ListTile(
            contentPadding: EdgeInsets.zero,
            leading: SvgPicture.asset('assets/images/Profile.svg'),
            title: Text(
              'User Details',
              style: TextStyle(
                color: Color(0xFFC6C6C6),
                fontSize: 20,
                fontWeight: FontWeight.w400,
              ),
            ),
            trailing: IconButton(
              onPressed: () {},
              icon: Icon(Icons.arrow_forward_sharp, color: Color(0xFFC6C6C6)),
            ),
          ),
          Divider(thickness: 1, color: Color(0xFF6E6E6E)),
          ListTile(
            contentPadding: EdgeInsets.zero,
            leading: Icon(Icons.bedtime_outlined, color: Color(0xFFC6C6C6)),
            title: Text(
              'Dark Mode',
              style: TextStyle(
                color: Color(0xFFC6C6C6),
                fontSize: 20,
                fontWeight: FontWeight.w400,
              ),
            ),
            trailing: Switch(
              activeTrackColor: Color(0XFF15B86C),
              value: isDarkMode,
              onChanged: (bool? value) {
                setState(() {
                  isDarkMode = value ?? true;
                });
              },
            ),
          ),
          Divider(thickness: 1, color: Color(0xFF6E6E6E)),
          ListTile(
            contentPadding: EdgeInsets.zero,
            leading: Icon(Icons.logout_outlined, color: Color(0xFFC6C6C6)),
            title: Text(
              'Log Out',
              style: TextStyle(
                color: Color(0xFFC6C6C6),
                fontSize: 20,
                fontWeight: FontWeight.w400,
              ),
            ),
            trailing: IconButton(
              onPressed: () {},
              icon: Icon(Icons.arrow_forward_sharp, color: Color(0xFFC6C6C6)),
            ),
          ),
        ],
      ),
    );
  }
}
