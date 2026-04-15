import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:saa_mobile/app/theme/app_colors.dart';
import 'package:saa_mobile/features/kudos/presentation/viewmodels/send_kudos_viewmodel.dart';
import 'package:saa_mobile/features/kudos/presentation/widgets/cancel_confirmation_dialog.dart';
import 'package:saa_mobile/features/kudos/presentation/widgets/error_banner_widget.dart';
import 'package:saa_mobile/features/kudos/presentation/widgets/formatting_toolbar_widget.dart';
import 'package:saa_mobile/features/kudos/presentation/widgets/hashtag_chip_group_widget.dart';
import 'package:saa_mobile/features/kudos/presentation/widgets/hashtag_dropdown_widget.dart';
import 'package:saa_mobile/features/kudos/presentation/widgets/image_attachment_widget.dart';
import 'package:saa_mobile/features/kudos/presentation/widgets/recipient_dropdown_menu_widget.dart';
import 'package:saa_mobile/gen/assets.gen.dart';
import 'package:saa_mobile/i18n/strings.g.dart';

class SendKudosScreen extends ConsumerStatefulWidget {
  const SendKudosScreen({super.key});

  @override
  ConsumerState<SendKudosScreen> createState() => _SendKudosScreenState();
}

class _SendKudosScreenState extends ConsumerState<SendKudosScreen> {
  final TextEditingController _titleCtrl = TextEditingController();
  final TextEditingController _messageCtrl = TextEditingController();
  final TextEditingController _nicknameCtrl = TextEditingController();
  final FocusNode _titleFocus = FocusNode();
  final FocusNode _messageFocus = FocusNode();
  final ScrollController _scrollCtrl = ScrollController();
  final GlobalKey _errorBannerKey = GlobalKey();
  final _hashtagDropdownKey = GlobalKey<HashtagDropdownWidgetState>();

  static const int _maxTitle = 100;
  static const int _maxMessage = 1000;

  @override
  void initState() {
    super.initState();
    _titleCtrl.addListener(_onTitleChanged);
    _messageCtrl.addListener(_onMessageChanged);
    _nicknameCtrl.addListener(_onNicknameChanged);
  }

  @override
  void dispose() {
    _titleCtrl.removeListener(_onTitleChanged);
    _messageCtrl.removeListener(_onMessageChanged);
    _nicknameCtrl.removeListener(_onNicknameChanged);
    _titleCtrl.dispose();
    _messageCtrl.dispose();
    _nicknameCtrl.dispose();
    _titleFocus.dispose();
    _messageFocus.dispose();
    _scrollCtrl.dispose();
    super.dispose();
  }

  void _onTitleChanged() {
    ref
        .read(sendKudosViewModelProvider.notifier)
        .updateTitle(_titleCtrl.text);
  }

  void _onMessageChanged() {
    ref
        .read(sendKudosViewModelProvider.notifier)
        .updateMessage(_messageCtrl.text);
  }

  void _onNicknameChanged() {
    ref
        .read(sendKudosViewModelProvider.notifier)
        .updateSenderAlias(_nicknameCtrl.text);
  }

  Future<bool> _onWillPop() async {
    final state = ref.read(sendKudosViewModelProvider).value;
    if (state == null || !state.isDirty) return true;

    final confirm = await CancelConfirmationDialog.show(context);
    return confirm == true;
  }

  Future<void> _submit() async {
    final result =
        await ref.read(sendKudosViewModelProvider.notifier).submit();
    if (!mounted) return;
    if (result != null) {
      Navigator.of(context).pop(true);
    } else {
      _scrollToErrorBanner();
    }
  }

