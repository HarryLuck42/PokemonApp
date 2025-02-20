import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:poke_app/core/base/base_state.dart';
import 'package:poke_app/core/constraint/asset_path.dart';
import 'package:poke_app/core/extention/extention.dart';
import 'package:poke_app/core/routing/app_router.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with BaseState {
  @override
  Widget build(BuildContext context) {
    final isPortrait = context.isPortrait();
    return Scaffold(
      body: isPortrait
          ? Stack(
              children: [
                if (isPortrait)
                  Positioned(
                    left: 0,
                    right: 0,
                    top: 0,
                    child: Image.asset(
                      '${AssetPath.image}cloud.webp',
                      fit: BoxFit.contain,
                    ),
                  ),
                Positioned(
                  left: 0,
                  right: 0,
                  top: !kIsWeb ? 200.r : 50.r,
                  child: Container(
                      alignment: Alignment.center,
                      child: Image.asset(
                        '${AssetPath.image}pokeball.webp',
                        width: !kIsWeb ? 200.h : 120.h,
                        height: !kIsWeb ? 200.h : 120.h,
                      )),
                ),
                Positioned(
                  left: 0,
                  right: 0,
                  top: !kIsWeb ? 150.r : 0.r,
                  child: Container(
                      margin: const EdgeInsets.only(top: 100),
                      alignment: Alignment.center,
                      child: Image.asset(
                        '${AssetPath.image}text_pokemon.png',
                        width: !kIsWeb ? 200.h : 120.h,
                        height: !kIsWeb ? 200.h : 120.h,
                      )),
                ),
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: Image.asset(
                    '${AssetPath.image}green_hill.png',
                    fit: BoxFit.contain,
                  ),
                ),
                Positioned(
                  right: 0,
                  top: 0,
                  child: Image.asset(
                    width: 200.h,
                    height: 400.h,
                    '${AssetPath.image}charizard.webp',
                    fit: BoxFit.contain,
                  ),
                ),
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: 30.r,
                  child: Image.asset(
                    width: 50.h,
                    height: 400.h,
                    '${AssetPath.image}ash.webp',
                    fit: BoxFit.contain,
                  ),
                ),
                Positioned(
                  right: -20.r,
                  bottom: -90.r,
                  child: Image.asset(
                    width: 200.h,
                    height: 400.h,
                    '${AssetPath.image}pikachu.webp',
                    fit: BoxFit.contain,
                  ),
                ),
                Positioned(
                  right: -60.r,
                  bottom: 120.r,
                  child: Image.asset(
                    width: 220.h,
                    height: 400.h,
                    '${AssetPath.image}mewt.webp',
                    fit: BoxFit.contain,
                  ),
                ),
                Positioned(
                  left: -10.r,
                  bottom: -90.r,
                  child: Image.asset(
                    width: 200.h,
                    height: 400.h,
                    '${AssetPath.image}bulbasaur.webp',
                    fit: BoxFit.contain,
                  ),
                ),
              ],
            )
          : kIsWeb
              ? Stack(
                  children: [
                    Positioned(
                      left: 0,
                      right: 0,
                      bottom: 0,
                      child: Image.asset(
                        '${AssetPath.image}green_hill.png',
                        fit: BoxFit.contain,
                      ),
                    ),
                    Positioned(
                      right: -20.r,
                      bottom: -90.r,
                      child: Image.asset(
                        width: 400.h,
                        height: 600.h,
                        '${AssetPath.image}pikachu.webp',
                        fit: BoxFit.contain,
                      ),
                    ),
                    Positioned(
                      left: 10.r,
                      bottom: 0.r,
                      child: Image.asset(
                        width: 350.h,
                        height: 400.h,
                        '${AssetPath.image}bulbasaur.webp',
                        fit: BoxFit.contain,
                      ),
                    ),
                    Positioned(
                      left: 0,
                      right: 0,
                      top: 150.r,
                      child: Container(
                          alignment: Alignment.center,
                          child: Image.asset(
                            '${AssetPath.image}pokeball.webp',
                            width: 300.h,
                            height: 300.h,
                          )),
                    ),
                    Positioned(
                      left: 0,
                      right: 0,
                      top: 150.r,
                      child: Container(
                          margin: const EdgeInsets.only(top: 100),
                          alignment: Alignment.center,
                          child: Image.asset(
                            '${AssetPath.image}text_pokemon.png',
                            width: 300.h,
                            height: 300.h,
                          )),
                    ),
                  ],
                )
              : Stack(
                  children: [
                    Positioned(
                      left: 0,
                      right: 0,
                      bottom: -50,
                      child: Image.asset(
                        '${AssetPath.image}green_hill.png',
                        fit: BoxFit.contain,
                      ),
                    ),
                    Positioned(
                      right: -20.r,
                      bottom: -70.r,
                      child: Image.asset(
                        width: 220.h,
                        height: 320.h,
                        '${AssetPath.image}pikachu.webp',
                        fit: BoxFit.contain,
                      ),
                    ),
                    Positioned(
                      left: 10.r,
                      bottom: 0.r,
                      child: Image.asset(
                        width: 175.h,
                        height: 200.h,
                        '${AssetPath.image}bulbasaur.webp',
                        fit: BoxFit.contain,
                      ),
                    ),
                    Positioned(
                      left: 0,
                      right: 0,
                      top: 80.h,
                      child: Container(
                          alignment: Alignment.center,
                          child: Image.asset(
                            '${AssetPath.image}pokeball.webp',
                            width: 150.w,
                            height: 150.w,
                          )),
                    ),
                    Positioned(
                      left: 0,
                      right: 0,
                      top: 50.h,
                      child: Container(
                          margin: const EdgeInsets.only(top: 100),
                          alignment: Alignment.center,
                          child: Image.asset(
                            '${AssetPath.image}text_pokemon.png',
                            width: 150.w,
                            height: 150.w,
                          )),
                    ),
                  ],
                ),
    );
  }

  @override
  void afterFirstLayout(BuildContext context) {
    Future.delayed(const Duration(seconds: 3), () {
      context.pushReplacementNamed(AppRoute.home.name);
    });
  }
}
