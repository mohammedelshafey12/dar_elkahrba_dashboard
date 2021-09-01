import 'package:flutter/material.dart';

class CourseCardItem extends StatelessWidget {
  const CourseCardItem({
    Key? key,
    required this.onTap,
    required this.height,
    required this.width,
    required this.icon,
    required this.title,
  });
  final Function onTap;
  final height;
  final width;
  final IconData icon;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        elevation: 6.0,
        child: InkWell(
          borderRadius: BorderRadius.circular(15),
          onTap: () => onTap(),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Icon(
                  icon,
                  size: 60.0,
                ),
                Text(
                  title,
                  style: TextStyle(
                    fontWeight: FontWeight.w900,
                    fontSize: 20.0,
                    color: Color(0xffFF7E2D),
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
