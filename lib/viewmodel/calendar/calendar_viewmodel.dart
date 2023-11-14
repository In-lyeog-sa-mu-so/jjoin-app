import 'package:get/get.dart';
import 'package:jjoin/repository/club/club_repository.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../model/club/calendar_date.dart';
import '../../model/club/club_schedule.dart';
import '../home/home_viewmodel.dart';

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

    initCalendarBase();
    initCalendarDays();
    initSchedules();
  }

  /* Init */
  void initCalendarBase() {
    _calendarDate = CalendarDate.selectedDate(selectedDate: DateTime.now()).obs;
    _calendarFormat = CalendarFormat.week.obs;

    _isLoadingCalendar = true.obs;
    _isLoadingSchedules = true.obs;
  }

  void initCalendarDays() {
    _isLoadingCalendar.value = true;
    clubRepository
        .getCalendarSchedules(_calendarDate.value.focusedDate)
        .then((value) => _calendarDays = value.obs)
        .then((value) => _isLoadingCalendar.value = false);
  }

  void initSchedules() {
    _isLoadingSchedules.value = true;
    clubRepository
        .getCalendarScheduleForDate(_calendarDate.value.selectedDate)
        .then((value) => _schedules = value.obs)
        .then((value) => _isLoadingSchedules.value = false);
  }

  /* fetch */
  void fetchCalendarDays() {
    clubRepository
        .getCalendarSchedules(_calendarDate.value.focusedDate)
        .then((value) => _calendarDays.value = value);
  }

  void fetchSchedules() {
    clubRepository
        .getCalendarScheduleForDate(_calendarDate.value.selectedDate)
        .then((value) => _schedules.value = value);
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

  Future<bool> updateSchedule(int id, bool isAgree) async {
    bool isSuccess = await clubRepository.updateSchedule(id, isAgree);

    if (isSuccess) {
      fetchCalendarDays();
      Get.find<HomeViewModel>().updateScheduleByUpdatingPlan(id, isAgree);
      _schedules.value = _schedules.map((e) {
        if (e.id == id) {
          return e.copyWith(isAgreed: isAgree);
        } else {
          return e;
        }
      }).toList();
      return true;
    } else {
      return false;
    }
  }

  void updateScheduleByUpdatingSchedule(int id, bool isAgreed) {
    _schedules.value = _schedules.map((e) {
      if (e.id == id) {
        return e.copyWith(isAgreed: isAgreed);
      } else {
        return e;
      }
    }).toList();
  }
}
