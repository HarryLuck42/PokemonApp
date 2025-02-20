import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:poke_app/core/extention/extention.dart';
import 'package:poke_app/initial/locale/localizations.dart';
import 'package:poke_app/layout/comparing_pokemon/bloc/comparing_pokemon_bloc.dart';

import '../../../core/constraint/asset_path.dart';
import '../../../core/constraint/spacer.dart';
import '../../../model/response/pokemon_response.dart';
import '../../../widgets/custom_elevated_button.dart';
import '../../../widgets/custom_icon.dart';
import '../../../widgets/custom_text.dart';
import '../../choose_pokemon/component/comparing_item.dart';
import '../argument/comparing_pokemon_argument.dart';

class BottomComparingPokemonDialog extends StatelessWidget {
  final Pokemon? first;
  final Pokemon? second;

  const BottomComparingPokemonDialog({super.key, this.first, this.second});

  @override
  Widget build(BuildContext context) {
    final isPortrait = context.isPortrait();
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: context.getColorScheme().onSecondary,
      ),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                  child: first != null
                      ? ComparingItem(pokemon: first!)
                      : const SizedBox.shrink()),
              gapW8,
              CustomIcon(
                iconData: "${AssetPath.vector}comparing.svg",
                width: 50.w,
                height: 50.h,
                color: context.getColorScheme().primary,
              ),
              gapW8,
              Expanded(
                  child: second != null
                      ? ComparingItem(pokemon: second!)
                      : const SizedBox.shrink()),
              if (!isPortrait) gapW16,
              if (!isPortrait)
                BlocBuilder<ComparingPokemonBloc, ComparingPokemonState>(
                  builder: (context, state) {
                    return Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            context
                                .read<ComparingPokemonBloc>()
                                .add(RemoveFirst());
                            context
                                .read<ComparingPokemonBloc>()
                                .add(RemoveSecond());
                          },
                          child: Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: context.getColorScheme().primary,
                              shape: BoxShape.circle,
                            ),
                            child: Icon(Icons.clear,
                                color: context.getColorScheme().onPrimary),
                          ),
                        ),
                        if (state.firstPokemon != null &&
                            state.secondPokemon != null)
                          gapH10,
                        if (state.firstPokemon != null &&
                            state.secondPokemon != null)
                          GestureDetector(
                            onTap: () {
                              if (state.firstPokemon != null &&
                                  state.secondPokemon != null) {
                                Navigator.pop(
                                    context,
                                    ComparingPokemonArgument(
                                        first: state.firstPokemon!,
                                        second: state.secondPokemon!));
                              }
                            },
                            child: Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: context.getColorScheme().primary,
                                shape: BoxShape.circle,
                              ),
                              child: Icon(Icons.compare,
                                  color: context.getColorScheme().onPrimary),
                            ),
                          ),
                      ],
                    );
                  },
                ),
            ],
          ),
          gapH16,
          if (isPortrait)
            BlocBuilder<ComparingPokemonBloc, ComparingPokemonState>(
              builder: (context, state) {
                return Row(
                  children: [
                    Expanded(
                      child: CustomElevatedButton(
                        width: double.infinity,
                        height: 40.h,
                        function: () {
                          context
                              .read<ComparingPokemonBloc>()
                              .add(RemoveFirst());
                          context
                              .read<ComparingPokemonBloc>()
                              .add(RemoveSecond());
                        },
                        child: CustomText(
                          textToDisplay: lang(context).clear ?? "Clear",
                          textStyle: context.getTextTheme().bodySmall?.copyWith(
                              color: context.getColorScheme().onPrimary),
                        ),
                      ),
                    ),
                    if (state.firstPokemon != null &&
                        state.secondPokemon != null)
                      gapW10,
                    if (state.firstPokemon != null &&
                        state.secondPokemon != null)
                      Expanded(
                        child: CustomElevatedButton(
                          width: double.infinity,
                          height: 40.h,
                          function: () {
                            if (state.firstPokemon != null &&
                                state.secondPokemon != null) {
                              Navigator.pop(
                                  context,
                                  ComparingPokemonArgument(
                                      first: state.firstPokemon!,
                                      second: state.secondPokemon!));
                            }
                          },
                          child: CustomText(
                            textToDisplay: lang(context).comparing ?? "Compare",
                            textStyle: context
                                .getTextTheme()
                                .bodySmall
                                ?.copyWith(
                                    color: context.getColorScheme().onPrimary),
                          ),
                        ),
                      ),
                  ],
                );
              },
            )
        ],
      ),
    );
  }
}
