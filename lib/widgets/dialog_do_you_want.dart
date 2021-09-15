import 'package:flutter/material.dart';

class DialogDoYouWant extends StatelessWidget {
  const DialogDoYouWant({
    Key? key,
    required this.onTapYes,
    required this.title,
  });

  final onTapYes;
  final title;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        title,
      ),
      content: Row(
        children: [
          Expanded(
            child: Container(
              color: Colors.green,
              child: TextButton(
                onPressed: () {
                  onTapYes();
                },
                child: Text(
                  'You',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            width: 5.0,
          ),
          Expanded(
            child: Container(
              color: Colors.red,
              child: TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(
                  'No',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
