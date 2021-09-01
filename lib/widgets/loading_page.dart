import 'package:flutter/material.dart';

class LoadingPage extends StatelessWidget {
  const LoadingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Loading...",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontFamily: 'customFont',
            ),
          ),
          SizedBox(
            height: 20.0,
          ),
          CircularProgressIndicator()
        ],
      ),
    );
  }
}
