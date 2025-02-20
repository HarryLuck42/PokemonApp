import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:poke_app/core/extention/extention.dart';
import 'package:poke_app/widgets/custom_loading.dart';

class CustomIcon extends StatelessWidget {
  final Color? color;
  final String iconData;
  final double? width;
  final double? height;
  final bool defaultColor;
  final bool isNetwork;
  final BoxFit? fit;
  const CustomIcon(
      {super.key,
      required this.iconData,
      this.color,
      this.width,
      this.height,
      this.defaultColor = true,
      this.isNetwork = false,
      this.fit});

  @override
  Widget build(BuildContext context) {
    return UnconstrainedBox(
      child: !isNetwork
          ? SvgPicture.asset(
              iconData,
              width: width,
              height: height,
              colorFilter: color != null
                  ? ColorFilter.mode(
                      defaultColor
                          ? context.getColorScheme().secondary
                          : color!,
                      BlendMode.srcIn)
                  : null,
              fit: fit ?? BoxFit.contain,
              allowDrawingOutsideViewBox: true,
            )
          : SvgPicture.network(
              iconData,
              width: width,
              height: height,
              colorFilter: color != null
                  ? ColorFilter.mode(
                      defaultColor
                          ? context.getColorScheme().secondary
                          : color!,
                      BlendMode.srcIn)
                  : null,
              fit: fit ?? BoxFit.contain,
              placeholderBuilder: (context) {
                return const Center(
                  child: CustomLoading(size: 12),
                );
              },
            ),
    );
  }
}
