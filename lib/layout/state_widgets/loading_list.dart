import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:poke_app/core/extention/extention.dart';
import 'package:poke_app/initial/locale/localizations.dart';

import '../../core/constraint/spacer.dart';
import '../../widgets/custom_loading.dart';
import '../../widgets/custom_text.dart';

class LoadingList extends StatelessWidget {
  const LoadingList({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CustomLoading(
            size: 20.r,
          ),
          gapH8,
          CustomText(
              textToDisplay: lang(context).loading ?? "Loading",
              textStyle: context.getTextTheme().bodyMedium)
        ],
      ),
    );
  }
}
