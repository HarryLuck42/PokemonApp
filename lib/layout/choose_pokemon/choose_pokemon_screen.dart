import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poke_app/core/base/base_state.dart';
import 'package:poke_app/core/extention/extention.dart';
import 'package:poke_app/layout/choose_pokemon/adapter/choose_pokemon_adapter.dart';
import 'package:poke_app/layout/choose_pokemon/bloc/choose_pokemon_bloc.dart';
import 'package:poke_app/layout/choose_pokemon/component/bottom_comparing_pokemon.dart';

import '../../core/routing/routing.dart';
import '../../widgets/pagination_scroll_controller.dart';
import '../state_widgets/empty_state.dart';
import '../state_widgets/loading_list.dart';
import '../state_widgets/no_connection_state.dart';

class ChoosePokemonScreen extends StatefulWidget {
  const ChoosePokemonScreen({super.key});

  @override
  State<ChoosePokemonScreen> createState() => _ChoosePokemonScreenState();
}

class _ChoosePokemonScreenState extends State<ChoosePokemonScreen>
    with BaseState {
  PaginationScrollController paginationScrollController =
      PaginationScrollController();

  @override
  void initState() {
    paginationScrollController.init(
        loadAction: () => Routing.navigatorKey.currentContext
            ?.read<ChoosePokemonBloc>()
            .add(const GetPokemon(isReload: false)));
    super.initState();
  }

  @override
  void afterFirstLayout(BuildContext context) {
    context.read<ChoosePokemonBloc>().add(const GetPokemon(isReload: true));
  }

  @override
  Widget build(BuildContext context) {
    final isPortrait = context.isPortrait();
    return BlocBuilder<ChoosePokemonBloc, ChoosePokemonState>(
        builder: (context, state) {
      return state.status.isNoConnection
          ? const NoConnecttionState()
          : state.status.isLoading
              ? const LoadingList()
              : isPortrait
                  ? Column(
                      children: [
                        Expanded(
                          child: RefreshIndicator(
                            onRefresh: () async {
                              context
                                  .read<ChoosePokemonBloc>()
                                  .add(const GetPokemon(isReload: true));
                            },
                            child: OrientationBuilder(
                                builder: (context, orientation) {
                              if (orientation == Orientation.portrait) {
                                return CustomScrollView(
                                  physics:
                                      const AlwaysScrollableScrollPhysics(),
                                  controller: paginationScrollController
                                      .scrollController,
                                  slivers: [
                                    state.status.isEmpty
                                        ? const SliverToBoxAdapter(
                                            child: EmptyState(),
                                          )
                                        : SliverGrid(
                                            gridDelegate:
                                                const SliverGridDelegateWithFixedCrossAxisCount(
                                                    crossAxisCount: 3,
                                                    childAspectRatio: 2 / 3),
                                            delegate:
                                                SliverChildBuilderDelegate(
                                              (BuildContext context,
                                                  int index) {
                                                return ChoosePokemonAdapter(
                                                  pokemon:
                                                      state.pokemonList![index],
                                                  isSelected:
                                                      state.pokemonList![
                                                                  index] ==
                                                              state.first ||
                                                          state.pokemonList![
                                                                  index] ==
                                                              state.second,
                                                );
                                              },
                                              childCount:
                                                  state.pokemonList?.length,
                                            ),
                                          ),
                                  ],
                                );
                              } else {
                                return GridView.builder(
                                    controller: paginationScrollController
                                        .scrollController,
                                    gridDelegate:
                                        const SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisCount: 6,
                                            crossAxisSpacing: 0.0,
                                            mainAxisSpacing: 0.0,
                                            childAspectRatio: 2 / 3),
                                    itemCount: state.pokemonList?.length,
                                    itemBuilder: (context, index) {
                                      return ChoosePokemonAdapter(
                                        pokemon: state.pokemonList![index],
                                        isSelected: state.pokemonList![index] ==
                                                state.first ||
                                            state.pokemonList![index] ==
                                                state.second,
                                      );
                                    });
                              }
                            }),
                          ),
                        ),
                        if (state.first != null)
                          BottomComparingPokemon(
                            first: state.first,
                            second: state.second,
                          )
                      ],
                    )
                  : Row(
                      children: [
                        Expanded(
                          child: RefreshIndicator(
                            onRefresh: () async {
                              context
                                  .read<ChoosePokemonBloc>()
                                  .add(const GetPokemon(isReload: true));
                            },
                            child: OrientationBuilder(
                                builder: (context, orientation) {
                              if (orientation == Orientation.portrait) {
                                return CustomScrollView(
                                  physics:
                                      const AlwaysScrollableScrollPhysics(),
                                  controller: paginationScrollController
                                      .scrollController,
                                  slivers: [
                                    state.status.isEmpty
                                        ? const SliverToBoxAdapter(
                                            child: EmptyState(),
                                          )
                                        : SliverGrid(
                                            gridDelegate:
                                                const SliverGridDelegateWithFixedCrossAxisCount(
                                                    crossAxisCount: 3,
                                                    childAspectRatio: 2 / 3),
                                            delegate:
                                                SliverChildBuilderDelegate(
                                              (BuildContext context,
                                                  int index) {
                                                return ChoosePokemonAdapter(
                                                  pokemon:
                                                      state.pokemonList![index],
                                                  isSelected:
                                                      state.pokemonList![
                                                                  index] ==
                                                              state.first ||
                                                          state.pokemonList![
                                                                  index] ==
                                                              state.second,
                                                );
                                              },
                                              childCount:
                                                  state.pokemonList?.length,
                                            ),
                                          ),
                                  ],
                                );
                              } else {
                                return GridView.builder(
                                    controller: paginationScrollController
                                        .scrollController,
                                    gridDelegate:
                                        const SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisCount: 6,
                                            crossAxisSpacing: 0.0,
                                            mainAxisSpacing: 0.0,
                                            childAspectRatio: 2 / 3),
                                    itemCount: state.pokemonList?.length,
                                    itemBuilder: (context, index) {
                                      return ChoosePokemonAdapter(
                                        pokemon: state.pokemonList![index],
                                        isSelected: state.pokemonList![index] ==
                                                state.first ||
                                            state.pokemonList![index] ==
                                                state.second,
                                      );
                                    });
                              }
                            }),
                          ),
                        ),
                        if (state.first != null)
                          BottomComparingPokemon(
                            first: state.first,
                            second: state.second,
                          )
                      ],
                    );
    });
  }

  @override
  void dispose() {
    paginationScrollController.dispose();
    super.dispose();
  }
}
