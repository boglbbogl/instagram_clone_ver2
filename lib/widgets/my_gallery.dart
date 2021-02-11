import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:instagram_clone_ver2/models/gallery_state.dart';
import 'package:instagram_clone_ver2/screens/share_post_screen.dart';
import 'package:local_image_provider/device_image.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

class MyGallery extends StatefulWidget {
  @override
  _MyGalleryState createState() => _MyGalleryState();
}

class _MyGalleryState extends State<MyGallery> {
  @override
  Widget build(BuildContext context) {
    return Consumer<GalleryState>(
      builder: (BuildContext context, GalleryState galleryState, Widget child) {
        return GridView.count(
          crossAxisCount: 3,
          children: getImage(context, galleryState),
        );
      },
    );
  }

  List<Widget> getImage(BuildContext context, GalleryState galleryState) {
    return galleryState.images
        .map((localImage) =>
        InkWell(
          onTap: () async {
            Uint8List bytes = await localImage.getScaledImageBytes(galleryState.localImageProvider, 0.3);
            final String timeInMilli = DateTime.now().millisecondsSinceEpoch.toString();
            try{
              final path = join((await getTemporaryDirectory()).path, '$timeInMilli.png');
              File imageFile = File(path)..writeAsBytesSync(bytes);
              Navigator.of(context).push(MaterialPageRoute(builder: (_) => SharePostScreen(imageFile)));
            }catch(e){

            }
          },
          child: Image(
            fit: BoxFit.cover,
            image: DeviceImage(localImage, scale: 0.1),
          ),
        ))
        .toList();
  }
}
