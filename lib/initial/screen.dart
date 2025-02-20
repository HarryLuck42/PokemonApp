import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:poke_app/app.dart';
import 'package:poke_app/core/extention/extention.dart';
import 'package:poke_app/core/lifecycle/lifecycle_manager.dart';
import 'package:poke_app/initial/bloc/app_bloc.dart';
import 'package:poke_app/initial/locale/localizations.dart';
import 'package:poke_app/initial/multiproviders.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import '../core/routing/routing.dart';

class MyAppLayout extends StatefulWidget {
  const MyAppLayout({super.key});

  @override
  State<MyAppLayout> createState() => _MyAppLayoutState();
}

class _MyAppLayoutState extends State<MyAppLayout> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return LifecycleManager(
      child: ScreenUtilInit(
        designSize: Size(context.getWidth(), context.getHeight()),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (BuildContext context, Widget? child) {
          return MultiBlocProvider(
            providers: Multiproviders.inject(),
            child: BlocBuilder<AppBloc, AppInitial>(
              builder: (context, state) {
                return MaterialApp.router(
                  key: materialAppKey,
                  title: "PokeApp",
                  theme: state.themeData,
                  routeInformationProvider:
                      state.router?.routeInformationProvider,
                  routeInformationParser: state.router?.routeInformationParser,
                  routerDelegate: state.router?.routerDelegate,
                  supportedLocales: const [Locale("en"), Locale("id")],
                  locale: Locale(state.lang ?? "en"),
                  localizationsDelegates: const [
                    AppLocale.delegate,
                    GlobalMaterialLocalizations.delegate,
                    GlobalCupertinoLocalizations.delegate,
                    GlobalWidgetsLocalizations.delegate
                  ],
                  debugShowCheckedModeBanner: false,
                  scaffoldMessengerKey: Routing.scaffoldMessengerKey,
                  builder: (context, child) => MediaQuery(
                      data: MediaQuery.of(context)
                          .copyWith(textScaler: const TextScaler.linear(1.0)),
                      child: child ??
                          Container(
                            color: Colors.white,
                          )),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
