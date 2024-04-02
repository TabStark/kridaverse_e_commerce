import 'package:flutter/material.dart';
import 'package:kridaverse_e_commerce/Theme/appColor.dart';

class ReusableElevetedButton extends StatefulWidget {
  const ReusableElevetedButton(
      {super.key, required this.btnName, required this.userOnpressed});
  final String btnName;
  final Function() userOnpressed;

  @override
  State<ReusableElevetedButton> createState() => _ReusableElevetedButtonState();
}

class _ReusableElevetedButtonState extends State<ReusableElevetedButton> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: widget.userOnpressed,
      style: ButtonStyle(
          shape: MaterialStatePropertyAll(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)))),
      child: Text(
        widget.btnName,
        style: TextStyle(color: AppColor().black),
      ),
    );
  }
}
