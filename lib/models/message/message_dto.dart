import 'package:freezed_annotation/freezed_annotation.dart';

part 'message_dto.g.dart';

@JsonSerializable()
class MessageDto {
  final dynamic messageTxt;
  final dynamic sentTime;
  final dynamic imgUrl;
  final dynamic senderId;

  MessageDto({
    required this.messageTxt,
    required this.sentTime,
    required this.imgUrl,
    required this.senderId,
  });

  factory MessageDto.fromJson(Map<String, dynamic> json) =>
      _$MessageDtoFromJson(json);
  Map<String, dynamic> toJson() => _$MessageDtoToJson(this);
}
