import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:poke_app/core/constraint/asset_path.dart';
import 'package:poke_app/core/constraint/spacer.dart';
import 'package:poke_app/core/extention/extention.dart';
import 'package:poke_app/core/routing/app_router.dart';
import 'package:poke_app/initial/locale/localizations.dart';
import 'package:poke_app/layout/choose_pokemon/bloc/choose_pokemon_bloc.dart';
import 'package:poke_app/layout/choose_pokemon/component/comparing_item.dart';
import 'package:poke_app/layout/comparing_pokemon/argument/comparing_pokemon_argument.dart';
import 'package:poke_app/model/response/pokemon_response.dart';
import 'package:poke_app/widgets/custom_icon.dart';

import '../../../widgets/custom_elevated_button.dart';
import '../../../widgets/custom_text.dart';

class BottomComparingPokemon extends StatelessWidget {
  final Pokemon? first;
  final Pokemon? second;

  const BottomComparingPokemon({super.key, this.first, this.second});

  @override
  Widget build(BuildContext context) {
    final isPortrait = context.isPortrait();
    return Container(
      width: isPortrait ? double.infinity : null,
      height: isPortrait ? null : context.getHeight(),
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: context.getColorScheme().onSecondary,
      ),
      child: isPortrait
          ? Column(
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
                  ],
                ),
                gapH16,
                BlocBuilder<ChoosePokemonBloc, ChoosePokemonState>(
                  builder: (context, state) {
                    return Row(
                      children: [
                        Expanded(
                          child: CustomElevatedButton(
                            width: double.infinity,
                            height: 40.h,
                            function: () {
                              context
                                  .read<ChoosePokemonBloc>()
                                  .add(RemoveFirst());
                              context
                                  .read<ChoosePokemonBloc>()
                                  .add(RemoveSecond());
                            },
                            child: CustomText(
                              textToDisplay: lang(context).clear ?? "Clear",
                              textStyle: context
                                  .getTextTheme()
                                  .bodySmall
                                  ?.copyWith(
                                      color:
                                          context.getColorScheme().onPrimary),
                            ),
                          ),
                        ),
                        if (state.first != null && state.second != null) gapW10,
                        if (state.first != null && state.second != null)
                          Expanded(
                            child: CustomElevatedButton(
                              width: double.infinity,
                              height: 40.h,
                              function: () {
                                if (state.first != null &&
                                    state.second != null) {
                                  context.goNamed(AppRoute.pokemonCompared.name,
                                      extra: ComparingPokemonArgument(
                                          first: state.first!,
                                          second: state.second!));
                                  context
                                      .read<ChoosePokemonBloc>()
                                      .add(RemoveFirst());
                                  context
                                      .read<ChoosePokemonBloc>()
                                      .add(RemoveSecond());
                                }
                              },
                              child: CustomText(
                                textToDisplay:
                                    lang(context).comparing ?? "Compare",
                                textStyle: context
                                    .getTextTheme()
                                    .bodySmall
                                    ?.copyWith(
                                        color:
                                            context.getColorScheme().onPrimary),
                              ),
                            ),
                          ),
                      ],
                    );
                  },
                )
              ],
            )
          : Row(
              children: [
                Column(
                  spacing: 4.w,
                  children: [
                    Expanded(
                        child: first != null
                            ? ComparingItem(pokemon: first!)
                            : const SizedBox.shrink()),
                    CustomIcon(
                      iconData: "${AssetPath.vector}comparing.svg",
                      width: 20.r,
                      height: 20.r,
                      color: context.getColorScheme().primary,
                    ),
                    Expanded(
                        child: second != null
                            ? ComparingItem(pokemon: second!)
                            : const SizedBox.shrink()),
                  ],
                ),
                gapW10,
                BlocBuilder<ChoosePokemonBloc, ChoosePokemonState>(
                  builder: (context, state) {
                    return Column(
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              context
                                  .read<ChoosePokemonBloc>()
                                  .add(RemoveFirst());
                              context
                                  .read<ChoosePokemonBloc>()
                                  .add(RemoveSecond());
                            },
                            child: Container(
                              padding: EdgeInsets.all(8.r),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8.0),
                                  color: context.getColorScheme().primary),
                              child: Icon(
                                Icons.clear,
                                size: 30.r,
                                color: context.getColorScheme().onPrimary,
                              ),
                            ),
                          ),
                        ),
                        if (state.first != null && state.second != null) gapH10,
                        if (state.first != null && state.second != null)
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                if (state.first != null &&
                                    state.second != null) {
                                  context.goNamed(AppRoute.pokemonCompared.name,
                                      extra: ComparingPokemonArgument(
                                          first: state.first!,
                                          second: state.second!));
                                  context
                                      .read<ChoosePokemonBloc>()
                                      .add(RemoveFirst());
                                  context
                                      .read<ChoosePokemonBloc>()
                                      .add(RemoveSecond());
                                }
                              },
                              child: Container(
                                padding: EdgeInsets.all(8.r),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8.0),
                                    color: context.getColorScheme().primary),
                                child: Icon(
                                  Icons.compare,
                                  size: 30.r,
                                  color: context.getColorScheme().onPrimary,
                                ),
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
