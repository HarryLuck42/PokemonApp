part of 'app_bloc.dart';

class AppState extends Equatable {
  @override
  List<Object?> get props => [];
}

class AppInitial extends AppState {
  final ThemeData? themeData;

  final String? lang;

  final GoRouter? router;

  @override
  List<Object?> get props => [themeData, lang, router];

  AppInitial({ThemeData? themeData, String? lang, GoRouter? router})
      : themeData =
            (SharedPreference().readStorage(SpKeys.isLightTheme) ?? true)
                ? appLightTheme()
                : appDarkTheme(),
        lang = (SharedPreference().readStorage(SpKeys.locale) ?? "en"),
        router = goRoute();

  AppInitial copyWith({ThemeData? themeData, String? lang, GoRouter? router}) {
    return AppInitial(
        themeData: themeData ?? this.themeData,
        lang: lang ?? this.lang,
        router: router ?? this.router);
  }
}
