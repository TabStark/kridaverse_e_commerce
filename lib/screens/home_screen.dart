import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:kridaverse_e_commerce/APIS/apis.dart';
import 'package:kridaverse_e_commerce/Theme/appColor.dart';
import 'package:kridaverse_e_commerce/main.dart';
import 'package:kridaverse_e_commerce/screens/add_to_cart.dart';
import 'package:kridaverse_e_commerce/screens/profile.dart';
import 'package:kridaverse_e_commerce/screens/view_products.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';
import 'package:shimmer/shimmer.dart';

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
      appBar: AppBar(
        title: Text(
          'KRIDAVERSE',
          style: TextStyle(color: AppColor().white),
        ),
        backgroundColor: AppColor().darkGrey,
        actions: [
          Icon(
            Icons.search,
            color: AppColor().white,
            size: 30,
          )
        ],
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: AppColor().white,
        child: StreamBuilder(
            stream: Apis.fetchstream('products').snapshots(),
            builder: (context, AsyncSnapshot<QuerySnapshot> snapShot) {
              if (!snapShot.hasData) {
                return Center(
                  child: CircularProgressIndicator(
                    color: AppColor().black,
                  ),
                );
              } else {
                return Padding(
                  padding: EdgeInsets.all(10),
                  child: GridView.builder(
                      itemCount: snapShot.data!.docs.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2, childAspectRatio: .6),
                      itemBuilder: (context, index) {
                        // final data = snapShot.data!.docs;
                        // To take a json
                        // print("Data : ${jsonEncode(data[0].data())}");
                        final DocumentSnapshot documentSnapshot =
                            snapShot.data!.docs[index];

                        return InkWell(
                          onTap: () {
                            final String docid =
                                snapShot.data!.docs[index].reference.id;
                            pushWithoutNavBar(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ViewProductDetail(
                                        documentSnapshot: documentSnapshot,
                                        docId: docid)));
                          },
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                    height: mq.height * 0.22,
                                    child:
                                        Image.network(documentSnapshot['img'])),
                                Padding(
                                  padding: EdgeInsets.only(top: 10),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'iPhone',
                                        style: TextStyle(
                                            color: AppColor().black,
                                            fontSize: 16),
                                      ),
                                      Text(
                                        documentSnapshot['name'],
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            fontSize: 16,
                                            color: AppColor().black),
                                      ),
                                      Text('₹ ${documentSnapshot["price"]}',
                                          style: TextStyle(
                                              fontSize: 16,
                                              color: AppColor().black))
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
                      }),
                );
              }
            }),
      ),
    );
  }
}
