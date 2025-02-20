import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:poke_app/core/extention/extention.dart';
import 'package:poke_app/core/themes/app_colors.dart';

enum CustomSnackbarMode { error, success, warning }

class CustomSnackbar {
  static show(BuildContext context, CustomSnackbarMode mode, String textContent,
      {int durationInSeconds = 15, SnackBarAction? action}) {
    Color backgroundColor;

    if (mode == CustomSnackbarMode.error) {
      backgroundColor = redType;
    } else if (mode == CustomSnackbarMode.success) {
      backgroundColor = greenLight;
    } else {
      backgroundColor = orange;
    }

    final snackBar = SnackBar(
      content: Text(
        textContent,
        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
              color: context.getColorScheme().onPrimary,
            ),
      ),
      backgroundColor: backgroundColor,
      duration: Duration(seconds: durationInSeconds),
      action: action ??
          SnackBarAction(
            label: 'close',
            textColor: context.getColorScheme().onPrimary,
            onPressed: () {
              try {
                ScaffoldMessenger.of(context).hideCurrentSnackBar();
              } catch (e) {
                log('Snackbar cannot be closed due to different context');
              }
            },
          ),
    );

    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
