import 'package:flutter/material.dart';

class ScheduleDayItem extends StatelessWidget {
  final DateTime day;
  final bool isSelected;
  const ScheduleDayItem({Key? key, required this.day, required this.isSelected})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.all(4.0),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: isSelected ? Colors.blue[300] : Colors.transparent,
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Text(day.day.toString(),
              style: isSelected
                  ? const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    )
                  : const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    )),
        ),
      ],
    );
  }
}
