// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
      uid: json['uid'] as String,
      surname: json['surname'] as String,
      name: json['name'] as String,
      email: json['email'] as String,
      linearColors: (json['linearColors'] as List<dynamic>)
          .map((e) => (e as num).toInt())
          .toList(),
      isOnline: json['isOnline'] as bool,
    );

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
      'uid': instance.uid,
      'surname': instance.surname,
      'name': instance.name,
      'email': instance.email,
      'linearColors': instance.linearColors,
      'isOnline': instance.isOnline,
    };
