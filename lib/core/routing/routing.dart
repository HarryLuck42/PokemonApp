import 'package:flutter/material.dart';

class Routing {
  Routing._private();

  static final Routing _instance = Routing._private();

  factory Routing() {
    return _instance;
  }

  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();
  static final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
      GlobalKey<ScaffoldMessengerState>();
}
