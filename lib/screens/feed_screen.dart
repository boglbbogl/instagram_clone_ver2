import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone_ver2/models/firestore/post_model.dart';
import 'package:instagram_clone_ver2/repo/post_network_repository.dart';
import 'package:instagram_clone_ver2/widgets/my_progress_indicator.dart';
import 'package:provider/provider.dart';
import '../widgets/post.dart';

class FeedScreen extends StatelessWidget {
  final List<dynamic> followings;

  const FeedScreen(
    this.followings, {
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<PostModel>>.value(
      value: postNetworkRepository.fetchPostsFromAllFollowers(followings),
      child: Consumer<List<PostModel>>(
          builder: (BuildContext context, List<PostModel> posts, Widget child) {
        if (posts == null || posts.isEmpty)
          return MyProgressIndicator();
        else {
          return Scaffold(
            appBar: CupertinoNavigationBar(
                leading: IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.camera_alt,
                    color: Colors.red,
                  ),
                ),
                middle: Text(
                  'Instagram',
                  style: TextStyle(
                      fontFamily: 'VeganStyle', color: Colors.black87),
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    IconButton(
                      onPressed: () {},
                      icon: ImageIcon(
                        AssetImage('assets/images/direct_message.png'),
                        color: Colors.deepPurple,
                      ),
                    ),
                  ],
                )),
            body: ListView.builder(
              itemBuilder: (context, index) => feedListBuilder(context, posts[index]),
              itemCount: posts.length,
            ),
          );
        }
      }),
    );
  }

  Widget feedListBuilder(BuildContext context, PostModel postModel) {
    return Post(postModel);
  }
}
