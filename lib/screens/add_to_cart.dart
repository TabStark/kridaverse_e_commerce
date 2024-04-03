import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:kridaverse_e_commerce/APIS/apis.dart';
import 'package:kridaverse_e_commerce/Custom%20Widgets/popup_and_loader.dart';
import 'package:kridaverse_e_commerce/Theme/appColor.dart';
import 'package:kridaverse_e_commerce/main.dart';
import 'package:kridaverse_e_commerce/screens/view_products.dart';

class AddToCart extends StatefulWidget {
  const AddToCart({
    super.key,
  });

  @override
  State<AddToCart> createState() => _AddToCartState();
}

class _AddToCartState extends State<AddToCart> with TickerProviderStateMixin {
  // Loading Animation
  late final AnimationController _Animationcontroller =
      AnimationController(duration: Duration(seconds: 3), vsync: this)
        ..repeat();
  // for search
  bool search = false;

  @override
  void dispose() {
    super.dispose();
    _Animationcontroller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: AppColor().darkGrey,
        title: Text(
          'Add to Cart',
          style: TextStyle(color: AppColor().white),
        ),
      ),
      body: SafeArea(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          color: AppColor().white,
          child: StreamBuilder(
              stream: Apis.fetchAddtoCartstream(
                      'users', Apis.user.uid, 'myaddtocart')
                  .snapshots(),
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
                    child: ListView.builder(
                        itemCount: snapShot.data!.docs.length,
                        itemBuilder: (context, index) {
                          print(
                            snapShot.data!.docs.length,
                          );

                          final DocumentSnapshot documentSnapshot =
                              snapShot.data!.docs[index];
                          final String docid =
                              snapShot.data!.docs[index].reference.id;
                          final String addtocartdoc = docid;
                          return InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ViewProductDetail(
                                            documentSnapshot: documentSnapshot,
                                            docId: addtocartdoc,
                                          )));
                            },
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 20),
                              child: Column(
                                children: [
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                          width: mq.width * 0.3,
                                          child: Image.network(
                                              documentSnapshot['img'])),
                                      SizedBox(
                                        width: mq.width * 0.01,
                                      ),
                                      SizedBox(
                                        width: mq.width * .6,
                                        height: mq.height * 0.16,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              'iPhone',
                                              style: TextStyle(
                                                  color: AppColor().darkGrey,
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
                                            Text(documentSnapshot['price'],
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    color: AppColor().black))
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    width: mq.width * 3,
                                    child: Row(
                                      children: [
                                        SizedBox(
                                            width: mq.width * .1,
                                            height: mq.height * .03,
                                            child: (documentSnapshot['qty'] > 1)
                                                ? ElevatedButton(
                                                    style: ElevatedButton.styleFrom(
                                                        padding:
                                                            EdgeInsets.all(0),
                                                        shape: RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        3))),
                                                    onPressed: () async {
                                                      // Decreasing cart qty by using minus icon
                                                      // DialogsWidget.showProgressBar(
                                                      //     context,
                                                      //     _Animationcontroller);
                                                      await Apis.removetocart(
                                                              addtocartdoc)
                                                          .then((value) {
                                                        // Navigator.pop(context);
                                                        setState(() {
                                                          documentSnapshot[
                                                              'qty'];
                                                        });
                                                      });
                                                    },
                                                    child: const Icon(
                                                      Icons.remove,
                                                      size: 17,
                                                    ))
                                                : ElevatedButton(
                                                    style: ElevatedButton.styleFrom(
                                                        padding:
                                                            EdgeInsets.all(0),
                                                        shape: RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        3))),
                                                    onPressed: () async {
                                                      // Delete from Cart
                                                      // DialogsWidget.showProgressBar(
                                                      //     context,
                                                      //     _Animationcontroller);
                                                      await Apis.deletefromcart(
                                                              addtocartdoc)
                                                          .then((value) {
                                                        // Navigator.pop(context);
                                                        setState(() {
                                                          documentSnapshot[
                                                              'qty'];
                                                        });
                                                      });
                                                    },
                                                    child: const Icon(
                                                      Icons.delete,
                                                      size: 17,
                                                    ))),
                                        SizedBox(
                                            width: mq.width * .1,
                                            height: mq.height * .035,
                                            child: Center(
                                                child: Text(
                                              documentSnapshot['qty']
                                                  .toString(),
                                            ))),
                                        SizedBox(
                                            width: mq.width * .1,
                                            height: mq.height * .03,
                                            child: ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                    padding: EdgeInsets.all(0),
                                                    shape:
                                                        RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        3))),
                                                onPressed: () async {
                                                  // Icreasing cart qty by using plus icon
                                                  // DialogsWidget.showProgressBar(
                                                  //     context,
                                                  //     _Animationcontroller);
                                                  await Apis.addtocart(
                                                          addtocartdoc,
                                                          documentSnapshot)
                                                      .then((value) {
                                                    // Navigator.pop(context);
                                                    setState(() {
                                                      documentSnapshot['qty'];
                                                    });
                                                  });
                                                },
                                                child: const Icon(
                                                  Icons.add,
                                                  size: 17,
                                                ))),
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
      ),
    );
  }
}
