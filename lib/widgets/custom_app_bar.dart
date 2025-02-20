import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:poke_app/core/extention/extention.dart';
import 'package:poke_app/widgets/custom_icon_button.dart';

import '../core/constraint/asset_path.dart';
import 'custom_icon.dart';

// ignore: non_constant_identifier_names
PreferredSizeWidget CustomAppBar(BuildContext context, String title,
    {bool isBack = true, List<Widget>? actions, Function()? onOpenDrawer}) {
  return AppBar(
    actions: actions,
    leading: onOpenDrawer != null
        ? CustomIconButton(
            iconData: "${AssetPath.vector}navigation.svg",
            defaultColor: false,
            color: context.getColorScheme().primary,
            onPressed: onOpenDrawer)
        : isBack
            ? kIsWeb
                ? IconButton(
                    onPressed: () {
                      context.pop();
                    },
                    icon: Icon(
                      Icons.arrow_back,
                      color: context.getColorScheme().primary,
                    ))
                : IconButton(
                    onPressed: () {
                      context.pop();
                    },
                    icon: CustomIcon(
                      iconData: '${AssetPath.vector}back_arrow.svg',
                      defaultColor: false,
                      color: context.getColorScheme().primary,
                    ),
                  )
            : null,
    title: Text(
      title,
      style: context.getTheme().textTheme.titleSmall?.copyWith(
          fontWeight: FontWeight.w600, color: context.getColorScheme().primary),
    ),
    iconTheme: const IconThemeData(color: Colors.black),
    centerTitle: true,
    backgroundColor: context.getColorScheme().onPrimary,
    elevation: 1.0,
  );
}
