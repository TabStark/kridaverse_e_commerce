import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kridaverse_e_commerce/Theme/appColor.dart';
import 'package:kridaverse_e_commerce/main.dart';
import 'package:kridaverse_e_commerce/screens/confirmed_payment.dart';

class OrderNow extends StatefulWidget {
  final String docId;
  final DocumentSnapshot documentSnapshot;
  const OrderNow(
      {super.key, required this.docId, required this.documentSnapshot});

  @override
  State<OrderNow> createState() => _OrderNowState();
}

class _OrderNowState extends State<OrderNow> {
  bool addressbool = true;
  TextEditingController _addressController = TextEditingController();
  final _form = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    // To store Qty
    final int totalqty =
        (widget.documentSnapshot.data() as Map<String, dynamic>?)
                    ?.containsKey('qty') ??
                false
            ? widget.documentSnapshot['qty']
            : 1;

    // Remove Special Character from string (Price)
    String newPrice = widget.documentSnapshot['price'];
    int totalPrice =
        int.parse(newPrice.replaceAll(',', '').replaceAll('₹', ''));
    NumberFormat myFormat = NumberFormat.decimalPattern('en_us');
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor().white,
        leading: BackButton(color: AppColor().black),
        title: Text(
          "Order",
          style: TextStyle(color: AppColor().black),
        ),
        actions: [
          IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.notifications_none,
                size: 30,
                color: AppColor().black,
              ))
        ],
      ),
      body: Form(
        key: _form,
        child: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                        width: mq.width * 0.3,
                        child: Image.network(widget.documentSnapshot['img'])),
                    SizedBox(
                      width: mq.width * 0.01,
                    ),
                    SizedBox(
                      width: mq.width * .6,
                      height: mq.height * 0.16,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'iPhone',
                            style: TextStyle(
                                color: AppColor().darkGrey, fontSize: 16),
                          ),
                          Text(
                            widget.documentSnapshot['name'],
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontSize: 16, color: AppColor().black),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                Divider(),
                Padding(
                    padding: EdgeInsets.symmetric(horizontal: mq.width * 0.05),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          height: mq.height * 0.02,
                        ),
                        Text(
                          'Order Details:',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: mq.height * 0.02,
                        ),

                        // BRAND
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: mq.width * 0.35,
                              child: Text('Brand : ',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500)),
                            ),
                            Text('iPhone',
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.w500)),
                          ],
                        ),
                        SizedBox(
                          height: mq.height * 0.02,
                        ),

                        // PRODUCT NAME
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text('Product Name : ',
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.w500)),
                            SizedBox(
                              height: mq.height * 0.07,
                              width: mq.width * 0.5,
                              child: Text(widget.documentSnapshot['name'],
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500)),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: mq.height * 0.02,
                        ),

                        // QTY
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: mq.width * 0.35,
                              child: Text('QTY : ',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500)),
                            ),
                            Text(totalqty.toString(),
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.w500)),
                          ],
                        ),
                        SizedBox(
                          height: mq.height * 0.02,
                        ),

                        // PRICE
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: mq.width * 0.35,
                              child: Text('Price : ',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500)),
                            ),
                            Text(widget.documentSnapshot['price'],
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.w500)),
                          ],
                        ),
                        SizedBox(
                          height: mq.height * 0.02,
                        ),

                        // Total Price
                        // PRICE
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: mq.width * 0.35,
                              child: Text('Total Price : ',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500)),
                            ),
                            Text("₹${(myFormat.format(totalPrice * totalqty))}",
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.w500)),
                          ],
                        ),

                        SizedBox(
                          height: mq.height * 0.18,
                        ),

                        // PROCEED TO PAYMENT BUTTONS
                        SizedBox(
                          height: mq.height * .055,
                          width: mq.width * 1,
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5)),
                                  backgroundColor: AppColor().darkGrey),
                              onPressed: () {
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ConfirmedScreen(
                                              msg:
                                                  'Order Confirmed Successfully',
                                            )));
                              },
                              child: Text('Confirmed Order',
                                  style: TextStyle(
                                      color: AppColor().white, fontSize: 18))),
                        ),
                      ],
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
