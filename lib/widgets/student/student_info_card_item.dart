import 'package:flutter/material.dart';

class StudentInfoCardItem extends StatelessWidget {
  const StudentInfoCardItem({
    Key? key,
    required this.title,
    required this.subTitle,
  });

  final title;
  final subTitle;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      elevation: 3.0,
      margin: const EdgeInsets.all(10.0),
      child: ListTile(
        leading: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title,
            ),
          ],
        ),
        title: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              subTitle,
            ),
          ],
        ),
      ),
    );
  }
}
