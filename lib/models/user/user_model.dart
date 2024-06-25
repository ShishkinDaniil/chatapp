import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

@JsonSerializable()
class UserModel {
  final String uid;
  final String surname;
  final String name;
  final String email;
  final List<int> linearColors;

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);
  Map<String, dynamic> toJson() => _$UserModelToJson(this);

  UserModel({
    required this.uid,
    required this.surname,
    required this.name,
    required this.email,
    required this.linearColors,
  });

  UserModel copyWith({
    String? uid,
    String? surname,
    String? name,
    String? email,
    List<int>? linearColors,
    Timestamp? lastActive,
  }) {
    return UserModel(
      uid: uid ?? this.uid,
      surname: surname ?? this.surname,
      name: name ?? this.name,
      email: email ?? this.email,
      linearColors: linearColors ?? this.linearColors,
    );
  }
}
