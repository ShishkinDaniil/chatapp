import 'dart:async';
import 'dart:math';

import 'package:chatapp/models/user/user_dto.dart';
import 'package:chatapp/models/user/user_model.dart';
import 'package:chatapp/utils/base_firestore.dart';
import 'package:chatapp/utils/color_gen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

class AuthRepository extends BaseFireBaseRepository {
  StreamSubscription? _onlineSubscription;
  AuthRepository({
    required super.firebaseDatabase,
    required super.firebaseAuth,
    required super.fireStore,
  });

  Future<void> _configOnline() async {
    final uid = currentUser?.uid;
    if (uid != null) {
      DatabaseReference con;
      final myconnRef = onlineStatusDatabase.child(uid);
      await firebaseDatabase.goOnline();

      _onlineSubscription = firebaseDatabase
          .ref()
          .child('.info/connected')
          .onValue
          .listen((event) {
        if (event.snapshot.value != null) {
          con = myconnRef;
          con.onDisconnect().remove();
          con.set(true);
        }
      });
    }
  }

  void goOnline() {
    _configOnline();
  }

  void goOffline() {
    _onlineSubscription?.cancel();
    firebaseDatabase.goOffline();
  }

  Future<UserModel> getCurrentUser() async {
    final currUid = currentUser?.uid;
    final data =
        (await fireStore.collection(usersCollection).doc(currUid).get())
            .data()!;

    return UserDto.fromJson(
      data,
    ).toEntity();
  }

  Stream<User?> get streamAuthState => firebaseAuth.authStateChanges();

  Future<UserModel> signInWithEmailAndPassword(
    String email,
    String password,
  ) async {
    try {
      await firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      final user = await getCurrentUser();

      return user;
    } on FirebaseAuthException catch (e) {
      throw (e.code);
    }
  }

  Future<List<UserModel>> getUsers(
      {List<UserModel>? except, required UserModel currentUser}) async {
    if (except != null) {
      final collection = await fireStore.collection(usersCollection).get();
      final docs = collection.docs;
      docs.removeWhere(
        (element) => except.any((ex) => ex.uid == element.id),
      );
      return docs
          .map((e) => UserModel.fromJson(
                e.data(),
              ))
          .toList();
    } else {
      final collection = await fireStore.collection(usersCollection).get();

      return collection.docs
          .where(
            (element) => element.id != currentUser.uid,
          )
          .map(
            (e) => UserModel.fromJson(
              e.data(),
            ),
          )
          .toList();
    }
  }

  Future<UserModel> signUpWithEmailAndPassword(
    String email,
    String password,
    String surname,
    String name,
  ) async {
    try {
      final userCr = await firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      final indexLinear = Random().nextInt(ColorGen.listLinears.length - 1);

      final user = UserDto(
        uid: userCr.user?.uid,
        email: userCr.user?.email,
        name: name,
        surname: surname,
        linearColors: ColorGen.listLinears[indexLinear],
      );

      fireStore
          .collection(usersCollection)
          .doc(userCr.user?.uid)
          .set(user.toJson());

      return user.toEntity();
    } on FirebaseAuthException catch (e) {
      throw (e.code);
    }
  }
}
