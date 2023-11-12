import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ClubSvgInfoWidget extends StatelessWidget {
  final String title;
  final String imagePath;
  const ClubSvgInfoWidget(
      {super.key, required this.title, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SvgPicture.asset(
          imagePath,
          width: 16,
          height: 16,
        ),
        SizedBox.fromSize(size: const Size(5, 0)),
        Text(
          title,
          style: TextStyle(
            fontSize: 15,
          ),
        ),
      ],
    );
  }
}
