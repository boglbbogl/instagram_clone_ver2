import 'package:flutter/material.dart';
import 'package:instagram_clone_ver2/constant/screen_size.dart';

class TakePhoto extends StatelessWidget {
  const TakePhoto({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          color: Colors.black,
          width: size.width,
          height: size.width,
        ),
        Expanded(
            child: OutlineButton(
              onPressed: (){},
              shape: CircleBorder(),
              borderSide: BorderSide(color: Colors.black12, width: 20),
            ),
        ),
      ],
    );
  }
}