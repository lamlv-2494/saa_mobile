import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

import 'package:saa_mobile/app/theme/app_colors.dart';
import 'package:saa_mobile/features/kudos/presentation/viewmodels/send_kudos_viewmodel.dart';
import 'package:saa_mobile/i18n/strings.g.dart';

class ImageAttachmentWidget extends ConsumerWidget {
  const ImageAttachmentWidget({super.key});

  static const int _maxImages = 4;

  Future<void> _pickImage(BuildContext context, WidgetRef ref) async {
    final t = Translations.of(context);
    final picker = ImagePicker();
    final XFile? file = await picker.pickImage(
      source: ImageSource.gallery,
      maxWidth: 1920,
      maxHeight: 1920,
      imageQuality: 85,
    );

    if (file == null) return;

    final ext = file.name.split('.').last.toLowerCase();
    if (!['jpg', 'jpeg', 'png', 'heic'].contains(ext)) {
      if (context.mounted) {
        _showError(context, t.sendKudos.imageFormatError);
      }
      return;
    }

    final bytes = await file.readAsBytes();
    final sizeInMb = bytes.length / (1024 * 1024);
    if (sizeInMb > 5) {
      if (context.mounted) {
        _showError(context, t.sendKudos.imageSizeError.replaceAll('{max}', '5'));
      }
      return;
    }

    await ref
        .read(sendKudosViewModelProvider.notifier)
        .addImage(bytes: bytes, ext: ext);
  }

  void _showError(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: AppColors.errorRed),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(sendKudosViewModelProvider).value;
    final previews = state?.imagePreviews ?? [];
    final canAdd = previews.length < _maxImages;

    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: [
        ...previews.asMap().entries.map(
              (e) => _ImageThumbnail(
                url: e.value,
                onRemove: () => ref
                    .read(sendKudosViewModelProvider.notifier)
                    .removeImage(e.key),
              ),
            ),
        if (canAdd)
          _AddImageButton(
            onTap: () => _pickImage(context, ref),
          ),
      ],
    );
  }
}

class _ImageThumbnail extends StatelessWidget {
  const _ImageThumbnail({required this.url, required this.onRemove});

  final String url;
  final VoidCallback onRemove;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 56,
      height: 56,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.network(
              url,
              width: 56,
              height: 56,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  color: const Color(0x1AFFEA9E),
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ),
          Positioned(
            top: -4,
            right: -4,
            child: GestureDetector(
              onTap: onRemove,
              child: Container(
                width: 18,
                height: 18,
                decoration: const BoxDecoration(
                  color: AppColors.errorRed,
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.close, size: 12, color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _AddImageButton extends StatelessWidget {
  const _AddImageButton({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 56,
        height: 56,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: const Color(0xFF998C5F),
            style: BorderStyle.solid,
          ),
        ),
        child: const Center(
          child: Icon(
            Icons.camera_alt_outlined,
            size: 24,
            color: AppColors.textSecondary,
          ),
        ),
      ),
    );
  }
}
