import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';

String chooseFormat(String period, time) {
  final map = {
    'live': 'h:mma',
    '1d': 'h:mma',
    '1w': 'hh:mma, MMM d',
    '1m': 'hh:mma, MMM d',
    '3m': 'MMM d, yyyy',
    '1y': 'MMM d, yyyy',
    'ytd': 'MMM d, yyyy',
  };

  final dateFormat = map[period] ?? 'yMd';
  if (period == '1w' || period == '1m') {
    return DateFormat(dateFormat).format(DateTime.parse(time)).toString();
  }
  return DateFormat(dateFormat).format(DateTime.parse(time)).toString();
}

String formatField(data, field) {
  switch (field) {
    case 'name':
      return data.name;
    case 'value' || 'totalValue':
      return formatMoney(data.getValue(field).toString());
    case 'quantity':
      return data.quantity.toString();
    default:
      return '${data.getValue(field)}%';
  }
}

String formatMoney(value) {
  value = value.toString();
  final numberFormat = NumberFormat.currency(symbol: '\$');
  final moneyValue = double.parse(value.replaceAll(',', ''));
  return numberFormat.format(moneyValue);
}

String formatPercent(double value) {
  return '${(value * 100).toStringAsFixed(2)}%';
}

String formatPercentage(double gainLoss) {
  String sign = (gainLoss >= 0) ? '+' : '-';
  double absoluteChange = gainLoss.abs();
  return '$sign ${absoluteChange.toStringAsFixed(2)} %';
}

String formatTime(DateTime startTime, DateTime endTime) {
  Duration difference = endTime.difference(startTime);
  int hours = difference.inHours;
  int minutes = difference.inMinutes.remainder(60);
  int seconds = difference.inSeconds.remainder(60);
  return '$hours:${twoDigits(minutes)}:${twoDigits(seconds)}';
}

String formatTimeAgo(Duration duration) {
  if (duration.inDays >= 365) {
    final years = (duration.inDays / 365).floor();
    return '$years ${years == 1 ? 'year' : 'years'} ago';
  } else if (duration.inDays >= 1) {
    return '${duration.inDays} ${duration.inDays == 1 ? 'day' : 'days'} ago';
  } else if (duration.inHours >= 1) {
    return '${duration.inHours} ${duration.inHours == 1 ? 'hour' : 'hours'} ago';
  } else if (duration.inMinutes >= 1) {
    return '${duration.inMinutes} ${duration.inMinutes == 1 ? 'minute' : 'minutes'} ago';
  } else {
    return 'Just now';
  }
}

String formatTimeDifference(Duration duration) {
  String twoDigits(int n) => n.toString().padLeft(2, '0');

  int hours = duration.inHours;
  int minutes = duration.inMinutes.remainder(60);
  int seconds = duration.inSeconds.remainder(60);

  return '${twoDigits(hours)}:${twoDigits(minutes)}:${twoDigits(seconds)}';
}

String formatValueChange(double newValue, double oldValue) {
  double valueChange = newValue - oldValue;
  String sign = (valueChange >= 0) ? '+' : '-';
  double absoluteChange = valueChange.abs();
  return '$sign ${formatMoney(absoluteChange.toStringAsFixed(2))}';
}

getTimeAgo() {
  final now = DateTime.now();
  final then = FirebaseAuth.instance.currentUser!.metadata.creationTime;
  final timeDifference = now.difference(then!);
  final formatted = formatTimeAgo(timeDifference);
  return formatted;
}

String twoDigits(int n) {
  if (n >= 10) {
    return '$n';
  }
  return '0$n';
}
