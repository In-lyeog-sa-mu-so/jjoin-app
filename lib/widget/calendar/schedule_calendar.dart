import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:jjoin/viewmodel/calendar/calendar_viewmodel.dart';
import 'package:jjoin/widget/calendar/schedule_day_item.dart';
import 'package:table_calendar/table_calendar.dart';

class ScheduleCalendar extends StatefulWidget {
  final CalendarViewModel viewModel;
  const ScheduleCalendar({Key? key, required this.viewModel}) : super(key: key);

  @override
  State<ScheduleCalendar> createState() => _ScheduleCalendarState();
}

class _ScheduleCalendarState extends State<ScheduleCalendar> {
  late final CalendarViewModel _viewModel;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _viewModel = widget.viewModel;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: TableCalendar(
        // 기본 설정
        locale: 'ko_KR',
        firstDay: DateTime.now().subtract(const Duration(days: 365 * 10 + 2)),
        lastDay: DateTime.now().add(const Duration(days: 365 * 10 + 2)),
        focusedDay: _viewModel.focusedDate,
        calendarFormat: _viewModel.calendarFormat,
        daysOfWeekHeight: 30,
        rowHeight: 75,

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
          return isSameDay(_viewModel.selectedDate, day);
        },
        onDaySelected: (selectedDay, focusedDay) {
          if (!isSameDay(_viewModel.selectedDate, selectedDay)) {
            // Call `setState()` when updating the selected day
            setState(() {
              _viewModel.updateSelectedDate(selectedDay);
            });
          }
        },
        onFormatChanged: (format) {
          if (_viewModel.calendarFormat != format) {
            // Call `setState()` when updating calendar format
            setState(() {
              _viewModel.updateCalendarFormat(format);
            });
          }
        },
        onPageChanged: (focusedDay) {
          // No need to call `setState()` here
          _viewModel.updateFocusedDate(focusedDay);
        },
        calendarBuilders: CalendarBuilders(
          defaultBuilder: (context, day, focusedDay) {
            return Obx(
              () => _viewModel.isLoadingCalendar
                  ? Container(
                      color: Colors.white,
                      height: 75,
                      width: 30,
                    )
                  : ScheduleDayItem(
                      date: day,
                      isSelected: false,
                      schedules: _viewModel
                          .calendarDays[DateFormat('yyyy-MM-dd').format(day)]!),
            );
          },
          outsideBuilder: (context, day, focusedDay) {
            return Opacity(
                opacity: 0.4,
                child: Obx(
                  () => _viewModel.isLoadingCalendar
                      ? Container(
                          color: Colors.white,
                          height: 75,
                          width: 30,
                        )
                      : ScheduleDayItem(
                          date: day,
                          isSelected: false,
                          schedules: _viewModel.calendarDays[
                              DateFormat('yyyy-MM-dd').format(day)]!),
                ));
          },
          selectedBuilder: (context, day, focusedDay) {
            return Obx(
              () => _viewModel.isLoadingCalendar
                  ? Container(
                      color: Colors.white,
                      height: 75,
                      width: 30,
                    )
                  : ScheduleDayItem(
                      date: day,
                      isSelected: true,
                      schedules: _viewModel
                          .calendarDays[DateFormat('yyyy-MM-dd').format(day)]!),
            );
          },
          todayBuilder: (context, day, focusedDay) {
            return Obx(
              () => _viewModel.isLoadingCalendar
                  ? Container(
                      color: Colors.white,
                      height: 75,
                      width: 30,
                    )
                  : ScheduleDayItem(
                      date: day,
                      isSelected: false,
                      schedules: _viewModel
                          .calendarDays[DateFormat('yyyy-MM-dd').format(day)]!),
            );
          },
        ),
      ),
    );
  }
}
