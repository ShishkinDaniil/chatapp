// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'room_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RoomDto _$RoomDtoFromJson(Map<String, dynamic> json) => RoomDto(
      uid: json['uid'],
      participants: (json['participants'] as List<dynamic>)
          .map((e) => UserDto.fromJson(e as Map<String, dynamic>))
          .toList(),
      lastMessage:
          MessageDto.fromJson(json['lastMessage'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$RoomDtoToJson(RoomDto instance) => <String, dynamic>{
      'uid': instance.uid,
      'participants': instance.participants,
      'lastMessage': instance.lastMessage,
    };
