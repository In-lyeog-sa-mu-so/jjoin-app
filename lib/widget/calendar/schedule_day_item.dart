import 'package:flutter/material.dart';
import 'package:jjoin/model/club/calendar_schedule.dart';

class ScheduleDayItem extends StatelessWidget {
  final DateTime day;
  final bool isSelected;
  final CalendarSchedule schedule;
  const ScheduleDayItem({
    Key? key,
    required this.day,
    required this.isSelected,
    required this.schedule,
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
              day.day.toString(),
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
        for (int i = 0; i < 3; i++)
          Container(
            height: 15,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Colors.blue[200],
            ),
            child: Center(
              child: Text(
                schedule.todos[i].title.length > 4
                    ? "${schedule.todos[i].title.substring(0, 4)}..."
                    : schedule.todos[i].title,
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
