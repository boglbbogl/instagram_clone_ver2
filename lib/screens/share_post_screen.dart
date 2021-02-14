import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone_ver2/constant/common_size.dart';
import 'package:instagram_clone_ver2/constant/screen_size.dart';

class SharePostScreen extends StatelessWidget {
  final File imageFile;
  final String postKey;

  const SharePostScreen(this.imageFile, {
    Key key,
    @required this.postKey,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('New Post'),
        actions: <Widget>[
          FlatButton(
              onPressed: (){},
              child: Text('Shars', textScaleFactor: 1.4,style: TextStyle(color: Colors.blue),))
        ],
      ),
        body : ListView(
            children: <Widget>[
              _captionWithImage(),
              _divider,
              _sectionButton('Tag People'),
              _divider,
              _sectionButton('Add Location'),
            ],
    ),
    );
  }

  Divider get _divider => Divider(
              color: Colors.grey[300],
              thickness: 1,
              height: 1,
            );


  ListTile _sectionButton(String title) {
    return ListTile(
              title: Text(title, style: TextStyle(fontWeight: FontWeight.w400),),
              trailing: Icon(Icons.navigate_next),
              dense: true,
              contentPadding: EdgeInsets.symmetric(horizontal: common_gap),
            );
  }

  ListTile _captionWithImage() {
    return ListTile(
              contentPadding: EdgeInsets.symmetric(vertical: common_gap, horizontal: common_gap),
              leading: Image.file(
                imageFile,
              width: size.width / 6,
              height: size.width / 6,
              fit: BoxFit.cover,
            ),
            title: TextField(
              decoration: InputDecoration(
                hintText: 'Write a caption...',
                border: InputBorder.none,
              ),
            ),);
  }
}
