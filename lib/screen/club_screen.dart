import 'package:flutter/material.dart';
import 'package:jjoin/widget/base/default_back_appbar.dart';
import 'package:jjoin/widget/calendar/schedule_calendar.dart';

class ClubScreen extends StatelessWidget {
  const ClubScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: DefaultBackAppbar(
          title: "동아리",
        ),
      ),
      body: Center(
        child: Text("동아리"),
      ),
    );
  }
}
