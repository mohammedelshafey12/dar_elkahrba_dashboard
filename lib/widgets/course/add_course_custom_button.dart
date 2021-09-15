import 'package:flutter/material.dart';

class AddCourseCustomButton extends StatelessWidget {
  const AddCourseCustomButton({
    Key? key,
    required this.title,
    required this.onPressed,
  });

  final title;
  final onPressed;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          10.0,
        ),
        border: Border.all(
          color: Colors.blue,
        ),
        color: Colors.blue,
      ),
      width: width,
      height: 50.0,
      child: MaterialButton(
        height: 50.0,
        child: Text(
          title,
          style: TextStyle(
            fontSize: 18,
            letterSpacing: 0.5,
            color: Colors.white,
          ),
        ),
        onPressed: () {
          onPressed();
        },
      ),
    );
  }
}
