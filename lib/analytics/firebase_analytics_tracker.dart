import 'package:firebase_analytics/firebase_analytics.dart';

class FirebaseAnalyticsTracker {
  static final FirebaseAnalyticsTracker _singleton =
      FirebaseAnalyticsTracker._internal();

  factory FirebaseAnalyticsTracker() => _singleton;

  FirebaseAnalyticsTracker._internal();

  /// firebase analytics instance
  final FirebaseAnalytics _analytics = FirebaseAnalytics.instance;

  Future logEvent(String name, {Map<String, String>? parameters}) {
    return _analytics.logEvent(name: name, parameters: parameters);
  }
}
