import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';

import 'helper/image_helper.dart';

class ImageNetworkRepository{
  Future<StorageTaskSnapshot> uploadImage(File originImage, {@required String postKey}) async{
    try{
      final File resized = await compute(getResizedImage, originImage);

      final StorageReference storageReference = FirebaseStorage().ref().child(_getImagePathByPostkey(postKey));
      final StorageUploadTask uploadTask = storageReference.putFile(resized);
      return uploadTask.onComplete;

    }catch(e){
      print(e);
      return null;
    }
  }

  String _getImagePathByPostkey(String postKey) => 'post/$postKey/post.jpg';

  Future<dynamic> getPostImageUrl(String postKey){
    return FirebaseStorage().ref().child(_getImagePathByPostkey(postKey)).getDownloadURL();
  }

}

ImageNetworkRepository imageNetworkRepository = ImageNetworkRepository();