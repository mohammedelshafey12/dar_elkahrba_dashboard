import 'package:flutter/material.dart';

class StudentInfoText extends StatelessWidget {

  StudentInfoText({
    required this.title,
    this.subtitle,
  });

  var title;
  var subtitle;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(15.0),
      ),
      margin: const EdgeInsets.all(10.0),
      padding: const EdgeInsets.symmetric(
        vertical: 10.0,
        horizontal: 20.0,
      ),
      child: Text(
        '$title: ${subtitle == null ? '' : '$subtitle'}',
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}
