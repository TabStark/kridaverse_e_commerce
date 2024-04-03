import 'dart:async';

import 'package:flutter/material.dart';
import 'package:kridaverse_e_commerce/APIS/apis.dart';
import 'package:kridaverse_e_commerce/Custom%20Widgets/custom_bottom_navbar.dart';
import 'package:kridaverse_e_commerce/Custom%20Widgets/reusable_bottom_navbar.dart';
import 'package:kridaverse_e_commerce/Theme/appColor.dart';
import 'package:kridaverse_e_commerce/main.dart';
import 'package:kridaverse_e_commerce/screens/home_screen.dart';
import 'package:kridaverse_e_commerce/screens/login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Timer(const Duration(seconds: 5), () {
      if (Apis.auth.currentUser != null) {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const ReusableBottomNavbar()));
      } else {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const LoginScreen()));
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    mq = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        height: mq.height * 1,
        width: mq.width * 1,
        color: AppColor().black,
        child: Center(
          child: Text(
            'KRIDAVERSE',
            style: TextStyle(
              fontFamily: 'NinjaTurtles',
              color: AppColor().white,
              fontSize: 30,
            ),
          ),
        ),
      ),
    );
  }
}
