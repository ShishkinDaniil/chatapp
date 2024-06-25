// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MessageDto _$MessageDtoFromJson(Map<String, dynamic> json) => MessageDto(
      messageTxt: json['messageTxt'],
      sentTime: json['sentTime'],
      imgUrl: json['imgUrl'],
      senderId: json['senderId'],
    );

Map<String, dynamic> _$MessageDtoToJson(MessageDto instance) =>
    <String, dynamic>{
      'messageTxt': instance.messageTxt,
      'sentTime': instance.sentTime,
      'imgUrl': instance.imgUrl,
      'senderId': instance.senderId,
    };
