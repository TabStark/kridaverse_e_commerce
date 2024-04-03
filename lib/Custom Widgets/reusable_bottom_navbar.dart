import 'package:flutter/material.dart';
import 'package:kridaverse_e_commerce/Theme/appColor.dart';
import 'package:kridaverse_e_commerce/screens/add_to_cart.dart';
import 'package:kridaverse_e_commerce/screens/home_screen.dart';
import 'package:kridaverse_e_commerce/screens/profile.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

class ReusableBottomNavbar extends StatefulWidget {
  const ReusableBottomNavbar({super.key});

  @override
  State<ReusableBottomNavbar> createState() => Reusable_BottomNavbarState();
}

class Reusable_BottomNavbarState extends State<ReusableBottomNavbar> {
  final _controller = PersistentTabController(initialIndex: 0);
  List<Widget> _buildScreen() {
    return [HomeScreen(), AddToCart(), ProfilePage(), ];
  }

  List<PersistentBottomNavBarItem> _navigationItem() {
    return [
      PersistentBottomNavBarItem(
        icon: Icon(Icons.home),
        title: "Home",
        activeColorPrimary: AppColor().black,
        inactiveColorPrimary: AppColor().darkGrey,
        
      ),
      PersistentBottomNavBarItem(
          icon: Icon(Icons.shopping_cart),
          title: "Add to Cart",
          activeColorPrimary: AppColor().black,
          inactiveColorPrimary: AppColor().darkGrey),
      PersistentBottomNavBarItem(
          icon: Icon(Icons.person),
          title: 'Profile',
          activeColorPrimary: AppColor().black,
          inactiveColorPrimary: AppColor().darkGrey),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      context,
      screens: _buildScreen(),
      items: _navigationItem(),
      controller: _controller,
      decoration: NavBarDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10), topRight: Radius.circular(10)),
          border: Border(
              top: BorderSide(color: AppColor().black),
              left: BorderSide(color: AppColor().black),
              right: BorderSide(color: AppColor().black))),
      navBarStyle: NavBarStyle.style3,
    );
  }
}
