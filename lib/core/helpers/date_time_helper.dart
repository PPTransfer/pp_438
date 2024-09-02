class DateTimeHelper {
  static String getHours(DateTime dateTime) =>
      dateTime.hour < 10 ? '0${dateTime.hour}' : dateTime.hour.toString();

  static String getMinutes(DateTime dateTime) =>
      dateTime.minute < 10 ? '0${dateTime.minute}' : dateTime.minute.toString();

  static String getMonthForamttedDate(DateTime dateTime) =>
      '${dateTime.day} ${months[dateTime.month - 1]}';

  static String getDDMMYY(DateTime dateTime) {
    final day = dateTime.day < 10 ? '0${dateTime.day}' : '${dateTime.day}';
    final month =
        dateTime.month < 10 ? '0${dateTime.month}' : '${dateTime.month}';
    return '$day.$month.${dateTime.year}';
  }

  static String getHHMM(DateTime dateTime) {
    final hours = dateTime.hour < 10 ? '0${dateTime.hour}' : dateTime.hour.toString();
    final minutes = dateTime.minute < 10 ? '0${dateTime.minute}' : dateTime.minute.toString();
    return '${hours}:$minutes';
  }

  static List<String> months = [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December'
  ];
}
