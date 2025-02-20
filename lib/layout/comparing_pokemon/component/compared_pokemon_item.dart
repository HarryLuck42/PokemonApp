import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:poke_app/core/constraint/spacer.dart';
import 'package:poke_app/core/extention/extention.dart';
import 'package:poke_app/model/response/pokemon_detail_response.dart';

import '../../../core/constraint/const.dart';
import '../../../widgets/custom_image_network.dart';
import '../../../widgets/custom_text.dart';

class ComparedPokemonItem extends StatelessWidget {
  final PokemonDetailResponse detail;
  final Color color;
  const ComparedPokemonItem(
      {super.key, required this.detail, required this.color});

  @override
  Widget build(BuildContext context) {
    final isPortrait = context.isPortrait();
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: context.getColorScheme().onSecondary,
          boxShadow: const [
            BoxShadow(
              color: Color.fromRGBO(0, 0, 0, 0.24),
              blurRadius: 8,
              spreadRadius: 0,
              offset: Offset(
                0,
                3,
              ),
            ),
          ],
          borderRadius: BorderRadius.circular(10)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(12.r),
                topLeft: Radius.circular(12.r)),
            child: CustomImageNetwork(
              imageUrl: "$baseImageUrl${detail.id}.png",
              width: isPortrait ? 80.h : 100.h,
              height: isPortrait ? 80.h : 100.h,
              fit: BoxFit.fill,
            ),
          ),
          CustomText(
            textToDisplay: detail.name?.capitalize() ?? "",
            textStyle: context
                .getTextTheme()
                .bodySmall
                ?.copyWith(fontWeight: FontWeight.bold),
          ),
          gapH10,
          Container(
            width: double.infinity,
            height: 20.r,
            decoration: BoxDecoration(
                color: color, borderRadius: BorderRadius.circular(10.r)),
          )
        ],
      ),
    );
  }
}
