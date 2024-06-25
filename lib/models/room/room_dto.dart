import 'package:chatapp/models/message/message_dto.dart';
import 'package:chatapp/models/user/user_dto.dart';
import 'package:json_annotation/json_annotation.dart';

part 'room_dto.g.dart';

@JsonSerializable()
class RoomDto {
  final dynamic uid;
  final List<UserDto> participants;
  final MessageDto lastMessage;

  RoomDto({
    required this.uid,
    required this.participants,
    required this.lastMessage,
  });

  factory RoomDto.fromJson(Map<String, dynamic> json) =>
      _$RoomDtoFromJson(json);
  Map<String, dynamic> toJson() => _$RoomDtoToJson(this);
}
