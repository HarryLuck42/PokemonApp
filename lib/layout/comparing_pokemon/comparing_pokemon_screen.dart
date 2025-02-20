import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:poke_app/core/base/base_state.dart';
import 'package:poke_app/core/constraint/spacer.dart';
import 'package:poke_app/core/extention/extention.dart';
import 'package:poke_app/core/themes/app_colors.dart';
import 'package:poke_app/layout/comparing_pokemon/bloc/comparing_pokemon_bloc.dart';
import 'package:poke_app/layout/comparing_pokemon/component/history_comparing.dart';
import 'package:poke_app/layout/comparing_pokemon/component/pokemon_bar_chart.dart';
import 'package:poke_app/layout/comparing_pokemon/component/pokemon_radar_chart.dart';
import 'package:poke_app/layout/comparing_pokemon/component/pokemon_stats.dart';
import 'package:poke_app/layout/comparing_pokemon/dialog/choose_pokemon_dialog.dart';
import 'package:poke_app/layout/state_widgets/empty_state.dart';
import 'package:poke_app/layout/state_widgets/no_connection_state.dart';
import 'package:poke_app/widgets/custom_icon_button.dart';

import '../../core/constraint/asset_path.dart';
import '../../initial/locale/localizations.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/custom_loading.dart';
import 'argument/comparing_pokemon_argument.dart';

class ComparingPokemonScreen extends StatefulWidget {
  final ComparingPokemonArgument argument;

  const ComparingPokemonScreen({super.key, required this.argument});

  @override
  State<ComparingPokemonScreen> createState() => _ComparingPokemonScreenState();
}

class _ComparingPokemonScreenState extends State<ComparingPokemonScreen>
    with BaseState {
  final PageController _pageController = PageController();
  @override
  void afterFirstLayout(BuildContext context) {
    context.read<ComparingPokemonBloc>().add(GetFirstDetail(
        name: widget.argument.first.name ?? "",
        secondName: widget.argument.second.name ?? ""));
  }

  @override
  Widget build(BuildContext context) {
    final isPortrait = context.isPortrait();
    return Scaffold(
      appBar: CustomAppBar(
          context, "Pokemon ${lang(context).comparing ?? "Comparing"}",
          actions: [
            CustomIconButton(
                iconData: "${AssetPath.vector}comparing.svg",
                height: 20.h,
                width: 20.h,
                defaultColor: false,
                color: context.getColorScheme().primary,
                onPressed: () async {
                  dynamic data = await showModalBottomSheet(
                      shape: const RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.vertical(top: Radius.circular(16)),
                      ),
                      context: context,
                      isScrollControlled: true,
                      builder: (context) {
                        return const ChoosePokemonDialog();
                      });
                  if (data is ComparingPokemonArgument) {
                    context.read<ComparingPokemonBloc>().add(GetFirstDetail(
                        name: data.first.name ?? "",
                        secondName: data.second.name ?? ""));
                  }
                })
          ]),
      body: RefreshIndicator(
          onRefresh: () async {
            context.read<ComparingPokemonBloc>().add(GetFirstDetail(
                name: widget.argument.first.name ?? "",
                secondName: widget.argument.second.name ?? ""));
          },
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: BlocBuilder<ComparingPokemonBloc, ComparingPokemonState>(
              builder: (context, state) {
                if (state.status.isLoading) {
                  return Container(
                    width: double.infinity,
                    height: context.getHeight() * 0.9,
                    alignment: Alignment.center,
                    child: CustomLoading(
                      size: 20.r,
                    ),
                  );
                } else if (state.status.isNoConnection) {
                  return Container(
                    width: double.infinity,
                    height: context.getHeight() * 0.9,
                    alignment: Alignment.center,
                    child: const NoConnecttionState(),
                  );
                } else if (state.first != null && state.second != null) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Padding(
                      //   padding: const EdgeInsets.only(top: 20),
                      //   child: PokemonBarChart(
                      //     first: state.first!,
                      //     second: state.second!,
                      //   ),
                      // ),
                      SizedBox(
                        width: context.getWidth() * 0.9,
                        height: context.getHeight() * 0.5,
                        child: PageView.custom(
                          controller: _pageController,
                          onPageChanged: (index) {
                            context
                                .read<ComparingPokemonBloc>()
                                .add(OnChangePage(i: index));
                          },
                          childrenDelegate: SliverChildListDelegate([
                            Padding(
                              padding: const EdgeInsets.only(top: 16.0),
                              child: PokemonBarChart(
                                first: state.first!,
                                second: state.second!,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: PokemonRadarChart(
                                first: state.first!,
                                second: state.second!,
                              ),
                            ),
                          ], semanticIndexOffset: 100),
                        ),
                      ),
                      Container(
                        alignment: Alignment.center,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            state.page == 0
                                ? Container(
                                    width: 16.r,
                                    height: 16.r,
                                    decoration: BoxDecoration(
                                        color: purpleLight,
                                        borderRadius: BorderRadius.circular(8)),
                                  )
                                : GestureDetector(
                                    onTap: () {
                                      _pageController.jumpToPage(1);
                                    },
                                    child: Container(
                                      width: 12.r,
                                      height: 12.r,
                                      decoration: BoxDecoration(
                                          color: context
                                              .getColorScheme()
                                              .secondary,
                                          borderRadius:
                                              BorderRadius.circular(8.r)),
                                    ),
                                  ),
                            gapW10,
                            state.page == 1
                                ? Container(
                                    width: 16.r,
                                    height: 16.r,
                                    decoration: BoxDecoration(
                                        color: purpleLight,
                                        borderRadius: BorderRadius.circular(8)),
                                  )
                                : GestureDetector(
                                    onTap: () {
                                      _pageController.jumpToPage(0);
                                    },
                                    child: Container(
                                      width: 12.r,
                                      height: 12.r,
                                      decoration: BoxDecoration(
                                          color: context
                                              .getColorScheme()
                                              .secondary,
                                          borderRadius:
                                              BorderRadius.circular(8.r)),
                                    ),
                                  )
                          ],
                        ),
                      ),
                      HistoryComparing(
                          first: state.first!, second: state.second!),
                      Container(
                        width: double.infinity,
                        height: context.getHeight() * (isPortrait ? 0.25 : 0.6),
                        padding: const EdgeInsets.all(10),
                        child: Row(
                          children: [
                            Expanded(child: PokemonStats(detail: state.first!)),
                            gapW20,
                            Expanded(
                                child: PokemonStats(detail: state.second!)),
                          ],
                        ),
                      ),
                      gapH16,
                    ],
                  );
                } else {
                  return Container(
                    width: double.infinity,
                    height: context.getHeight() * 0.9,
                    alignment: Alignment.center,
                    child: const EmptyState(),
                  );
                }
              },
            ),
          )),
    );
  }
}
