import 'package:flutter/material.dart';

class DefaultButton extends StatelessWidget {
  final String title;
  final double height;
  final double width;
  final Color color;
  var onPressed;

  DefaultButton({
    Key? key,
    required this.title,
    this.height = 50.0,
    this.width = double.infinity,
    this.color = Colors.green,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      child: MaterialButton(
        onPressed: onPressed,
        height: height,
        child: Text(
          title,
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            letterSpacing: 0.5,
          ),
        ),
        focusColor: color,
        elevation: 0.0,
        focusElevation: 0.0,
        hoverElevation: 0.0,
        highlightElevation: 0.0,
        color: color,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
      ),
    );
  }
}
