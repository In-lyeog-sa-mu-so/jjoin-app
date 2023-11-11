import 'package:flutter/material.dart';

class ClubTagWidget extends StatelessWidget {
  final String title;
  const ClubTagWidget({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 5),
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
          color: Colors.grey.withOpacity(0.5),
          width: 1,
        ),
      ),
      child: Center(
        child: Text(
          title,
          style: TextStyle(
            fontSize: 12,
          ),
        ),
      ),
    );
  }
}
