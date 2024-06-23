import 'dart:async';
import 'dart:math';

import 'package:chatapp/models/user/user_dto.dart';
import 'package:chatapp/models/user/user_model.dart';
import 'package:chatapp/utils/base_firestore.dart';
import 'package:chatapp/utils/color_gen.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthRepository extends BaseFireBaseRepository {
  AuthRepository({
    required super.firebaseAuth,
    required super.fireStore,
  });

  Stream<User?> get streamAuthState => firebaseAuth.authStateChanges();

  Future<UserCredential> signInWithEmailAndPassword(
    String email,
    String password,
  ) async {
    try {
      final userCr = await firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      return userCr;
    } on FirebaseAuthException catch (e) {
      throw (e.code);
    }
  }

  Future<void> chageOnlineStatus(bool status) async {
    final uid = currentUser?.uid;
    if (uid != null) {
      final collection =
          await fireStore.collection(usersCollection).doc(uid).get();
      final data = collection.data();
      if (data != null) {
        final user = UserDto.fromJson(
          data,
        );
        if (user.isOnline != status) {
          final onlineUser = user.copyWith(isOnline: status);
          await fireStore.collection(usersCollection).doc(uid).set(
                onlineUser.toJson(),
              );
        }
      }
    }
  }

  Future<List<UserModel>> getUsers() async {
    final collection = await fireStore.collection(usersCollection).get();
    return collection.docs
        .where(
          (element) => element.id != currentUser?.uid,
        )
        .map(
          (e) => UserDto.fromJson(
            e.data(),
          ).toEntity(),
        )
        .toList();
  }

  Future<UserCredential> signUpWithEmailAndPassword(
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
        email: userCr.user?.email,
        name: name,
        surname: surname,
        linearColors: ColorGen.listLinears[indexLinear],
      );

      fireStore
          .collection(usersCollection)
          .doc(userCr.user?.uid)
          .set(user.toJson());

      return userCr;
    } on FirebaseAuthException catch (e) {
      throw (e.code);
    }
  }
}
