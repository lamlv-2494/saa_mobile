import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:saa_mobile/features/kudos/data/models/hashtag.dart';
import 'package:saa_mobile/features/kudos/data/models/send_kudos_state.dart';
import 'package:saa_mobile/features/kudos/data/models/user_summary.dart';
import 'package:saa_mobile/features/kudos/data/repositories/kudos_repository.dart';

class SendKudosViewModel extends AsyncNotifier<SendKudosState> {
  late KudosRepository _repository;
  Timer? _draftSyncDebounce;
  String? _lastDraftSignature;
  String? _currentUserId;

  @override
  FutureOr<SendKudosState> build() async {
    _repository = ref.read(kudosRepositoryProvider);
    ref.onDispose(() {
      _draftSyncDebounce?.cancel();
    });

    // Load hashtags, all users, and current user ID in parallel
    List<Hashtag> hashtags = [];
    List<UserSummary> users = [];
    try {
      final results = await Future.wait([
        _repository.getHashtags(),
        _repository.fetchAllUsers(),
        _repository.getCurrentUserId(),
      ]);
      hashtags = results[0] as List<Hashtag>;
      users = results[1] as List<UserSummary>;
      _currentUserId = results[2] as String?;
    } catch (_) {}

    return SendKudosState(availableHashtags: hashtags, allUsers: users);
  }

  // ─────────────────────────────────────────────────────────────
  // Recipient
  // ─────────────────────────────────────────────────────────────

  void selectRecipient({
    required String id,
    required String name,
    String? avatar,
  }) {
    _update(
      (s) => s.copyWith(
        recipientId: id,
        recipientName: name,
        recipientAvatar: avatar,
        isDirty: true,
        validationErrors: _removeKey(s.validationErrors, 'recipient'),
        showErrorBanner: false,
      ),
    );
  }

  void clearRecipient() {
    _update(
      (s) => s.copyWith(
        recipientId: null,
        recipientName: null,
        recipientAvatar: null,
      ),
    );
  }

  // ─────────────────────────────────────────────────────────────
  // Title & Message
  // ─────────────────────────────────────────────────────────────

  void updateTitle(String value) {
    _update(
      (s) => s.copyWith(
        title: value,
        isDirty: true,
        validationErrors: _removeKey(s.validationErrors, 'title'),
        showErrorBanner: false,
      ),
    );
  }

  void updateMessage(String value) {
    _update(
      (s) => s.copyWith(
        message: value,
        isDirty: true,
        validationErrors: _removeKey(s.validationErrors, 'message'),
        showErrorBanner: false,
      ),
    );
  }

  // ─────────────────────────────────────────────────────────────
  // Hashtags
  // ─────────────────────────────────────────────────────────────

  static const int maxHashtags = 5;

  void toggleHashtag(Hashtag hashtag) {
    _update((s) {
      final current = List<Hashtag>.from(s.hashtags);
      if (current.any((h) => h.id == hashtag.id)) {
        current.removeWhere((h) => h.id == hashtag.id);
      } else {
        if (current.length >= maxHashtags) return s;
        current.add(hashtag);
      }
      return s.copyWith(
        hashtags: current,
        isDirty: true,
        validationErrors: _removeKey(s.validationErrors, 'hashtag'),
        showErrorBanner: false,
      );
    });
  }

  // ─────────────────────────────────────────────────────────────
  // Anonymous toggle + Nickname
  // ─────────────────────────────────────────────────────────────

  void toggleAnonymous() {
    _update((s) {
      final newAnonymous = !s.isAnonymous;
      return s.copyWith(
        isAnonymous: newAnonymous,
        senderAlias: newAnonymous ? s.senderAlias : null,
      );
    });
  }

  void updateSenderAlias(String value) {
    _update((s) => s.copyWith(senderAlias: value, isDirty: true));
  }

  // ─────────────────────────────────────────────────────────────
  // Image attachment
  // ─────────────────────────────────────────────────────────────

  static const int maxImages = 5;

  Future<void> addImage({required List<int> bytes, required String ext}) async {
    final currentCount = state.value?.imagePreviews.length ?? 0;
    if (currentCount >= maxImages) return;

    String url;
    try {
      url = await _repository.uploadKudosImage(bytes: bytes, ext: ext);
    } catch (_) {
      return;
    }
    _update((s) {
      if (s.imagePreviews.length >= maxImages) return s;
      final previews = List<String>.from(s.imagePreviews)..add(url);
      return s.copyWith(imagePreviews: previews);
    });
  }

