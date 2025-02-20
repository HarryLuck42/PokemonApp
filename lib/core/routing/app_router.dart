import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:poke_app/core/routing/routes.dart';
import 'package:poke_app/core/routing/routing.dart';
import 'package:poke_app/layout/comparing_pokemon/argument/comparing_pokemon_argument.dart';
import 'package:poke_app/layout/comparing_pokemon/comparing_pokemon_screen.dart';
import 'package:poke_app/layout/home/home_screen.dart';
import 'package:poke_app/layout/pokemon_detail/pokemon_detail_screen.dart';
import 'package:poke_app/layout/settings/settings_screen.dart';
import 'package:poke_app/layout/splash/splash_screen.dart';

enum AppRoute {
  splash,
  home,
  pokemonDetail,
  pokemonCompared,
  settings,
}

GoRouter goRoute() {
  return GoRouter(
      initialLocation: Routes.splash,
      debugLogDiagnostics: !kReleaseMode,
      navigatorKey: Routing.navigatorKey,
      routes: [
        GoRoute(
          path: Routes.splash,
          name: AppRoute.splash.name,
          pageBuilder: (context, state) =>
              _transitionPage(state: state, child: const SplashScreen()),
        ),
        GoRoute(
            path: Routes.home,
            name: AppRoute.home.name,
            pageBuilder: (context, state) =>
                _transitionPage(state: state, child: const HomeScreen()),
            routes: [
              GoRoute(
                  path: Routes.pokemonDetail,
                  name: AppRoute.pokemonDetail.name,
                  pageBuilder: (context, state) {
                    final name = state.pathParameters['name'] ?? '';
                    return _transitionPage(
                      state: state,
                      child: PokemonDetailScreen(
                        name: name,
                      ),
                    );
                  }),
              GoRoute(
                  path: Routes.pokemonCompared,
                  name: AppRoute.pokemonCompared.name,
                  pageBuilder: (context, state) {
                    final argument = state.extra as ComparingPokemonArgument;
                    return _transitionPage(
                        state: state,
                        child: ComparingPokemonScreen(argument: argument));
                  }),
              GoRoute(
                path: Routes.settings,
                name: AppRoute.settings.name,
                pageBuilder: (context, state) => _transitionPage(
                    state: state, child: const SettingsScreen()),
              ),
            ]),
      ]);
}

CustomTransitionPage _transitionPage(
    {required GoRouterState state, required Widget child}) {
  return CustomTransitionPage<void>(
      maintainState: true,
      transitionDuration: const Duration(milliseconds: 320),
      key: state.pageKey,
      child: child,
      restorationId: 'app',
      transitionsBuilder: _fadeAndScaleTranisiton);
}

Widget _fadeAndScaleTranisiton(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child) {
  return FadeTransition(
    opacity: animation,
    child: ScaleTransition(
      scale: Tween<double>(begin: 0.9, end: 1.0).animate(
        CurvedAnimation(
          parent: animation,
          curve: Curves.easeOut,
        ),
      ),
      child: child,
    ),
  );
}
