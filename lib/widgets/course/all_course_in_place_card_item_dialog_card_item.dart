import 'package:flutter/material.dart';

class AllCourseInPlaceCardItemDialogCardItem extends StatelessWidget {
  const AllCourseInPlaceCardItemDialogCardItem({
    Key? key,
    required this.title,
    required this.icon,
    required this.onTap,
  });
  final title;
  final icon;
  final onTap;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        elevation: 5.0,
        child: InkWell(
          borderRadius: BorderRadius.circular(15.0),
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
