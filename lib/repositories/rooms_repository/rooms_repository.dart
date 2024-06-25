import 'package:chatapp/models/room/room_model.dart';
import 'package:chatapp/models/user/user_model.dart';
import 'package:chatapp/utils/base_firestore.dart';

class RoomsRepository extends BaseFireBaseRepository {
  RoomsRepository({
    required super.firebaseDatabase,
    required super.firebaseAuth,
    required super.fireStore,
  });

  Future<List<RoomModel>> getRooms(UserModel user) async {
    List<RoomModel> rooms = [];

    final doc = await fireStore
        .collection(roomsCollection)
        .where(
          'participants',
          arrayContains: user.toJson(),
        )
        .get();

    if (doc.docs.isNotEmpty) {
      rooms = doc.docs.map((e) => RoomModel.fromJson(e.data())).toList();
    }

    return rooms;
  }
}
