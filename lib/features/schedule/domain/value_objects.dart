final class LocalDate implements Comparable<LocalDate> {
  factory LocalDate(int year, int month, int day) {
    final candidate = DateTime.utc(year, month, day);
    if (candidate.year != year ||
        candidate.month != month ||
        candidate.day != day) {
      throw ArgumentError.value(
        '$year-$month-$day',
        'date',
        'Date is not valid.',
      );
    }
    return LocalDate._(year, month, day);
  }

  const LocalDate._(this.year, this.month, this.day);

  factory LocalDate.parse(String value) {
    final match = RegExp(r'^(\d{4})-(\d{2})-(\d{2})$').firstMatch(value);
    if (match == null) {
      throw FormatException('Expected an ISO local date.', value);
    }
    return LocalDate(
      int.parse(match.group(1)!),
      int.parse(match.group(2)!),
      int.parse(match.group(3)!),
    );
  }

  final int year;
  final int month;
  final int day;

  int get weekday => _asUtc.weekday;

  LocalDate addDays(int days) {
    final next = _asUtc.add(Duration(days: days));
    return LocalDate(next.year, next.month, next.day);
  }

  int daysUntil(LocalDate other) {
    return other._asUtc.difference(_asUtc).inDays;
  }

  DateTime get _asUtc => DateTime.utc(year, month, day);

  @override
  int compareTo(LocalDate other) {
    return _asUtc.compareTo(other._asUtc);
  }

  @override
  bool operator ==(Object other) {
    return other is LocalDate &&
        year == other.year &&
        month == other.month &&
        day == other.day;
  }

  @override
  int get hashCode => Object.hash(year, month, day);

  @override
  String toString() {
    final yearText = year.toString().padLeft(4, '0');
    final monthText = month.toString().padLeft(2, '0');
    final dayText = day.toString().padLeft(2, '0');
    return '$yearText-$monthText-$dayText';
  }
}

final class DateRange {
  DateRange({required this.start, required this.end}) {
    if (start.compareTo(end) > 0) {
      throw ArgumentError('Date range start must not be after end.');
    }
  }

  final LocalDate start;
  final LocalDate end;

  bool contains(LocalDate date) {
    return start.compareTo(date) <= 0 && end.compareTo(date) >= 0;
  }

  Iterable<LocalDate> get dates sync* {
    var current = start;
    while (current.compareTo(end) <= 0) {
      yield current;
      current = current.addDays(1);
    }
  }
}

final class ShiftId {
  ShiftId(this.value) {
    if (value.trim().isEmpty) {
      throw ArgumentError.value(value, 'value', 'Shift ID must not be empty.');
    }
  }

  final String value;

  @override
  bool operator ==(Object other) => other is ShiftId && value == other.value;

  @override
  int get hashCode => value.hashCode;

  @override
  String toString() => value;
}

final class RuleId {
  RuleId(this.value) {
    if (value.trim().isEmpty) {
      throw ArgumentError.value(value, 'value', 'Rule ID must not be empty.');
    }
  }

  final String value;

  @override
  bool operator ==(Object other) => other is RuleId && value == other.value;

  @override
  int get hashCode => value.hashCode;

  @override
  String toString() => value;
}

final class WorkMinutes {
  WorkMinutes(this.value) {
    if (value < 0) {
      throw ArgumentError.value(
        value,
        'value',
        'Minutes must be non-negative.',
      );
    }
  }

  final int value;
}
