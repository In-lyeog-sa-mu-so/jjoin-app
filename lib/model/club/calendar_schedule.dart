import 'club_schedule.dart';

class CalendarSchedule {
  final DateTime date;
  final List<ClubSchedule> todos;

  const CalendarSchedule({
    required this.date,
    required this.todos,
  });
}
