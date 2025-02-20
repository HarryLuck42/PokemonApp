import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

import '../constraint/sp_keys.dart';
import '../memory/shared/share_preference.dart';
import '../themes/app_colors.dart';

class Helper {
  Helper._private();

  static final Helper _instance = Helper._private();

  factory Helper() {
    return _instance;
  }

  Future<bool> checkConnections() async {
    bool connection = false;
    try {
      final result = await InternetConnection().hasInternetAccess;
      connection = result;
    } on SocketException catch (_) {
      connection = false;
    }
    return connection;
  }

  void systemUIOverlayTheme() {
    bool theme = SharedPreference().readStorage(SpKeys.isLightTheme) ?? true;
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarIconBrightness: theme ? Brightness.light : Brightness.dark,
      statusBarColor: theme ? surface : lightSurface,
      systemNavigationBarIconBrightness:
          theme ? Brightness.light : Brightness.dark,
      systemNavigationBarColor: theme ? surface : lightSurface,
    ));
  }

  Color getColorType(String type) {
    switch (type) {
      case 'Retailer':
        return greenType;
      case 'Wholesaler':
        return blueType;
      case 'Dealer':
        return redType;
      case 'Supplier':
        return purpleType;
      default:
        return Colors.white;
    }
  }

  String generateSKU() {
    const chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
    Random rnd = Random();
    final result = String.fromCharCodes(Iterable.generate(
        3, (_) => chars.codeUnitAt(rnd.nextInt(chars.length))));
    return "MHZ$result";
  }
}
