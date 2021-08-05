import 'package:dar_elkahrba/widgets/home_page_grid_item.dart';
import 'package:flutter/material.dart';

class HomePageGrid extends StatelessWidget {
  const HomePageGrid({
    Key? key,
    required this.deviceSize,
    required this.titles,
  }) : super(key: key);

  final Size deviceSize;
  final List<String> titles;

  @override
  Widget build(BuildContext context) {
    return GridView(
      padding: EdgeInsets.symmetric(
          vertical: deviceSize.height * 0.06,
          horizontal: deviceSize.width * 0.2),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          mainAxisExtent: deviceSize.height * 0.3,
          crossAxisCount: 2,
          mainAxisSpacing: deviceSize.height * 0.2,
          crossAxisSpacing: deviceSize.width * 0.2,
          childAspectRatio: 3 / 2),
      children: [
        ...titles
            .map(
              (title) => HomePageGridItem(title),
            )
            .toList()
      ],
    );
  }
}
