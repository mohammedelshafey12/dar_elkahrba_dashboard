import 'package:flutter/material.dart';

class AddCourseCustomTextFormField extends StatelessWidget {
  const AddCourseCustomTextFormField({
    Key? key,
    required this.title,
    required this.controller,
  });

  final title;
  final controller;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
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
      ),
    );
  }
}
