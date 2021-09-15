import 'package:flutter/material.dart';

class AuthCustomTextFormFieldPassword extends StatelessWidget {
  const AuthCustomTextFormFieldPassword({
    Key? key,
    required this.title,
    required this.controller,
    required this.visible,
    required this.onPressed,
  });
  final title;
  final controller;
  final visible;
  final onPressed;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: visible,
      keyboardType: TextInputType.visiblePassword,
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
        prefixIcon: Icon(Icons.lock),
        suffixIcon: IconButton(
          onPressed: () {
            onPressed();
          },
          icon: Icon(
            visible ? Icons.visibility : Icons.visibility_off,
          ),
        ),
      ),
    );
  }
}
