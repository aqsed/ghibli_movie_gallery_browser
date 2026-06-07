extension TimeFormatStringExtension on String {
  String formatMinutesToHourAndMinute() {
    final minutes = this;
    final total = int.tryParse(minutes);

    if (total == null) {
      return minutes;
    }

    final hours = total ~/ 60;
    final remainingMinutes = total % 60;

    if (hours == 0) {
      return '${remainingMinutes}m';
    }

    return '${hours}h ${remainingMinutes}m';
  }
}
