import 'package:flutter/material.dart';
import 'package:kridaverse_e_commerce/APIS/apis.dart';
import 'package:kridaverse_e_commerce/Custom%20Widgets/eleveted_button.dart';
import 'package:kridaverse_e_commerce/Theme/appColor.dart';
import 'package:kridaverse_e_commerce/main.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: AppColor().darkGrey,
        title: Text(
          'Perfile',
          style: TextStyle(color: AppColor().white),
        ),
      ),
      body: Container(
        height: mq.height * 1,
        width: mq.width * 1,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                height: mq.height * .25,
                width: mq.width * 1,
                color: AppColor().blue,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    CircleAvatar(
                      radius: mq.width * 0.16,
                      backgroundImage: NetworkImage(Apis.me.img),
                    )
                  ],
                )),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Name',
                    style: TextStyle(color: AppColor().purple, fontSize: 18),
                  ),
                  Text(
                    Apis.me.name,
                    style: TextStyle(color: AppColor().black, fontSize: 22),
                  )
                ],
              ),
            ),
            SizedBox(
              height: mq.height * .03,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Email',
                    style: TextStyle(color: AppColor().purple, fontSize: 18),
                  ),
                  Text(
                    Apis.me.email,
                    style: TextStyle(color: AppColor().black, fontSize: 22),
                  )
                ],
              ),
            ),
            SizedBox(
              height: mq.height * .03,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Phone',
                    style: TextStyle(color: AppColor().purple, fontSize: 18),
                  ),
                  Text(
                    Apis.me.phone == null ? Apis.me.phone : 'N/A',
                    style: TextStyle(color: AppColor().black, fontSize: 22),
                  )
                ],
              ),
            ),
            SizedBox(
              height: mq.height * .2,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              width: mq.width * 0.4,
              child: ElevatedButton(
                onPressed: () async {
                  await Apis().logoutFromDevice(context);
                },
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(AppColor().black),
                    shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)))),
                child: Text(
                  'Logout',
                  style: TextStyle(color: AppColor().white),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
