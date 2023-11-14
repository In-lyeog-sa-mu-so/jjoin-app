import 'package:get/get.dart';
import 'package:jjoin/repository/club/club_repository.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../model/club/calendar_date.dart';
import '../../model/club/club_schedule.dart';

class CalendarViewModel extends GetxController {
  final ClubRepository clubRepository;

  CalendarViewModel({required this.clubRepository});

  /* Calendar Date */
  late final Rx<CalendarDate> _calendarDate;
  DateTime get selectedDate => _calendarDate.value.selectedDate;
  DateTime get focusedDate => _calendarDate.value.focusedDate;

  /* Calendar */
  late final Rx<CalendarFormat> _calendarFormat;
  late final RxMap<String, List<String>> _calendarDays;
  late final RxBool _isLoadingCalendar;
  CalendarFormat get calendarFormat => _calendarFormat.value;
  Map<String, List<String>> get calendarDays => _calendarDays;
  bool get isLoadingCalendar => _isLoadingCalendar.value;

  /* Club Schedules */
  late final RxList<ClubSchedule> _schedules;
  late final RxBool _isLoadingSchedules;
  List<ClubSchedule> get schedules => _schedules;
  bool get isLoadingSchedules => _isLoadingSchedules.value;

  @override
  void onInit() {
    super.onInit();

    _calendarDate = CalendarDate.selectedDate(selectedDate: DateTime.now()).obs;
    _calendarFormat = CalendarFormat.week.obs;
    _isLoadingCalendar = false.obs;

    _isLoadingSchedules = true.obs;

    initCalendarDays();
    initSchedules();
  }

  /* Init */
  void initCalendarDays() {
    _isLoadingCalendar.value = true;
    clubRepository
        .getCalendarSchedules(_calendarDate.value.focusedDate)
        .then((value) => _calendarDays = value.obs)
        .then((value) => _isLoadingCalendar.value = false);
  }

  void initSchedules() {
    _isLoadingCalendar.value = true;
    _schedules = clubRepository
        .getCalendarScheduleForDate(_calendarDate.value.selectedDate)
        .obs;
    _isLoadingCalendar.value = false;
  }

  /* fetch */
  void fetchCalendarDays() {
    _isLoadingCalendar.value = true;
    clubRepository
        .getCalendarSchedules(_calendarDate.value.focusedDate)
        .then((value) => _calendarDays.value = value)
        .then((value) => _isLoadingCalendar.value = false);
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
    bool isSuccess = false;
    clubRepository.updateSchedule(id, isAgree).then((value) => {
          if (value)
            {
              _schedules.removeWhere((element) => element.id == id),
              isSuccess = true
            }
          else
            {
              isSuccess = false,
            }
        });

    return isSuccess;
  }
}
