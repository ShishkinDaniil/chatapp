import 'package:chatapp/models/user/user_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_dto.g.dart';

@JsonSerializable()
class UserDto {
  final dynamic uid;
  final dynamic surname;
  final dynamic name;
  final dynamic email;
  final dynamic linearColors;

  factory UserDto.fromJson(Map<String, dynamic> json) =>
      _$UserDtoFromJson(json);
  Map<String, dynamic> toJson() => _$UserDtoToJson(this);

  UserDto({
    this.uid,
    this.surname,
    this.name,
    this.email,
    this.linearColors,
  });

  UserDto copyWith({
    String? uid,
    String? surname,
    String? name,
    String? email,
    List<int>? linearColors,
  }) {
    return UserDto(
      uid: uid ?? this.uid,
      surname: surname ?? this.surname,
      name: name ?? this.name,
      email: email ?? this.email,
      linearColors: linearColors ?? this.linearColors,
    );
  }

  UserModel toEntity() {
    return UserModel(
      uid: uid,
      surname: surname,
      name: name,
      email: email,
      linearColors: (linearColors as List<dynamic>)
          .map((e) => (e as num).toInt())
          .toList(),
    );
  }
}
