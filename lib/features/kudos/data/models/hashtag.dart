import 'package:freezed_annotation/freezed_annotation.dart';

part 'hashtag.freezed.dart';
part 'hashtag.g.dart';

@freezed
class Hashtag with _$Hashtag {
  const factory Hashtag({required int id, required String name}) = _Hashtag;

  factory Hashtag.fromJson(Map<String, dynamic> json) =>
      _$HashtagFromJson(json);
}
