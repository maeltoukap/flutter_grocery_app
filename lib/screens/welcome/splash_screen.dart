import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/route_manager.dart';
import 'package:grocery_app/generated/assets.dart';
import 'package:grocery_app/repositories/user_repository.dart';
import 'package:grocery_app/ressources/app_colors.dart';
import 'package:grocery_app/ressources/constants.dart';
import 'package:grocery_app/screens/home_screen/home_screen.dart';
import 'package:grocery_app/screens/login_screen/login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  UserRepository _userRepository = UserRepository();
  bool _isLogin = false;
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 2), () async {
      SharedPreferences pref = await SharedPreferences.getInstance();
      _isLogin = pref.getBool("isLogin") ?? false;
      print(_isLogin);
      Navigator.of(context).pushReplacement(Constants.createRoute(
          route: _isLogin ? const HomeScreen() : LoginScreen()));
      if (_isLogin) {
        _userRepository.getUserInfosFromCache();
        print(localUser.token);
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(color: AppColors.primary),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SvgPicture.asset(Assets.splashScreen),
                const SizedBox(height: 38.0),
                const Text(
                  "Fresh Fruits", //TODO: change this style
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: AppColors.white,
                      fontSize: 38.0,
                      fontWeight: FontWeight.w700),
                ),
                SizedBox(height: Constants.screenHeight(context) * 0.2),
              ],
            ),
          )
        ],
      ),
    );
  }
}
