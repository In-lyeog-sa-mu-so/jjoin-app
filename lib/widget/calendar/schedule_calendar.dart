import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class ScheduleCalendar extends StatefulWidget {
  const ScheduleCalendar({super.key});

  @override
  State<ScheduleCalendar> createState() => _ScheduleCalendarState();
}

class _ScheduleCalendarState extends State<ScheduleCalendar> {
  CalendarFormat _calendarFormat = CalendarFormat.week;
  DateTime _selectedDate = DateTime.now();
  DateTime _focusedDay = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: TableCalendar(
        // 기본 설정
        locale: 'ko_KR',
        firstDay: DateTime.now().subtract(const Duration(days: 365 * 10 + 2)),
        lastDay: DateTime.now().add(const Duration(days: 365 * 10 + 2)),
        focusedDay: _focusedDay,
        calendarFormat: _calendarFormat,

        // UI 지정
        headerStyle: const HeaderStyle(
          formatButtonVisible: true,
          titleTextStyle: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
          leftChevronIcon: Icon(
            Icons.chevron_left,
            color: Colors.black,
          ),
          rightChevronIcon: Icon(
            Icons.chevron_right,
            color: Colors.black,
          ),
          formatButtonTextStyle: TextStyle(
            fontSize: 15,
            color: Colors.black,
          ),
        ),
        availableCalendarFormats: const {
          CalendarFormat.week: '한 주씩 보기',
          CalendarFormat.month: '한 달씩 보기',
        },
        calendarStyle: const CalendarStyle(
          // Use `CalendarStyle` to customize the UI
          outsideDaysVisible: true,
        ),

        // 이벤트 지정
        selectedDayPredicate: (day) {
          return isSameDay(_selectedDate, day);
        },
        onDaySelected: (selectedDay, focusedDay) {
          if (!isSameDay(_selectedDate, selectedDay)) {
            // Call `setState()` when updating the selected day
            setState(() {
              _selectedDate = selectedDay;
              _focusedDay = focusedDay;
            });
          }
        },
        onFormatChanged: (format) {
          if (_calendarFormat != format) {
            // Call `setState()` when updating calendar format
            setState(() {
              _calendarFormat = format;
            });
          }
        },
        onPageChanged: (focusedDay) {
          // No need to call `setState()` here
          _focusedDay = focusedDay;
        },
      ),
    );
  }
}
