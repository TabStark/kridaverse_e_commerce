import 'package:flutter/material.dart';
import 'package:kridaverse_e_commerce/Theme/appColor.dart';

class ReusableTextFormField extends StatefulWidget {
  final TextEditingController controller;
  final String fieldName;
  final bool isObsecure;
  final TextInputType keyboardtype;
  
  const ReusableTextFormField(
      {super.key,
      required this.controller,
      required this.fieldName,
      this.isObsecure = false, required this.keyboardtype});

  @override
  State<ReusableTextFormField> createState() => _ReusableTextFormFieldState();
}

class _ReusableTextFormFieldState extends State<ReusableTextFormField> {
  @override
  bool obsvalue = true;
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: widget.keyboardtype,
      controller: widget.controller,
      obscureText: widget.isObsecure ? obsvalue : widget.isObsecure,
      style: TextStyle(color: AppColor().white),
      decoration: InputDecoration(
          hintText: widget.fieldName,
          hintStyle: TextStyle(color: AppColor().white),
          labelText: widget.fieldName,
          labelStyle: TextStyle(color: AppColor().white),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: AppColor().white)),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: AppColor().white)),
          suffixIcon: widget.isObsecure
              ? IconButton(
                  onPressed: () {
                    setState(() {});
                    obsvalue = !obsvalue;
                    print(obsvalue);
                  },
                  icon: Icon(
                    Icons.remove_red_eye_outlined,
                    color: AppColor().white,
                  ))
              : null),
    );
  }
}
