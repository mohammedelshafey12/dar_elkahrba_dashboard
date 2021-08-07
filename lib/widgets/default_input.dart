import 'package:flutter/material.dart';

class DefaultInput extends StatelessWidget {
  final TextEditingController controller;
  final TextInputType type;
  final validator;
  var suffixIcon;
  var onTapSuffixIcon;
  bool obscureText;

  DefaultInput({
    Key? key,
    required this.controller,
    required this.type,
    required this.validator,
    this.suffixIcon,
    this.onTapSuffixIcon,
    this.obscureText = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: type,
      validator: validator,
      obscureText: obscureText,
      decoration: InputDecoration(
        suffixIcon: suffixIcon != null ? IconButton(onPressed: onTapSuffixIcon,icon: Icon(suffixIcon,),) : null,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
      ),
    );
  }
}
