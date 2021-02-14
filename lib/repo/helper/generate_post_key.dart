import 'package:instagram_clone_ver2/models/firestore/user_model.dart';

String getNewPostKey(UserModel userModel) => "${DateTime.now().millisecondsSinceEpoch}_${userModel.userKey}";