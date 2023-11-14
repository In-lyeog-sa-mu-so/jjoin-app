import 'package:flutter/material.dart';

class ScheduleDayItem extends StatelessWidget {
  final DateTime date;
  final bool isSelected;
  final List<String> schedules;
  const ScheduleDayItem({
    Key? key,
    required this.date,
    required this.isSelected,
    required this.schedules,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 22,
          height: 22,
          margin: const EdgeInsets.all(4.0),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: isSelected ? Colors.blue[300] : Colors.transparent,
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: Center(
            child: Text(
              date.day.toString(),
              style: isSelected
                  ? const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    )
                  : const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
            ),
          ),
        ),
        for (int i = 0; i < (schedules.length > 3 ? 3 : schedules.length); i++)
          Container(
            height: 15,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Colors.blue[200],
            ),
            child: Center(
              child: Text(
                schedules[i].length > 4
                    ? "${schedules[i].substring(0, 4)}..."
                    : schedules[i],
                style: const TextStyle(
                  fontSize: 10,
                  color: Colors.black,
                ),
              ),
            ),
          ),
      ],
    );
  }
}
