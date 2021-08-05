import 'package:flutter/material.dart';

class LabelOfTextFormFiled extends StatelessWidget {
  final String label;

  const LabelOfTextFormFiled({
    Key? key,
    required this.label,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: TextStyle(
        fontSize: 18.0,
        color: Color(0xff999090),
      ),
    );
  }
}
