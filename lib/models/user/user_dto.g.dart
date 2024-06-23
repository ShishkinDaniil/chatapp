// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserDto _$UserDtoFromJson(Map<String, dynamic> json) => UserDto(
      uid: json['uid'],
      surname: json['surname'],
      name: json['name'],
      email: json['email'],
      linearColors: json['linearColors'],
      isOnline: json['isOnline'],
    );

Map<String, dynamic> _$UserDtoToJson(UserDto instance) => <String, dynamic>{
      'uid': instance.uid,
      'surname': instance.surname,
      'name': instance.name,
      'email': instance.email,
      'linearColors': instance.linearColors,
      'isOnline': instance.isOnline,
    };
