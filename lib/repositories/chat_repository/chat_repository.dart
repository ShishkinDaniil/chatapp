import 'package:chatapp/models/message/message_model.dart';
import 'package:chatapp/models/room/room_model.dart';
import 'package:chatapp/models/user/user_model.dart';
import 'package:chatapp/utils/base_firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:uuid/uuid.dart';

class ChatRepository extends BaseFireBaseRepository {
  ChatRepository({
    required super.firebaseDatabase,
    required super.firebaseAuth,
    required super.fireStore,
  });

  Stream<DatabaseEvent> getOnlineStatusSnapshot(String userUid) {
    final snapshot = onlineStatusDatabase.child(userUid).onValue;
    return snapshot;
  }

  Future<RoomModel> sentMessage(
      String message, UserModel currentUser, UserModel recvUser,
      {RoomModel? roomModel}) async {
    final messageModel = MessageModel(
      messageTxt: message,
      sentTime: DateTime.now(),
      imgUrl: '',
      senderId: currentUser.uid,
    );
    if (roomModel == null) {
      final uidRoom = const Uuid().v4();
      final collectionMessage =
          await startConversation(recvUser, currentUser, uidRoom);
      final uidMessageDoc = const Uuid().v4();

      await collectionMessage.doc(uidMessageDoc).set(messageModel.toJson());

      await fireStore.collection(roomsCollection).doc(uidRoom).update(
        {
          'lastMessage': messageModel.toJson(),
          'uid': uidRoom,
        },
      );

      return RoomModel(
        uid: uidRoom,
        participants: [currentUser, recvUser],
        lastMessage: messageModel,
      );
    } else {
      final uidMessageDoc = const Uuid().v4();

      fireStore
          .collection(roomsCollection)
          .doc(roomModel.uid)
          .collection(messagesCollection)
          .doc(uidMessageDoc)
          .set(messageModel.toJson());
      await fireStore
          .collection(roomsCollection)
          .doc(roomModel.uid)
          .update({'lastMessage': messageModel.toJson()});
      return roomModel;
    }
  }

  Future<CollectionReference> startConversation(
      UserModel recvUser, UserModel currentUser, String uidCollection) async {
    await fireStore.collection(roomsCollection).doc(uidCollection).set({
      'participants': [
        currentUser.toJson(),
        recvUser.toJson(),
      ],
    });
    return fireStore
        .collection(roomsCollection)
        .doc(uidCollection)
        .collection(messagesCollection);
  }

  Future<List<MessageModel>> getMessages(RoomModel roomModel) async {
    final messages = await fireStore
        .collection(roomsCollection)
        .doc(roomModel.uid)
        .collection(messagesCollection)
        .get();
    return messages.docs.map((e) => MessageModel.fromJson(e.data())).toList();
  }

  Future<Stream<QuerySnapshot<Map<String, dynamic>>>> getMessagesSnapshot(
      RoomModel roomModel) async {
    return fireStore
        .collection(roomsCollection)
        .doc(roomModel.uid)
        .collection(messagesCollection)
        .snapshots();
  }
}
