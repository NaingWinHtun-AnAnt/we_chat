import 'package:json_annotation/json_annotation.dart';
import 'package:we_chat/data/vos/message_vo.dart';

part 'conversation_vo.g.dart';

@JsonSerializable(explicitToJson: true, anyMap: true)
class ConversationVO {
  @JsonKey(name: "id")
  int id;

  @JsonKey(name: "userName")
  String? userName;

  @JsonKey(name: "messages")
  List<MessageVO?>? messages;

  @JsonKey(name: "profilePath")
  String? profilePath;

  ConversationVO({
    required this.id,
    this.userName,
    this.messages,
    this.profilePath,
  });

  factory ConversationVO.fromJson(Map<String, dynamic> json) =>
      _$ConversationVOFromJson(json);

  Map<String, dynamic> toJson() => _$ConversationVOToJson(this);
}
