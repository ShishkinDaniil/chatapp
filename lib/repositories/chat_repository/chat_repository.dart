import 'package:chatapp/utils/base_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ChatRepository extends BaseFireBaseRepository {
  ChatRepository({
    required super.firebaseAuth,
    required super.fireStore,
  });

  Stream getOnlineStatusSnapshot(String userUid) {
    final snapshot =
        fireStore.collection(usersCollection).doc(userUid).snapshots();
    return snapshot;
  }
}
