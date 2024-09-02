extension Capitalize on String {
  String get capitalize =>
      '${substring(0, 1).toUpperCase()}${substring(1, length)}';
}

extension Euqal on List<DateTime> {
  bool isContains(DateTime dateTime) {
    for (var date in this) {
      if (date.isEuqal(dateTime)) {
        return true;
      }
    }
    return false;
  }
}

extension DateEuqal on DateTime {
  bool isEuqal(DateTime dateTime) =>
      dateTime.day == day && dateTime.month == month && dateTime.year == year;
}
