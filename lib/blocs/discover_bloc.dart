import 'package:flutter/material.dart';
import 'package:we_chat/analytics/firebase_analytics_tracker.dart';
import 'package:we_chat/network/firebase_constants.dart';

class DiscoverBloc extends ChangeNotifier {
  DiscoverBloc() {
    /// log discover page reach
    FirebaseAnalyticsTracker().logEvent(discoverScreenReached);
  }
}
