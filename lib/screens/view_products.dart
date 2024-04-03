import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:kridaverse_e_commerce/APIS/apis.dart';
import 'package:kridaverse_e_commerce/Custom%20Widgets/popup_and_loader.dart';
import 'package:kridaverse_e_commerce/Theme/appColor.dart';
import 'package:kridaverse_e_commerce/main.dart';
import 'package:kridaverse_e_commerce/screens/order_now.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';

class ViewProductDetail extends StatefulWidget {
  final String docId;
  final DocumentSnapshot documentSnapshot;
  const ViewProductDetail(
      {super.key, required this.documentSnapshot, required this.docId});

  @override
  State<ViewProductDetail> createState() => _ViewProductDetailState();
}

class _ViewProductDetailState extends State<ViewProductDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Icon(
              Icons.arrow_back,
              color: AppColor().white,
            )),
        backgroundColor: AppColor().darkGrey,
        title: Text(
          'iPhone',
          style: TextStyle(color: AppColor().white),
        ),
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        color: AppColor().white,
        child: Stack(
          children: [
            SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: double.infinity,
                    child: Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: mq.width * .07),
                        width: double.infinity,
                        height: mq.height * .55,
                        color: AppColor().white,
                        child: Image.network(widget.documentSnapshot['img'])),
                  ),
                  Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: mq.width * .03, vertical: mq.width * .05),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'iPhone',
                            style: TextStyle(
                                color: AppColor().darkGrey, fontSize: 17),
                          ),
                          const SizedBox(
                            height: 6,
                          ),
                          Text(
                            widget.documentSnapshot['name'],
                            style: TextStyle(
                                fontSize: 20, color: AppColor().black),
                          ),
                          const SizedBox(
                            height: 6,
                          ),
                          Text(
                            "₹ ${widget.documentSnapshot['price']}.00",
                            style: TextStyle(
                                fontSize: 21,
                                fontWeight: FontWeight.w500,
                                color: AppColor().black),
                          ),
                          const SizedBox(
                            height: 6,
                          ),
                          Text(
                            "*${widget.documentSnapshot['discription'][0]}",
                            textAlign: TextAlign.justify,
                            style: TextStyle(
                                fontSize: 17, color: AppColor().black),
                          ),
                          Text(
                            "*${widget.documentSnapshot['discription'][1]}",
                            textAlign: TextAlign.justify,
                            style: TextStyle(
                                fontSize: 17, color: AppColor().black),
                          ),
                          Text(
                            "*${widget.documentSnapshot['discription'][2]}",
                            textAlign: TextAlign.justify,
                            style: TextStyle(
                                fontSize: 17, color: AppColor().black),
                          ),
                          Text(
                            "*${widget.documentSnapshot['discription'][3]}",
                            textAlign: TextAlign.justify,
                            style: TextStyle(
                                fontSize: 17, color: AppColor().black),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          const SizedBox(
                            height: 50,
                          ),
                        ],
                      ))
                ],
              ),
            ),
            Positioned(
                bottom: 0.0,
                child: Container(
                  height: mq.height * .088,
                  width: mq.width * 1,
                  color: AppColor().white,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      SizedBox(
                        height: mq.height * .06,
                        width: mq.width * 0.38,
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                shadowColor: AppColor().white,
                                elevation: 8,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5),
                                    side: BorderSide(color: AppColor().black)),
                                backgroundColor: AppColor().white),
                            onPressed: () async {
                              print(widget.docId);
                              await Apis.addtocart(
                                      widget.docId, widget.documentSnapshot)
                                  .then((value) {
                                DialogsWidget.showFlushBarBottom(
                                    context, 'Successfully Added to Cart');
                              });
                            },
                            child: Text(
                              'Add to Cart',
                              style: TextStyle(
                                  color: AppColor().black, fontSize: 18),
                            )),
                      ),
                      SizedBox(
                        height: mq.height * .06,
                        width: mq.width * 0.4,
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                shadowColor: AppColor().white,
                                elevation: 10,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5)),
                                backgroundColor: AppColor().darkGrey),
                            onPressed: () {
                              pushWithoutNavBar(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => OrderNow(
                                          docId: widget.docId,
                                          documentSnapshot:
                                              widget.documentSnapshot)));
                            },
                            child: Text('Buy Now',
                                style: TextStyle(
                                    color: AppColor().white, fontSize: 18))),
                      ),
                    ],
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
