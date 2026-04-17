import 'package:freezed_annotation/freezed_annotation.dart';

part 'secret_box.freezed.dart';
part 'secret_box.g.dart';

@freezed
class SecretBox with _$SecretBox {
  const factory SecretBox({
    required String id,
    required String userId,
    @Default(false) bool isOpened,
    DateTime? openedAt,
    String? rewardType,
    String? rewardValue,
    DateTime? createdAt,
  }) = _SecretBox;

  factory SecretBox.fromJson(Map<String, dynamic> json) =>
      _$SecretBoxFromJson(json);
}
