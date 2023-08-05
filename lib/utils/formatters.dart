String formatTimeDifference(Duration duration) {
  String twoDigits(int n) => n.toString().padLeft(2, '0');

  int hours = duration.inHours;
  int minutes = duration.inMinutes.remainder(60);
  int seconds = duration.inSeconds.remainder(60);

  return '${twoDigits(hours)}:${twoDigits(minutes)}:${twoDigits(seconds)}';
}
