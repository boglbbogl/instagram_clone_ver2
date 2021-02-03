import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'widgets/post.dart';

class FeedScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CupertinoNavigationBar(
          leading: IconButton(
            onPressed: null,
            icon: Icon(Icons.camera_alt,
              color: Colors.red,
            ),
          ),
          middle: Text(
            'Instagram',
            style: TextStyle(fontFamily: 'VeganStyle', color: Colors.black87),
          ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              IconButton(
              onPressed: null,
              icon: ImageIcon(
                  AssetImage('assets/images/actionbar_camera.png'),
                color: Colors.deepPurple,

              ),
              ),
            ],
          )
      ),
      body: ListView.builder(itemBuilder: feedListBuilder, itemCount: 3,),
    );
  }

  Widget feedListBuilder(BuildContext context, int index) {
    return Post(index);
  }
}


