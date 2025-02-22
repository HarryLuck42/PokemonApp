import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:poke_app/core/extention/extention.dart';
import 'package:poke_app/initial/locale/localizations.dart';

import '../../core/constraint/asset_path.dart';
import '../../core/constraint/spacer.dart';
import '../../widgets/custom_icon.dart';
import '../../widgets/custom_text.dart';

class EmptyState extends StatelessWidget {
  const EmptyState({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: context.getWidth(),
      height: context.getHeight(),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: context.getHeight() * 0.2,
            ),
            CustomIcon(
              iconData: "${AssetPath.vector}empty.svg",
              width: 200.w,
              height: 200.h,
              defaultColor: false,
            ),
            gapH8,
            CustomText(
                textToDisplay: lang(context).noDataFound ?? "No data found",
                textStyle: context.getTextTheme().titleMedium?.copyWith(
                    color: context.getColorScheme().secondary,
                    fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}