  void _scrollToErrorBanner() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final ctx = _errorBannerKey.currentContext;
      if (ctx != null) {
        Scrollable.ensureVisible(
          ctx,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      } else {
        _scrollCtrl.animateTo(
          0,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  void _cancel() async {
    final canPop = await _onWillPop();
    if (canPop && mounted) {
      Navigator.of(context).pop(false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final asyncState = ref.watch(sendKudosViewModelProvider);
    final state = asyncState.value;
    final isSubmitting = state?.isSubmitting ?? false;
    final isFormValid = state?.isFormValid ?? false;
    final errors = state?.validationErrors ?? {};
    final showErrorBanner = state?.showErrorBanner ?? false;
    final shakeKey = state?.shakeKey ?? 0;

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, _) async {
        if (didPop) return;
        final canPop = await _onWillPop();
        if (canPop && context.mounted) Navigator.of(context).pop(false);
      },
      child: Scaffold(
        backgroundColor: AppColors.bgDark,
        body: SafeArea(
          child: Column(
            children: [
              // ── App Bar ──
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                child: Row(
                  children: [
                    Assets.icons.icKudosLogo.svg(height: 28),
                    const Spacer(),
                    Text(
                      t.sendKudos.title,
                      style: GoogleFonts.montserrat(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                    ),
                    const Spacer(),
                    const SizedBox(width: 40), // balance
                  ],
                ),
              ),
              const Divider(color: AppColors.divider, height: 1),

              // ── Body ──
              Expanded(
                child: asyncState.isLoading
                    ? const Center(
                        child: CircularProgressIndicator(
                          color: AppColors.textAccent,
                        ),
                      )
                    : SingleChildScrollView(
                        controller: _scrollCtrl,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 20,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Header subtitle
                            Text(
                              t.sendKudos.headerSubtitle,
                              style: GoogleFonts.montserrat(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(height: 20),

                            // Error banner
                            if (showErrorBanner)
                              ErrorBannerWidget(
                                key: _errorBannerKey,
                                message: t.sendKudos.validationBanner,
                                shakeKey: shakeKey,
                              ),

                            // ── Recipient ──
                            _FieldLabel(
                              label: t.sendKudos.recipientLabel,
                            ),
                            const SizedBox(height: 8),
                            RecipientDropdownMenuWidget(
                              hasError: errors.containsKey('recipient'),
                            ),
                            if (errors.containsKey('recipient'))
                              _ErrorText(errors['recipient']!.localizedError(t)),
                            const SizedBox(height: 16),

                            // ── Title ──
                            _FieldLabel(label: t.sendKudos.titleLabel),
                            const SizedBox(height: 8),
                            _StyledTextField(
                              controller: _titleCtrl,
                              focusNode: _titleFocus,
                              hintText: t.sendKudos.titlePlaceholder,
                              maxLength: _maxTitle,
                              hasError: errors.containsKey('title'),
                            ),
                            if (errors.containsKey('title'))
                              _ErrorText(errors['title']!.localizedError(t)),
                            const SizedBox(height: 4),
                            Text(
                              t.sendKudos.titleHint,
                              style: GoogleFonts.montserrat(
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                color: AppColors.textSecondary,
                              ),
                            ),
                            const SizedBox(height: 16),

                            // ── Message ──
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                FormattingToolbarWidget(
                                    controller: _messageCtrl),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: FittedBox(
                                    child: GestureDetector(
                                      onTap: () => launchUrl(
                                        Uri.parse(
                                            'https://sun-asterisk.com/kudos-guidelines'),
                                      ),
                                      child: Text(
                                        t.sendKudos.communityStandards,
                                        style: GoogleFonts.montserrat(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500,
                                          color: AppColors.textAccent,
                                          decoration: TextDecoration.underline,
                                          decorationColor: AppColors.textAccent,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 4),
                            _StyledTextField(
                              controller: _messageCtrl,
                              focusNode: _messageFocus,
                              hintText: t.sendKudos.messagePlaceholder,
                              maxLength: _maxMessage,
                              maxLines: 6,
                              hasError: errors.containsKey('message'),
                            ),
                            if (errors.containsKey('message'))
                              _ErrorText(errors['message']!.localizedError(t)),
                            const SizedBox(height: 6),
                            Text(
                              t.sendKudos.mentionHint,
                              style: GoogleFonts.montserrat(
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                color: AppColors.textSecondary,
                              ),
                            ),
                            const SizedBox(height: 16),

                            // ── Hashtags ──
                            _FieldLabel(label: t.sendKudos.hashtagLabel),
                            const SizedBox(height: 8),
                            Stack(
                              clipBehavior: Clip.none,
                              children: [
                                HashtagChipGroupWidget(
                                  selectedHashtags: state?.hashtags ?? [],
                                  onRemove: (tag) => ref
                                      .read(sendKudosViewModelProvider.notifier)
                                      .toggleHashtag(tag),
                                  onAddTap: () =>
                                      _hashtagDropdownKey.currentState?.open(),
                                  hasError: errors.containsKey('hashtag'),
                                ),
                                HashtagDropdownWidget(
                                    key: _hashtagDropdownKey),
                              ],
                            ),
                            if (errors.containsKey('hashtag'))
                              _ErrorText(errors['hashtag']!.localizedError(t)),
                            const SizedBox(height: 16),

                            // ── Images ──
                            Text(
                              t.sendKudos.imageAttach,
                              style: GoogleFonts.montserrat(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(height: 8),
                            const ImageAttachmentWidget(),
                            const SizedBox(height: 16),

                            // ── Anonymous + Nickname ──
                            _AnonymousToggle(
                              value: state?.isAnonymous ?? false,
                              label: t.sendKudos.anonymousLabel,
                              hint: t.sendKudos.anonymousHint,
                              onChanged: (_) => ref
                                  .read(sendKudosViewModelProvider.notifier)
                                  .toggleAnonymous(),
                            ),
                            AnimatedCrossFade(
                              firstChild: const SizedBox.shrink(),
                              secondChild: Padding(
                                padding: const EdgeInsets.only(
                                    left: 40, top: 8),
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                  children: [
                                    _StyledTextField(
                                      controller: _nicknameCtrl,
                                      hintText: t.sendKudos
                                          .anonymousNicknamePlaceholder,
                                      maxLength: 50,
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      t.sendKudos.anonymousNicknameHint,
                                      style: GoogleFonts.montserrat(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400,
                                        color: AppColors.textSecondary,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              crossFadeState:
                                  (state?.isAnonymous ?? false)
                                      ? CrossFadeState.showSecond
                                      : CrossFadeState.showFirst,
                              duration:
                                  const Duration(milliseconds: 200),
                            ),
                            const SizedBox(height: 20),
                          ],
                        ),
                      ),
              ),

              // ── Bottom Action Bar ──
              const Divider(color: AppColors.divider, height: 1),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                child: Row(
                  children: [
                    // Cancel
                    Expanded(
                      flex: 1,
                      child: _CancelButton(
                        onTap: isSubmitting ? null : _cancel,
                        label: t.sendKudos.cancelButton,
                        isDisabled: isSubmitting,
                      ),
                    ),
                    const SizedBox(width: 12),
                    // Send
                    Expanded(
                      flex: 2,
                      child: _SendButton(
                        onTap: isSubmitting ? null : _submit,
                        label: isSubmitting
                            ? t.sendKudos.sending
                            : t.sendKudos.sendButton,
                        isEnabled: isFormValid && !isSubmitting,
                        isLoading: isSubmitting,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────
// Sub-widgets
// ─────────────────────────────────────────────────────────────

class _FieldLabel extends StatelessWidget {
  const _FieldLabel({required this.label});
  final String label;

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: GoogleFonts.montserrat(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: AppColors.textAccent,
      ),
    );
  }
}

class _ErrorText extends StatelessWidget {
  const _ErrorText(this.text);
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 4),
      child: Text(
        text,
        style: GoogleFonts.montserrat(
          fontSize: 12,
          color: AppColors.errorRed,
        ),
      ),
    );
  }
}

class _StyledTextField extends StatelessWidget {
  const _StyledTextField({
    required this.controller,
    required this.hintText,
    this.focusNode,
    this.maxLength,
    this.maxLines = 1,
    this.hasError = false,
  });

  final TextEditingController controller;
  final FocusNode? focusNode;
  final String hintText;
  final int? maxLength;
  final int maxLines;
  final bool hasError;

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);

    return Focus(
      child: Builder(
        builder: (ctx) {
          final hasFocus = Focus.of(ctx).hasFocus;
          final borderColor = hasError
              ? AppColors.errorRed
              : hasFocus
                  ? AppColors.textAccent
                  : const Color(0xFF998C5F);

          return Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: const Color(0x1AFFEA9E),
                  borderRadius: BorderRadius.circular(4),
                  border: Border.all(color: borderColor),
                ),
                child: TextField(
                  controller: controller,
                  focusNode: focusNode,
                  maxLines: maxLines,
                  maxLength: maxLength,
                  style: GoogleFonts.montserrat(
                    fontSize: 14,
                    color: Colors.white,
                  ),
                  decoration: InputDecoration(
                    hintText: hintText,
                    hintStyle: GoogleFonts.montserrat(
                      fontSize: 14,
                      color: AppColors.textSecondary,
                    ),
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.all(12),
                    counterText: '',
                  ),
                ),
              ),
              if (maxLength != null)
                Padding(
                  padding: const EdgeInsets.only(top: 4),
                  child: ValueListenableBuilder<TextEditingValue>(
                    valueListenable: controller,
                    builder: (_, val, _) => Text(
                      t.sendKudos.charCount
                          .replaceAll('{current}', '${val.text.length}')
                          .replaceAll('{max}', '$maxLength'),
                      style: GoogleFonts.montserrat(
                        fontSize: 12,
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}

class _AnonymousToggle extends StatelessWidget {
  const _AnonymousToggle({
    required this.value,
    required this.label,
    required this.hint,
    required this.onChanged,
  });

  final bool value;
  final String label;
  final String hint;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Checkbox(
          value: value,
          onChanged: (v) => onChanged(v ?? false),
          activeColor: AppColors.textAccent,
          checkColor: AppColors.bgDark,
          side: const BorderSide(color: Color(0xFF998C5F)),
        ),
        const SizedBox(width: 4),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: GoogleFonts.montserrat(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: Colors.white,
                ),
              ),
              Text(
                hint,
                style: GoogleFonts.montserrat(
                  fontSize: 12,
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _CancelButton extends StatelessWidget {
  const _CancelButton({
    required this.label,
    this.onTap,
    this.isDisabled = false,
  });

  final String label;
  final VoidCallback? onTap;
  final bool isDisabled;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 48,
        decoration: BoxDecoration(
          color: isDisabled
              ? const Color(0x7F2E3940)
              : const Color(0xFF2E3940),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.close,
              size: 16,
              color: isDisabled
                  ? Colors.white.withValues(alpha: 0.5)
                  : Colors.white,
            ),
            const SizedBox(width: 6),
            Text(
              label,
              style: GoogleFonts.montserrat(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: isDisabled
                    ? Colors.white.withValues(alpha: 0.5)
                    : Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SendButton extends StatelessWidget {
  const _SendButton({
    required this.label,
    this.onTap,
    this.isEnabled = true,
    this.isLoading = false,
  });

  final String label;
  final VoidCallback? onTap;
  final bool isEnabled;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isEnabled ? onTap : null,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeInOut,
        height: 48,
        decoration: BoxDecoration(
          color: isEnabled
              ? AppColors.buttonBg
              : AppColors.sendButtonDisabledBg,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (isLoading) ...[
              const SizedBox(
                width: 16,
                height: 16,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: AppColors.bgDark,
                ),
              ),
              const SizedBox(width: 8),
            ],
            Text(
              label,
              style: GoogleFonts.montserrat(
                fontSize: 14,
                fontWeight: FontWeight.w700,
                color: isEnabled
                    ? AppColors.buttonText
                    : AppColors.sendButtonDisabledText,
              ),
            ),
            if (!isLoading) ...[
              const SizedBox(width: 8),
              Icon(
                Icons.arrow_forward,
                size: 16,
                color: isEnabled
                    ? AppColors.buttonText
                    : AppColors.sendButtonDisabledText,
              ),
            ],
          ],
        ),
      ),
    );
  }
}

extension on String {
  String localizedError(dynamic t) {
    // Map internal error keys to localized strings
    switch (this) {
      case 'recipient_required':
        return (t as dynamic).sendKudos.validationRecipient as String;
      case 'recipient_self_send':
        return (t as dynamic).sendKudos.validationSelfSend as String;
      case 'title_required':
        return (t as dynamic).sendKudos.validationTitle as String;
      case 'message_required':
        return (t as dynamic).sendKudos.validationMessage as String;
      case 'hashtag_required':
        return (t as dynamic).sendKudos.validationHashtag as String;
      default:
        return this;
    }
  }
}
