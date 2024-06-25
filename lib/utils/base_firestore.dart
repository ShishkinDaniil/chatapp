import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

class BaseFireBaseRepository {
  final usersCollection = 'users';
  final roomsCollection = 'rooms';
  final messagesCollection = 'messages';

  final FirebaseFirestore fireStore;
  final FirebaseAuth firebaseAuth;
  final FirebaseDatabase firebaseDatabase;
  User? get currentUser => firebaseAuth.currentUser;

  DatabaseReference get onlineStatusDatabase =>
      firebaseDatabase.ref().child('onlineStatus');

  BaseFireBaseRepository({
    required this.fireStore,
    required this.firebaseAuth,
    required this.firebaseDatabase,
  });
}
