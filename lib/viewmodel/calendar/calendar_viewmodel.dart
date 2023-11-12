import 'package:get/get.dart';
import 'package:jjoin/repository/club/club_repository.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../model/club/calendar_date.dart';
import '../../model/club/club_schedule.dart';

class CalendarViewModel extends GetxController {
  final ClubRepository clubRepository;

  CalendarViewModel({required this.clubRepository})
      : assert(clubRepository != null);

  /* Calendar Date */
  final Rx<CalendarDate> _calendarDate = CalendarDate.selectedDate(
    selectedDate: DateTime.now(),
  ).obs;
  DateTime get selectedDate => _calendarDate.value.selectedDate;
  DateTime get focusedDate => _calendarDate.value.focusedDate;

  /* Calendar */
  final Rx<CalendarFormat> _calendarFormat = CalendarFormat.week.obs;
  final RxMap<String, List<ClubSchedule>> _calendarDays = RxMap({});
  final RxBool _isLoadingCalendar = false.obs;
  CalendarFormat get calendarFormat => _calendarFormat.value;
  Map<String, List<ClubSchedule>> get calendarDays => _calendarDays;
  bool get isLoadedCalendar => _isLoadingCalendar.value;

  /* Club Schedules */
  final RxList<ClubSchedule> _schedules = RxList();
  final RxBool _isLoadingSchedules = false.obs;
  List<ClubSchedule> get schedules => _schedules;
  bool get isLoadingSchedules => _isLoadingSchedules.value;

  @override
  void onInit() {
    super.onInit();

    fetchCalendarDays();
    fetchSchedules();
  }

  /* Fetch */
  void fetchCalendarDays() {
    _isLoadingCalendar.value = true;
    _calendarDays.value =
        clubRepository.getCalendarSchedules(_calendarDate.value.focusedDate);
    _isLoadingCalendar.value = false;
  }

  void fetchSchedules() {
    _isLoadingCalendar.value = true;
    _schedules.value = clubRepository
        .getCalendarScheduleForDate(_calendarDate.value.selectedDate);
    _isLoadingCalendar.value = false;
  }

  /* Update */
  void updateFocusedDate(DateTime date) {
    int beforeMonth = _calendarDate.value.focusedDate.month;
    _calendarDate.value = _calendarDate.value.copyWith(focusedDate: date);

    if (beforeMonth != _calendarDate.value.focusedDate.month) {
      fetchCalendarDays();
    }
  }

  void updateSelectedDate(DateTime date) {
    int beforeMonth = _calendarDate.value.focusedDate.month;

    // _calendarModel의 selectedDate를 date로 변경
    _calendarDate.value =
        _calendarDate.value.copyWith(selectedDate: date, focusedDate: date);

    if (beforeMonth != _calendarDate.value.focusedDate.month) {
      fetchCalendarDays();
    }

    fetchSchedules();
  }

  void updateCalendarFormat(CalendarFormat format) {
    _calendarFormat.value = format;
  }

  bool updateSchedule(int id, bool isAgree) {
    bool isSuccess = clubRepository.updateSchedule(id, isAgree);

    if (isSuccess) {
      _schedules.removeWhere((element) => element.id == id);
      return true;
    } else {
      return false;
    }
  }
}
