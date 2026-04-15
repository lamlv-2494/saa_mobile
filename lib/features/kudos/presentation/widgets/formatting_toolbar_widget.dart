import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:saa_mobile/app/theme/app_colors.dart';
import 'package:saa_mobile/gen/assets.gen.dart';

/// Formatting toolbar with Bold, Italic, Strikethrough, Ordered List,
/// Link, and Quote buttons.
class FormattingToolbarWidget extends StatelessWidget {
  const FormattingToolbarWidget({
    super.key,
    required this.controller,
  });

  final TextEditingController controller;

  void _applyFormat(String prefix, String suffix) {
    final text = controller.text;
    final selection = controller.selection;
    if (!selection.isValid) return;

    final selectedText = selection.textInside(text);
    final newText = selection.textBefore(text) +
        prefix +
        selectedText +
        suffix +
        selection.textAfter(text);

    controller.value = TextEditingValue(
      text: newText,
      selection: TextSelection.collapsed(
        offset: selection.baseOffset + prefix.length + selectedText.length + suffix.length,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: const Color(0x802E3940),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          _ToolbarButton(
            label: 'B',
            bold: true,
            onTap: () => _applyFormat('**', '**'),
          ),
          const SizedBox(width: 8),
          _ToolbarButton(
            label: 'I',
            italic: true,
            onTap: () => _applyFormat('_', '_'),
          ),
          const SizedBox(width: 8),
          _ToolbarButton(
            label: 'S',
            strikethrough: true,
            onTap: () => _applyFormat('~~', '~~'),
          ),
          const SizedBox(width: 8),
          _ToolbarButton(
            label: '1.',
            onTap: () => _applyFormat('\n1. ', ''),
          ),
          const SizedBox(width: 8),
          _ToolbarIconButton(
            iconData: Icons.link,
            onTap: () => _applyFormat('[', '](url)'),
          ),
          const SizedBox(width: 8),
          _ToolbarButton(
            label: '❝',
            onTap: () => _applyFormat('> ', ''),
          ),
        ],
      ),
    );
  }
}

class _ToolbarButton extends StatelessWidget {
  const _ToolbarButton({
    required this.label,
    required this.onTap,
    this.bold = false,
    this.italic = false,
    this.strikethrough = false,
  });

  final String label;
  final VoidCallback onTap;
  final bool bold;
  final bool italic;
  final bool strikethrough;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: 32,
        height: 32,
        child: Center(
          child: Text(
            label,
            style: GoogleFonts.montserrat(
              fontSize: 14,
              fontWeight: bold ? FontWeight.w700 : FontWeight.w400,
              fontStyle: italic ? FontStyle.italic : FontStyle.normal,
              decoration:
                  strikethrough ? TextDecoration.lineThrough : TextDecoration.none,
              color: const Color(0x99FFFFFF),
            ),
          ),
        ),
      ),
    );
  }
}

class _ToolbarIconButton extends StatelessWidget {
  const _ToolbarIconButton({required this.iconData, required this.onTap});

  final IconData iconData;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: 32,
        height: 32,
        child: Center(
          child: Icon(iconData, size: 20, color: const Color(0x99FFFFFF)),
        ),
      ),
    );
  }
}
