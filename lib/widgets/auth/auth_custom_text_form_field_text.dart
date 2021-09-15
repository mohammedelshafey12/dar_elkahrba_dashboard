import 'package:flutter/material.dart';

class AuthCustomTextFormFieldText extends StatelessWidget {
  const AuthCustomTextFormFieldText({
    Key? key,
    required this.title,
    required this.controller,
    required this.icon,
    required this.keyboardType,
  });

  final title;
  final controller;
  final icon;
  final keyboardType;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: false,
      keyboardType: keyboardType,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return '$title must be not empty';
        }
        return null;
      },
      decoration: InputDecoration(
        hintText: title,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        prefixIcon: Icon(icon),
      ),
    );
  }
}
