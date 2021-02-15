import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone_ver2/constant/common_size.dart';
import 'package:instagram_clone_ver2/constant/screen_size.dart';
import 'package:instagram_clone_ver2/models/firestore/post_model.dart';
import 'package:instagram_clone_ver2/models/firestore/user_model.dart';
import 'package:instagram_clone_ver2/models/user_model_state.dart';
import 'package:instagram_clone_ver2/repo/post_network_repository.dart';
import 'package:instagram_clone_ver2/screens/comment_screen.dart';
import 'package:provider/provider.dart';
import 'comment.dart';
import 'my_progress_indicator.dart';
import 'rounded_avatar.dart';

class Post extends StatelessWidget {
  final PostModel postModel;

  Post(
    this.postModel, {
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _postHeader(),
        _postImage(),
        _postActions(context),
        _postLikes(),
        _postCaption(),
        _lastComment(),
        _moreComment(context),
      ],
    );
  }

  Widget _postCaption() {
    return Padding(
      padding: const EdgeInsets.symmetric(
          vertical: common_xxs_gap, horizontal: common_gap),
      child: Comment(
        showImage: false,
        username: postModel.username,
        text: postModel.caption,
      ),
    );
  }

  Widget _lastComment() {
    return Padding(
      padding: const EdgeInsets.only(
        left: common_gap,
        right: common_gap,
        top: common_xxs_gap,
      ),
      child: Comment(
        showImage: false,
        username: postModel.lastCommentor,
        text: postModel.lastcomment,
      ),
    );
  }

  Padding _postLikes() {
    return Padding(
      padding: const EdgeInsets.only(left: common_gap),
      child: Text(
        '${postModel.numOfLikes == null ? 0 : postModel.numOfLikes.length} likes',
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
    );
  }

  Row _postActions(BuildContext context) {
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
          onPressed: () {
            _goToComment(context);
          },
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
        Consumer<UserModelState>(
          builder: (BuildContext context,UserModelState userModelState, Widget child) {
            return IconButton(
              onPressed: () {
                postNetworkRepository.toggleLike(postModel.postKey, userModelState.userModel.userKey);
              },
              icon: ImageIcon(
                AssetImage(postModel.numOfLikes.contains(
                    userModelState
                        .userModel
                        .userKey)
                    ? 'assets/images/heart_selected.png'
                    : 'assets/images/heart.png'),
                color: Colors.redAccent,
              ),
              color: Colors.black54,
            );
          },
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
        Expanded(child: Text(postModel.username)),
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
    return CachedNetworkImage(
      imageUrl: postModel.postImg,
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
  }

  Widget _moreComment(BuildContext context) {
    return Visibility(
      visible: (postModel.numOfComment != null && postModel.numOfComment >= 2),
      child: GestureDetector(
        onTap: () {
          _goToComment(context);
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: common_gap),
          child: Text('${postModel.numOfComment - 1} more comments'),
        ),
      ),
    );
  }

  _goToComment(BuildContext context) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (BuildContext context) {
      return CommentScreen(postModel.postKey);
    }));
  }
}
