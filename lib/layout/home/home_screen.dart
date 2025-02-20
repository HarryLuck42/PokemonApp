import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:poke_app/core/extention/extention.dart';
import 'package:poke_app/core/routing/app_router.dart';
import 'package:poke_app/initial/locale/localizations.dart';
import 'package:poke_app/layout/choose_pokemon/choose_pokemon_screen.dart';

import '../../core/constraint/asset_path.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/custom_icon_button.dart';
import '../pokemon/pokemon_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  static const _page = [PokemonScreen(), ChoosePokemonScreen()];

  var selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(context,
            "${lang(context).appTitle ?? "PokeApp"} - Hariyanto Lukman",
            isBack: false,
            actions: [
              kIsWeb
                  ? IconButton(
                      onPressed: () {
                        context.goNamed(AppRoute.settings.name);
                      },
                      icon: Icon(
                        Icons.settings,
                        color: context.getColorScheme().primary,
                      ))
                  : CustomIconButton(
                      iconData: "${AssetPath.vector}settings.svg",
                      height: 20.h,
                      width: 20.h,
                      defaultColor: false,
                      color: context.getColorScheme().primary,
                      onPressed: () async {
                        context.goNamed(AppRoute.settings.name);
                      }),
            ]),
        bottomNavigationBar: BottomNavigationBar(
          items: [
            BottomNavigationBarItem(
                icon: const Icon(Icons.home),
                label: lang(context).home ?? "Home"),
            BottomNavigationBarItem(
                icon: const Icon(Icons.switch_left),
                label: lang(context).comparing ?? "Comparing")
          ],
          onTap: _onItemTapped,
          currentIndex: selectedIndex,
        ),
        body: _page.elementAt(selectedIndex));
  }
}
