import 'dart:async';
import 'package:flutter/material.dart';
import 'package:kridaverse_e_commerce/Custom%20Widgets/reusable_bottom_navbar.dart';
import 'package:kridaverse_e_commerce/Theme/appColor.dart';
import 'package:kridaverse_e_commerce/screens/home_screen.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';

class ConfirmedScreen extends StatefulWidget {
  final String msg;
  const ConfirmedScreen({super.key, required this.msg});

  @override
  State<ConfirmedScreen> createState() => _ConfirmedScreenState();
}

class _ConfirmedScreenState extends State<ConfirmedScreen> {
  bool value = true;
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 3), () {
      setState(() {
        value = !value;
      });
    }).then((value) {
      Timer(Duration(seconds: 2), () {
        pushWithNavBar(
            context,
            MaterialPageRoute(
                builder: (context) => const ReusableBottomNavbar()));
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        color: AppColor().white,
        child: Center(
          child: value
              ? CircularProgressIndicator(color: AppColor().green)
              : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AnimatedContainer(
                      // color: AppColor().green,
                      height: value ? 0 : 100,
                      width: value ? 0 : 100,
                      duration: Duration(milliseconds: 2000),
                      curve: Curves.fastOutSlowIn,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image:
                                  AssetImage('assets/images/confirmed.png'))),
                    ),
                    Text(
                      widget.msg,
                      style: TextStyle(fontSize: 23),
                    )
                  ],
                ),

          // CircularProgressIndicator(color: AppColor().black
        ),
      ),
    );
  }
}
