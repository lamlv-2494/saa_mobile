import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:saa_mobile/app/theme/app_colors.dart';
import 'package:saa_mobile/features/home/presentation/widgets/countdown_digit_box.dart';
import 'package:saa_mobile/i18n/strings.g.dart';

class CountdownTimerWidget extends StatefulWidget {
  const CountdownTimerWidget({super.key, required this.eventDate});

  final DateTime eventDate;

  @override
  State<CountdownTimerWidget> createState() => _CountdownTimerWidgetState();
}

class _CountdownTimerWidgetState extends State<CountdownTimerWidget> {
  Timer? _timer;
  late Duration _remaining;

  @override
  void initState() {
    super.initState();
    _updateRemaining();
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      _updateRemaining();
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _updateRemaining() {
    final now = DateTime.now();
    final diff = widget.eventDate.difference(now);
    setState(() {
      _remaining = diff.isNegative ? Duration.zero : diff;
    });
  }

  @override
  Widget build(BuildContext context) {
    final days = _remaining.inDays;
    final hours = _remaining.inHours % 24;
    final minutes = _remaining.inMinutes % 60;

    return Row(
      children: [
        _CountdownUnit(
          value: days.toString().padLeft(2, '0'),
          label: t.home.days,
        ),
        const SizedBox(width: 16),
        _CountdownUnit(
          value: hours.toString().padLeft(2, '0'),
          label: t.home.hours,
        ),
        const SizedBox(width: 16),
        _CountdownUnit(
          value: minutes.toString().padLeft(2, '0'),
          label: t.home.minutes,
        ),
      ],
    );
  }
}

class _CountdownUnit extends StatelessWidget {
  const _CountdownUnit({required this.value, required this.label});

  final String value;
  final String label;

  @override
  Widget build(BuildContext context) {
    final digits = value.split('');

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: [
            CountdownDigitBox(digit: digits.isNotEmpty ? digits[0] : '0'),
            const SizedBox(width: 8),
            CountdownDigitBox(digit: digits.length > 1 ? digits[1] : '0'),
          ],
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: GoogleFonts.montserrat(
            fontSize: 18,
            fontWeight: FontWeight.w400,
            height: 24 / 18,
            letterSpacing: 0.5,
            color: AppColors.textWhite,
          ),
        ),
      ],
    );
  }
}
