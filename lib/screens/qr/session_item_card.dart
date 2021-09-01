import 'package:flutter/material.dart';

class SessionItemCard extends StatelessWidget {
  final String title;
  var onTapItem;
  final String srcImage;
  SessionItemCard({
    Key? key,
    required this.title,
    required this.onTapItem,
    required this.srcImage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      elevation: 2,
      child: InkWell(
        borderRadius: BorderRadius.circular(15),
        onTap: onTapItem,
        child: Padding(
          padding: EdgeInsets.symmetric(
            vertical: height * 0.04,
            horizontal: width * 0.04,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                srcImage,
              ),
              SizedBox(
                height: height * 0.04,
              ),
              Text(
                title,
                style: TextStyle(
                  fontWeight: FontWeight.w900,
                  fontSize: 28,
                  color: Color(0xffFF7E2D),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

