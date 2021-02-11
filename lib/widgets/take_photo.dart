import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone_ver2/constant/screen_size.dart';
import 'package:instagram_clone_ver2/models/camera_state.dart';
import 'package:instagram_clone_ver2/screens/share_post_screen.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'my_progress_indicator.dart';

class TakePhoto extends StatelessWidget {

  Widget _progress = MyProgressIndicator();

  @override
  Widget build(BuildContext context) {
    return Consumer<CameraState>(
      builder: (BuildContext context, CameraState cameraState, Widget child) {
        return Column(
          children: <Widget>[
            Container(
              color: Colors.black,
              width: size.width,
              height: size.width,
              child: (cameraState.isReadyToTakePhoto)?_getPreview(cameraState):_progress,
            ),
            Expanded(
              child: OutlineButton(
                onPressed: () {
                  if(cameraState.isReadyToTakePhoto){
                    _attemptTakePhoto(cameraState, context);
                  }
                },
                shape: CircleBorder(),
                borderSide: BorderSide(color: Colors.black12, width: 20),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _getPreview(CameraState cameraState) {
    return ClipRect(
      child: OverflowBox(
        alignment: Alignment.center,
        child: FittedBox(
          fit: BoxFit.fitWidth,
          child: Container(
              width: size.width,
              height: size.width / cameraState.controller.value.aspectRatio,
              child: CameraPreview(cameraState.controller)),
        ),
      ),
    );
  }

  void _attemptTakePhoto(CameraState cameraState, BuildContext context) async{
    final String timeInMilli = DateTime.now().millisecondsSinceEpoch.toString();
    try{
      final path = join((await getTemporaryDirectory()).path, '$timeInMilli.png');

      await cameraState.controller.takePicture(path);

      File imageFile = File(path);
      Navigator.of(context).push(MaterialPageRoute(builder: (_) => SharePostScreen(imageFile)));
    }catch(e){

    }

  }
}
