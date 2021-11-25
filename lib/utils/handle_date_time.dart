String getFormattedUploadedTime(String? dateTime) {
  String timeAgo = '';
  String timeUnit = '';
  int timeValue = 0;

  if (dateTime != null) {
    final DateTime date = DateTime.parse(dateTime);
    final int diffInHours = DateTime.now().difference(date).inHours;

    if (diffInHours < 1) {
      final diffInMinutes = DateTime.now().difference(date).inMinutes;
      timeValue = diffInMinutes;
      timeUnit = 'minute';
    } else if (diffInHours < 24) {
      timeValue = diffInHours;
      timeUnit = 'hour';
    } else if (diffInHours >= 24 && diffInHours < 168) {
      timeValue = (diffInHours / 24).floor();
      timeUnit = 'day';
    } else if (diffInHours >= 168 && diffInHours < 720) {
      timeValue = (diffInHours / 168).floor();
      timeUnit = 'week';
    } else if (diffInHours >= 720 && diffInHours < 8760) {
      timeValue = (diffInHours / 720).floor();
      timeUnit = 'month';
    } else {
      timeValue = (diffInHours / 8760).floor();
      timeUnit = 'year';
    }

    timeAgo = timeValue.toString() + ' ' + timeUnit;
    timeAgo += timeValue > 1 ? 's' : '';

    return timeValue == 0 ? "Just Now" : "$timeAgo ago";
  }

  return timeAgo;
}
