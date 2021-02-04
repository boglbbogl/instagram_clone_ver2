import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone_ver2/constant/common_size.dart';
import 'package:instagram_clone_ver2/widgets/profile_body.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _appBar(),
            ProfileBody(),
          ],
        ),
      ),
    );
  }


  Row _appBar() {
    return Row(
      children: <Widget>[
        SizedBox(
          width: 44,
        ),
        Expanded(
            child: Text(
          'Instagram',
          textAlign: TextAlign.center,
        )),
        IconButton(icon: Icon(Icons.menu), onPressed: () {}),
      ],
    );
  }
}
