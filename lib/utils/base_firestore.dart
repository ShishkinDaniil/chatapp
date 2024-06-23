import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class BaseFireBaseRepository {
  final usersCollection = 'users';
  final messagesCollection = 'messages';

  final FirebaseFirestore fireStore;
  final FirebaseAuth firebaseAuth;
  User? get currentUser => firebaseAuth.currentUser;

  BaseFireBaseRepository({
    required this.fireStore,
    required this.firebaseAuth,
  });
}
