import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:poke_app/core/base/base_state.dart';
import 'package:poke_app/core/constraint/const.dart';
import 'package:poke_app/core/extention/extention.dart';
import 'package:poke_app/core/routing/app_router.dart';
import 'package:poke_app/model/response/pokemon_response.dart';
import 'package:poke_app/widgets/custom_gesture.dart';

import '../../../widgets/custom_image_network.dart';
import '../../../widgets/custom_text.dart';

class PokemonAdapter extends StatefulWidget {
  final Pokemon pokemon;

  const PokemonAdapter({super.key, required this.pokemon});

  @override
  State<PokemonAdapter> createState() => _PokemonAdapterState();
}

class _PokemonAdapterState extends State<PokemonAdapter> with BaseState {
  @override
  void afterFirstLayout(BuildContext context) {}

  @override
  Widget build(BuildContext context) {
    final double itemHeight = context.getHeight();
    final id = widget.pokemon.url?.getId();
    return Container(
      margin: EdgeInsets.all(4.r),
      child: CustomGesture(
        onTap: () {
          context.goNamed(AppRoute.pokemonDetail.name,
              pathParameters: {"name": widget.pokemon.name ?? ""});
        },
        radius: 12,
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              boxShadow: const [
                BoxShadow(
                  color: Color.fromRGBO(0, 0, 0, 0.15),
                  blurRadius: 2.6,
                  spreadRadius: 0,
                  offset: Offset(
                    1.95,
                    1.95,
                  ),
                ),
              ],
              color: context.getColorScheme().secondaryContainer),
          child: Column(
            children: <Widget>[
              ClipRRect(
                borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(12),
                    topLeft: Radius.circular(12)),
                child: AspectRatio(
                  aspectRatio: 1,
                  child: CustomImageNetwork(
                    imageUrl: "$baseImageUrl$id.png",
                    width: double.infinity,
                    height: itemHeight * 0.17,
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 10, left: 10, right: 10),
                child: CustomText(
                  textToDisplay: widget.pokemon.name?.capitalize() ?? "-",
                  textStyle: context
                      .getTextTheme()
                      .bodyMedium
                      ?.copyWith(fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
