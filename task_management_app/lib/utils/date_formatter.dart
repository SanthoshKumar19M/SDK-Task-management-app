import 'package:intl/intl.dart';

String formatDate(String? dateString) {
  if (dateString == null || dateString.isEmpty) {
    return "N/A";
  }
  try {
    DateTime date = DateTime.parse(dateString);
    return DateFormat('dd MMM yyyy').format(date);
  } catch (e) {
    return "Invalid Date";
  }
}
