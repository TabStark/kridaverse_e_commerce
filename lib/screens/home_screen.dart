import 'package:flutter/material.dart';
import 'package:kridaverse_e_commerce/APIS/apis.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  late final AnimationController animationcontroller =
      AnimationController(duration: Duration(seconds: 3), vsync: this)
        ..repeat();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
            onPressed: () =>
                Apis().logoutFromDevice(context, animationcontroller),
            child: Text('Logout')),
      ),
    );
  }
}
