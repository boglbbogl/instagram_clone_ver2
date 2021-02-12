import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone_ver2/repo/user_network_repository.dart';
import '../widgets/post.dart';

class FeedScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CupertinoNavigationBar(
          leading: IconButton(
            onPressed: (){
            },
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
              onPressed: (){
              },
              icon: ImageIcon(
                  AssetImage('assets/images/direct_message.png'),
                color: Colors.deepPurple,

              ),
              ),
            ],
          )
      ),
      body: ListView.builder(itemBuilder: feedListBuilder, itemCount: 30,),
    );
  }

  Widget feedListBuilder(BuildContext context, int index) {
    return Post(index);
  }
}


