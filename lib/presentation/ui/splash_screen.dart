import 'dart:async';

import 'package:flutter/material.dart';
import 'package:washq/presentation/ui/home/home_screen.dart';
import 'package:washq/presentation/ui/login/login_screen.dart';
import 'package:washq/presentation/ui/sign_up/sign_up.dart';

import '../../common_widget/app_helper.dart';
import '../../common_widget/constants.dart';

class SplashScreen extends StatefulWidget {
  static const routeName = '/splashScreen';

  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool isUserLogin = false;
  String isUserToken = '';



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        margin: const EdgeInsets.only(top: 5,left: 10),
          height: MediaQuery.of(context).size.height ,
          width: MediaQuery.of(context).size.width,
          child: Image.asset(Constants.mainLogoImage)),
    );
  }

  Future<void> goForward() async {
    isUserLogin = await AppHelper.getUserLoginStatus();
    isUserToken =  await AppHelper.getToken();
    if(isUserToken == "" || isUserToken == null && isUserLogin != true){
      navigateToLogin();
    }else{
       navigateToHome();
    }
  }

  void navigateToLogin() async {
    await Future.delayed(const Duration(seconds: 1));

    if (!context.mounted) return;
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => const LoginScreen()));
  }


  void navigateToHome()async {
    await Future.delayed(const Duration(seconds: 1));

    if (!context.mounted) return;
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => const HomeScreen()));
  }
  @override
  void initState() {
    super.initState();
    Timer(
      const Duration(seconds: 3),
      () {
        // AppHelper.getUserLoginStatus().then((value) => isUserLogin = value);
         goForward();
      },
    );
  }
}
