import 'package:cloud_firestore/cloud_firestore.dart';

abstract class BaseFireStoreProvider {
  final usersCollection = 'users';
  final messagesCollection = 'messages';

  final FirebaseFirestore fireStore;

  BaseFireStoreProvider({
    required this.fireStore,
  });
}
