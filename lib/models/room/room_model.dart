import 'package:chatapp/models/message/message_model.dart';
import 'package:chatapp/models/user/user_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'room_model.g.dart';

@JsonSerializable()
class RoomModel {
  final String uid;
  final List<UserModel> participants;
  @JsonKey(fromJson: MessageModel.fromJson)
  final MessageModel lastMessage;

  RoomModel({
    required this.uid,
    required this.participants,
    required this.lastMessage,
  });

  factory RoomModel.fromJson(Map<String, dynamic> json) =>
      _$RoomModelFromJson(json);
  Map<String, dynamic> toJson() => _$RoomModelToJson(this);
}
