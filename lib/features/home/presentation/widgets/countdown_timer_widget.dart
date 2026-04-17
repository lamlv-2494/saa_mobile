import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:saa_mobile/app/theme/app_colors.dart';
import 'package:saa_mobile/features/home/data/repositories/countdown_repository.dart';
import 'package:saa_mobile/features/home/presentation/widgets/countdown_digit_box.dart';
import 'package:saa_mobile/i18n/strings.g.dart';

class CountdownTimerWidget extends StatefulWidget {
  const CountdownTimerWidget({
    super.key,
    required this.repository,
    DateTime Function()? nowBuilder,
  }) : nowBuilder = nowBuilder ?? DateTime.now;

  final CountdownRepository repository;
  final DateTime Function() nowBuilder;

  @override
  State<CountdownTimerWidget> createState() => _CountdownTimerWidgetState();
}

class _CountdownTimerWidgetState extends State<CountdownTimerWidget> {
  Timer? _timer;
  DateTime? _endTime;
  Duration _remaining = Duration.zero;

  @override
  void initState() {
    super.initState();
    _bootstrap();
  }

  Future<void> _bootstrap() async {
    final endTime = await widget.repository.getOrInitEndTime();
    if (!mounted) return;
    _endTime = endTime;
    await _tick();
    if (!mounted) return;
    _timer = Timer.periodic(const Duration(seconds: 1), (_) => _tick());
  }

  Future<void> _tick() async {
    final endTime = _endTime;
    if (endTime == null) return;

    var remaining = endTime.difference(widget.nowBuilder());
    if (remaining.inSeconds <= 0) {
      final newEnd = await widget.repository.resetEndTime();
      if (!mounted) return;
      _endTime = newEnd;
      remaining = newEnd.difference(widget.nowBuilder());
    }
    if (!mounted) return;
    setState(() => _remaining = remaining);
  }

  @override
  void dispose() {
    _timer?.cancel();
    _timer = null;
    super.dispose();
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
          semanticsLabel: '$days ${t.home.days}',
        ),
        const SizedBox(width: 16),
        _CountdownUnit(
          value: hours.toString().padLeft(2, '0'),
          label: t.home.hours,
          semanticsLabel: '$hours ${t.home.hours}',
        ),
        const SizedBox(width: 16),
        _CountdownUnit(
          value: minutes.toString().padLeft(2, '0'),
          label: t.home.minutes,
          semanticsLabel: '$minutes ${t.home.minutes}',
          liveRegion: true,
        ),
      ],
    );
  }
}

class _CountdownUnit extends StatelessWidget {
  const _CountdownUnit({
    required this.value,
    required this.label,
    required this.semanticsLabel,
    this.liveRegion = false,
  });

  final String value;
  final String label;
  final String semanticsLabel;
  final bool liveRegion;

  @override
  Widget build(BuildContext context) {
    final digits = value.split('');

    return Semantics(
      label: semanticsLabel,
      liveRegion: liveRegion,
      child: Column(
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
      ),
    );
  }
}
