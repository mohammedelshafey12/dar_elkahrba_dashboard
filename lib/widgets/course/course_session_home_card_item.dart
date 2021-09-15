import 'package:flutter/material.dart';

class CourseSessionHomeCardItem extends StatelessWidget {
  const CourseSessionHomeCardItem({Key? key,
    required this.title,
    required this.icon,
    required this.onTap,
  });

  final title;
  final icon;
  final onTap;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery
        .of(context)
        .size
        .width;
    double height = MediaQuery
        .of(context)
        .size
        .height;
    return Expanded(
      child: Card(
        elevation: 5.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: InkWell(
          borderRadius: BorderRadius.circular(10.0),
          onTap: (){
            onTap();
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Icon(icon, size: height * 0.2,),
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
