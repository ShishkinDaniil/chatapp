// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MessageModel _$MessageModelFromJson(Map<String, dynamic> json) => MessageModel(
      messageTxt: json['messageTxt'] as String,
      sentTime:
          const TimestampConverter().fromJson(json['sentTime'] as Timestamp),
      imgUrl: json['imgUrl'] as String,
      senderId: json['senderId'] as String,
    );

Map<String, dynamic> _$MessageModelToJson(MessageModel instance) =>
    <String, dynamic>{
      'messageTxt': instance.messageTxt,
      'sentTime': const TimestampConverter().toJson(instance.sentTime),
      'imgUrl': instance.imgUrl,
      'senderId': instance.senderId,
    };