  Future<void> removeImage(int index) async {
    final previews = state.value?.imagePreviews ?? [];
    if (index < 0 || index >= previews.length) return;
    final url = previews[index];
    try {
      await _repository.deleteKudosImage(url);
    } catch (_) {}
    _update((s) {
      final updated = List<String>.from(s.imagePreviews)..removeAt(index);
      return s.copyWith(imagePreviews: updated);
    });
  }

  // ─────────────────────────────────────────────────────────────
  // Validation
  // ─────────────────────────────────────────────────────────────

  bool validate() {
    final s = state.value;
    if (s == null) return false;

    final errors = <String, String>{};
    if (s.recipientId == null || s.recipientId!.isEmpty) {
      errors['recipient'] = 'recipient_required';
    } else if (_currentUserId != null && s.recipientId == _currentUserId) {
      errors['recipient'] = 'recipient_self_send';
    }
    if (s.title.trim().isEmpty) errors['title'] = 'title_required';
    if (s.message.trim().isEmpty) errors['message'] = 'message_required';
    if (s.hashtags.isEmpty) errors['hashtag'] = 'hashtag_required';

    _update(
      (_) => s.copyWith(
        validationErrors: errors,
        showErrorBanner: errors.isNotEmpty,
        shakeKey: errors.isNotEmpty ? s.shakeKey + 1 : s.shakeKey,
      ),
    );

    return errors.isEmpty;
  }

  void dismissErrorBanner() {
    _update((s) => s.copyWith(showErrorBanner: false));
  }

  void clearFieldError(String field) {
    _update(
      (s) =>
          s.copyWith(validationErrors: _removeKey(s.validationErrors, field)),
    );
  }

  // ─────────────────────────────────────────────────────────────
  // Submit
  // ─────────────────────────────────────────────────────────────

  Future<String?> submit() async {
    if (!validate()) return null;

    final s = state.value!;
    _update((_) => s.copyWith(isSubmitting: true));

    try {
      final recipientIdInt = int.parse(s.recipientId!);
      final kudosId = await _repository.createKudos(
        recipientId: recipientIdInt,
        title: s.title,
        message: s.message,
        hashtagIds: s.hashtags.map((h) => h.id).toList(),
        imageUrls: s.imagePreviews,
        isAnonymous: s.isAnonymous,
        senderAlias: s.isAnonymous ? s.senderAlias : null,
      );
      await _repository.deleteSendKudosDraft();
      _update((curr) => curr.copyWith(isSubmitting: false));
      return kudosId;
    } catch (e) {
      _update((curr) => curr.copyWith(isSubmitting: false));
      return null;
    }
  }

  // ─────────────────────────────────────────────────────────────
  // Helpers
  // ─────────────────────────────────────────────────────────────

  void _update(SendKudosState Function(SendKudosState) updater) {
    final current = state.value;
    if (current == null) return;
    final next = updater(current);
    state = AsyncData(next);
    _scheduleDraftSync(next);
  }

  void _scheduleDraftSync(SendKudosState state) {
    final signature = _draftSignature(state);
    if (signature == _lastDraftSignature) return;

    _draftSyncDebounce?.cancel();
    _draftSyncDebounce = Timer(const Duration(milliseconds: 350), () async {
      try {
        if (_isDraftEmpty(state)) {
          await _repository.deleteSendKudosDraft();
          _lastDraftSignature = null;
          return;
        }

        await _repository.upsertSendKudosDraft(state);
        _lastDraftSignature = signature;
      } catch (_) {}
    });
  }

  bool _isDraftEmpty(SendKudosState state) {
    return (state.recipientId == null || state.recipientId!.isEmpty) &&
        state.title.isEmpty &&
        state.message.isEmpty &&
        state.hashtags.isEmpty &&
        state.imagePreviews.isEmpty &&
        !state.isAnonymous;
  }

  String _draftSignature(SendKudosState state) {
    final hashtags = state.hashtags.map((h) => '${h.id}:${h.name}').join('|');
    final images = state.imagePreviews.join('|');
    return [
      state.recipientId ?? '',
      state.title,
      state.message,
      hashtags,
      images,
      '${state.isAnonymous}',
      state.senderAlias ?? '',
    ].join('||');
  }

  Map<String, String> _removeKey(Map<String, String> map, String key) {
    return Map<String, String>.from(map)..remove(key);
  }
}

final sendKudosViewModelProvider =
    AsyncNotifierProvider<SendKudosViewModel, SendKudosState>(
      SendKudosViewModel.new,
    );
