import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:poke_app/core/extention/extention.dart';
import 'package:poke_app/widgets/custom_icon.dart';

import '../../../core/constraint/asset_path.dart';
import '../../../core/constraint/const.dart';
import '../../../core/constraint/spacer.dart';
import '../../../model/response/pokemon_detail_response.dart';
import '../../../widgets/custom_image_network.dart';
import '../../../widgets/custom_text.dart';

class HeaderDetail extends StatelessWidget {
  final PokemonDetailResponse detail;

  const HeaderDetail({super.key, required this.detail});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding:
              EdgeInsets.only(left: 16.w, top: 8.h, bottom: 8.h, right: 8.w),
          child: CustomIcon(
            iconData: "${AssetPath.vector}pokeball.svg",
            defaultColor: false,
            width: 80.w,
            height: 80.h,
          ),
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ...[
                    (detail.name?.length ?? 0) > 17
                        ? Expanded(
                            child: CustomText(
                              textToDisplay: detail.name?.capitalize() ?? "-",
                              textStyle: context
                                  .getTextTheme()
                                  .titleLarge
                                  ?.copyWith(fontWeight: FontWeight.w700),
                              maxLines: 2,
                              textAlign: TextAlign.start,
                            ),
                          )
                        : CustomText(
                            textToDisplay: detail.name?.capitalize() ?? "-",
                            textStyle: context
                                .getTextTheme()
                                .titleLarge
                                ?.copyWith(fontWeight: FontWeight.w700),
                            maxLines: 2,
                            textAlign: TextAlign.start,
                          ),
                  ],
                  ...detail.types
                          ?.map((e) => Container(
                              margin: const EdgeInsets.symmetric(horizontal: 6),
                              child: CustomIcon(
                                  width: 30.w,
                                  height: 30.h,
                                  defaultColor: false,
                                  iconData:
                                      "${AssetPath.vector}${typePath[e.type?.name ?? 'normal'] ?? 'normal.svg'}")))
                          .toList() ??
                      []
                ],
              ),
              Row(
                children: [
                  Builder(builder: (context) {
                    final images = <String>[];
                    if (detail.sprites?.frontDefault != null) {
                      images.add(detail.sprites!.frontDefault!);
                    }
                    if (detail.sprites?.frontFemale != null) {
                      images.add(detail.sprites!.frontFemale!);
                    }
                    if (detail.sprites?.frontShiny != null) {
                      images.add(detail.sprites!.frontShiny!);
                    }
                    if (detail.sprites?.frontShinyFemale != null) {
                      images.add(detail.sprites!.frontShinyFemale!);
                    }
                    return SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        spacing: 10.w,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: images
                            .map((e) => _pokemonImage(e, e.contains('female')))
                            .toList(),
                      ),
                    );
                  }),
                  gapW10
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _pokemonImage(String url, bool isFemale) {
    return Container(
      width: 45.w,
      height: 45.h,
      alignment: Alignment.center,
      child: Stack(
        children: [
          Positioned(
              child: Align(
            alignment: Alignment.center,
            child: AspectRatio(
              aspectRatio: 1.2,
              child: CustomImageNetwork(
                imageUrl: url,
                width: 45.w,
                height: 0.0,
                fit: BoxFit.cover,
              ),
            ),
          )),
          Positioned(
              bottom: 0,
              right: 0,
              child: CustomIcon(
                  width: 15.w,
                  height: 15.h,
                  defaultColor: false,
                  iconData:
                      "${AssetPath.vector}${isFemale ? "female.svg" : "male.svg"}"))
        ],
      ),
    );
  }
}
