import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:saa_mobile/features/kudos/data/models/hashtag.dart';
import 'package:saa_mobile/features/kudos/data/models/user_summary.dart';

part 'send_kudos_state.freezed.dart';

@freezed
class SendKudosState with _$SendKudosState {
  const SendKudosState._();

  const factory SendKudosState({
    String? recipientId,
    String? recipientName,
    String? recipientAvatar,
    @Default('') String title,
    @Default('') String message,
    @Default([]) List<Hashtag> hashtags,
    @Default([]) List<String> imagePreviews,
    @Default(false) bool isAnonymous,
    String? senderAlias,
    @Default(false) bool isSubmitting,
    @Default(false) bool isDirty,
    @Default([]) List<Hashtag> availableHashtags,
    @Default([]) List<UserSummary> allUsers,
    @Default(false) bool isLoadingUsers,
    @Default({}) Map<String, String> validationErrors,
    @Default(false) bool showErrorBanner,
    @Default(0) int shakeKey,
  }) = _SendKudosState;

  /// Returns true when all required fields are filled.
  bool get isFormValid =>
      recipientId != null &&
      recipientId!.isNotEmpty &&
      title.trim().isNotEmpty &&
      message.trim().isNotEmpty &&
      hashtags.isNotEmpty;
}
