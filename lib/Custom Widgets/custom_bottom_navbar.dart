// import 'package:flutter/material.dart';
// import 'package:kridaverse_e_commerce/screens/add_to_cart.dart';
// import 'package:kridaverse_e_commerce/screens/profile.dart';

// class CustomNavbar extends StatefulWidget {
//   const CustomNavbar({Key? key}) : super(key: key);

//   @override
//   _CustomNavbarState createState() => _CustomNavbarState();
// }

// class _CustomNavbarState extends State<CustomNavbar> {
//   int pageIndex = 0;

//   final pages = [
//     const CustomNavbar(),
//     const AddToCart(),
//     const ProfilePage()
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xffC4DFCB),
//       appBar: AppBar(
//         leading: Icon(
//           Icons.menu,
//           color: Theme.of(context).primaryColor,
//         ),
//         title: Text(
//           "Geeks For Geeks",
//           style: TextStyle(
//             color: Theme.of(context).primaryColor,
//             fontSize: 25,
//             fontWeight: FontWeight.w600,
//           ),
//         ),
//         centerTitle: true,
//         backgroundColor: Colors.white,
//       ),
//       body: pages[pageIndex],
//       bottomNavigationBar: Container(
//         height: 60,
//         decoration: BoxDecoration(
//           color: Theme.of(context).primaryColor,
//           borderRadius: const BorderRadius.only(
//             topLeft: Radius.circular(20),
//             topRight: Radius.circular(20),
//           ),
//         ),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceAround,
//           children: [
//             IconButton(
//               enableFeedback: false,
//               onPressed: () {
//                 setState(() {
//                   pageIndex = 0;
//                 });
//               },
//               icon: pageIndex == 0
//                   ? const Icon(
//                       Icons.home_filled,
//                       color: Colors.white,
//                       size: 35,
//                     )
//                   : const Icon(
//                       Icons.home_outlined,
//                       color: Colors.white,
//                       size: 35,
//                     ),
//             ),
//             IconButton(
//               enableFeedback: false,
//               onPressed: () {
//                 setState(() {
//                   pageIndex = 1;
//                 });
//               },
//               icon: pageIndex == 1
//                   ? const Icon(
//                       Icons.work_rounded,
//                       color: Colors.white,
//                       size: 35,
//                     )
//                   : const Icon(
//                       Icons.work_outline_outlined,
//                       color: Colors.white,
//                       size: 35,
//                     ),
//             ),
//             IconButton(
//               enableFeedback: false,
//               onPressed: () {
//                 setState(() {
//                   pageIndex = 2;
//                 });
//               },
//               icon: pageIndex == 2
//                   ? const Icon(
//                       Icons.widgets_rounded,
//                       color: Colors.white,
//                       size: 35,
//                     )
//                   : const Icon(
//                       Icons.widgets_outlined,
//                       color: Colors.white,
//                       size: 35,
//                     ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
