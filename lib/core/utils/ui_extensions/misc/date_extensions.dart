import 'package:intl/intl.dart';

// التحويل بين صيغ مختلفة (yyyy-MM-dd, dd/MM/yyyy, إلخ)

// عرض الوقت منذ الآن (time ago) بدقة ودعم الثواني، الدقائق، الساعات، الأيام، الأشهر، السنوات

// إضافة/طرح أيام، ساعات، دقائق بسهولة

// التنسيق الذكي حسب الوقت الحالي (اليوم، أمس، قبل أسبوع، قبل شهر)

// تحويل للـ UTC أو Local

extension DateTimeUtils on DateTime {
  /// Convert to formatted string
  String format({String pattern = "yyyy-MM-dd HH:mm", bool utc = false}) {
    final dt = utc ? toUtc() : toLocal();
    return DateFormat(pattern).format(dt);
  }

  /// Time ago from now
  String timeAgo({bool short = false}) {
    final now = DateTime.now();
    final diff = now.difference(this);

    if (diff.inSeconds < 60) {
      return short ? "now" : "Just now";
    }
    if (diff.inMinutes < 60) {
      return short ? "${diff.inMinutes}m" : "${diff.inMinutes} minutes ago";
    }
    if (diff.inHours < 24) {
      return short ? "${diff.inHours}h" : "${diff.inHours} hours ago";
    }
    if (diff.inDays == 1) {
      return short ? "1d" : "Yesterday";
    }
    if (diff.inDays < 7) {
      return short ? "${diff.inDays}d" : "${diff.inDays} days ago";
    }
    if (diff.inDays < 30) {
      return short
          ? "${(diff.inDays / 7).floor()}w"
          : "${(diff.inDays / 7).floor()} week(s) ago";
    }
    if (diff.inDays < 365) {
      return short
          ? "${(diff.inDays / 30).floor()}mo"
          : "${(diff.inDays / 30).floor()} month(s) ago";
    }
    return short
        ? "${(diff.inDays / 365).floor()}y"
        : "${(diff.inDays / 365).floor()} year(s) ago";
  }

  /// Add days, hours, minutes
  DateTime addDays(int days) => add(Duration(days: days));
  DateTime addHours(int hours) => add(Duration(hours: hours));
  DateTime addMinutes(int minutes) => add(Duration(minutes: minutes));

  /// Subtract days, hours, minutes
  DateTime subtractDays(int days) => subtract(Duration(days: days));
  DateTime subtractHours(int hours) => subtract(Duration(hours: hours));
  DateTime subtractMinutes(int minutes) => subtract(Duration(minutes: minutes));

  /// Start of day
  DateTime get startOfDay => DateTime(year, month, day);

  /// End of day
  DateTime get endOfDay => DateTime(year, month, day, 23, 59, 59);

  /// Check if today
  bool get isToday {
    final now = DateTime.now();
    return year == now.year && month == now.month && day == now.day;
  }

  /// Check if yesterday
  bool get isYesterday {
    final yesterday = DateTime.now().subtract(const Duration(days: 1));
    return year == yesterday.year &&
        month == yesterday.month &&
        day == yesterday.day;
  }

  /// Check if same day
  bool isSameDay(DateTime other) =>
      year == other.year && month == other.month && day == other.day;

  /// Convert to UTC
  DateTime get toUtcTime => toUtc();

  /// Convert to Local
  DateTime get toLocalTime => toLocal();
}
