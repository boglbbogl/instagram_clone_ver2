import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone_ver2/constant/common_size.dart';
import 'package:instagram_clone_ver2/constant/screen_size.dart';
import 'package:instagram_clone_ver2/repo/image_network_repository.dart';
import 'comment.dart';
import 'my_progress_indicator.dart';
import 'rounded_avatar.dart';

class Post extends StatelessWidget {
  final int index;

  Post(
    this.index, {
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _postHeader(),
        _postImage(),
        _postActions(),
        _postLikes(),
        _postCaption(),
      ],
    );
  }
  Widget _postCaption(){
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: common_xxs_gap, horizontal: common_gap),
      child: Comment(
        showImage: false,
      username: 'testinguser',
        text: 'I hav money',
      ),
    );
  }

  Padding _postLikes() {
    return Padding(
        padding: const EdgeInsets.only(left: common_gap),
        child: Text(
          '12000 likes',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      );
  }

  Row _postActions() {
    return Row(
      children: <Widget>[
        IconButton(
          onPressed: null,
          icon: ImageIcon(
            AssetImage('assets/images/bookmark.png'),
            color: Colors.black87,
          ),
        ),
        IconButton(
          onPressed: null,
          icon: ImageIcon(
            AssetImage('assets/images/comment.png'),
            color: Colors.black87,
          ),
        ),
        IconButton(
          onPressed: null,
          icon: ImageIcon(
            AssetImage('assets/images/direct_message.png'),
            color: Colors.black87,
          ),
        ),
        Spacer(),
        IconButton(
          onPressed: null,
          icon: ImageIcon(
            AssetImage('assets/images/heart_selected.png'),
            color: Colors.black87,
          ),
        ),
      ],
    );
  }

  Widget _postHeader() {
    return Row(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(common_xxs_gap),
          child: RoundedAvatar(),
        ),
        Expanded(child: Text('username')),
        IconButton(
          icon: Icon(Icons.more_horiz),
          onPressed: null,
          color: Colors.black87,
        ),
      ],
    );
  }

  Widget _postImage() {

    Widget progress = MyProgressIndicator(
      containerSize: size.width,
    );

    return FutureBuilder<dynamic>(
      future: imageNetworkRepository.getPostImageUrl('1613289044089_bLRKcuG1TpMUMzFLd4Yqi8d56qN2'),
      builder: (context, snapshot) {

        if(snapshot.hasData)
        return CachedNetworkImage(
          imageUrl: snapshot.data.toString(),
          placeholder: (BuildContext context, String url) {
            return progress;
          },
          imageBuilder: (BuildContext context, ImageProvider imageProvider) {
            return AspectRatio(
              aspectRatio: 1,
              child: Container(
                decoration: BoxDecoration(
                    image: DecorationImage(
                  image: imageProvider,
                  fit: BoxFit.cover,
                )),
              ),
            );
          },
        );
        else
          return progress;
      }
    );
  }
}

