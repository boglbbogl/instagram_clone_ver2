import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone_ver2/constant/screen_size.dart';
import 'package:instagram_clone_ver2/widgets/profile_body.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final duration = Duration(milliseconds: 300);
  final menuWidth = size.width/2;

  MenuStatus _menuStatus = MenuStatus.closed;
  double bodyXPos = 0;
  double menuXpos = size.width;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: Stack(
        children: [
          AnimatedContainer(
            duration: duration,
            child: ProfileBody(onMenuChanged: () {
              setState(() {
                _menuStatus = _menuStatus == MenuStatus.closed
                    ? MenuStatus.opened
                    : MenuStatus.closed;

                switch(_menuStatus){
                  case MenuStatus.opened:
                    bodyXPos = -menuWidth;
                    menuXpos = size.width-menuWidth;
                    break;
                  case MenuStatus.closed:
                    bodyXPos = 0;
                    menuXpos = size.width;
                    break;
                }
              });
            }),
            transform: Matrix4.translationValues(bodyXPos, 0, 0),
          ),
          AnimatedContainer(
            transform: Matrix4.translationValues(menuXpos, 0, 0),
            duration: duration,
            child: Container(
              color: Colors.yellow,
            ),
          ),
        ],
      ),
    );
  }
}

enum MenuStatus { opened, closed }
