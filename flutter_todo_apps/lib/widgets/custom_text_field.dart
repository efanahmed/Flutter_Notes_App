import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  final bool obscureText;
  final String? labelText;
  final String? hintText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final Widget? label;
  const CustomTextField({
    Key? key,
    this.controller,
    this.keyboardType,
    this.validator,
    this.obscureText = false,
    this.labelText,
    this.hintText,
    this.prefixIcon,
    this.suffixIcon,
    this.label,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10.0, right: 10.0),
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(
            Radius.circular(10.0),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 10),
          child: TextFormField(
            controller: controller,
            keyboardType: keyboardType,
            validator: validator,
            obscureText: obscureText,
            decoration: InputDecoration(
              border: InputBorder.none,
              labelText: labelText,
              hintText: hintText,
              prefixIcon: prefixIcon,
              suffixIcon: suffixIcon,
              label: label,
              labelStyle: TextStyle(color: Colors.black),
            ),
          ),
        ),
      ),
    );
  }
}