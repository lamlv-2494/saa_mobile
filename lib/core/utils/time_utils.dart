import 'package:saa_mobile/i18n/strings.g.dart';

/// Formats a [DateTime] relative to now as a human-readable string
/// using the app's current locale translations.
String formatKudosTimeAgo(DateTime createdAt) {
  final diff = DateTime.now().difference(createdAt);
  if (diff.inDays > 0) {
    return t.kudos.daysAgo.replaceAll('{count}', '${diff.inDays}');
  }
  if (diff.inHours > 0) {
    return t.kudos.hoursAgo.replaceAll('{count}', '${diff.inHours}');
  }
  if (diff.inMinutes > 0) {
    return t.kudos.minutesAgo.replaceAll('{count}', '${diff.inMinutes}');
  }
  return t.kudos.justNow;
}
