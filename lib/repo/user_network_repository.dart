import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:instagram_clone_ver2/constant/firestore_keys.dart';
import 'package:instagram_clone_ver2/models/firestore/user_model.dart';

class UserNetworkRepository {
  Future<void> attemptCreateUser({String userKey, String email}) async {
    final DocumentReference userRef =
        Firestore.instance.collection(COLLECTION_USERS).document(userKey);

    DocumentSnapshot snapshot = await userRef.get();
    if (!snapshot.exists) {
      return await userRef.setData(UserModel.getMapForCreateUser(email));
    }
  }

  Stream<UserModel> getUserModelStream(String userKey) {
    return Firestore.instance
        .collection(COLLECTION_USERS)
        .document(userKey)
        .snapshots().transform(streamTransformer);
  }
}

UserNetworkRepository userNetworkRepository = UserNetworkRepository();
