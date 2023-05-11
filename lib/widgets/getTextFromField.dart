import 'package:flutter/material.dart';
// import '../../ui/export.dart

// ignore: must_be_immutable
class getTextFormField extends StatelessWidget {

  TextEditingController controller;
  String hintName;
  IconData ?icon;
  bool isObscureText;
  TextInputType inputType;
  bool isEnable;

  getTextFormField({
    required this.controller,
    required this.hintName,
    this.icon,
    this.isObscureText = false,
    this.inputType = TextInputType.text,
    this.isEnable = true,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      // padding:const EdgeInsets.only(top: 1),
      child: TextFormField(
        textAlign: TextAlign.left,
        controller: controller,
        obscureText: isObscureText,
        enabled: isEnable,
        keyboardType: inputType,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return '$hintName оруулна уу!';
          }
       
          return null;
        },
        decoration: InputDecoration(
          fillColor: Colors.white,
          filled: true,
          hintText: hintName,
          prefixIcon: Icon(icon),
          labelText: hintName,
          hintStyle: TextStyle(
            color: Colors.black,
          ),
        ),
        // style: const TextStyle(
        //     color: Colors.black,
        //     fontSize: 20,
        //     fontWeight: FontWeight.w700),
      ),
    );
  }
}
