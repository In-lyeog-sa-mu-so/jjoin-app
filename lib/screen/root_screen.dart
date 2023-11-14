import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jjoin/screen/profile/profile_screen.dart';
import 'package:jjoin/screen/search/search_club_screen.dart';

import '../widget/base/bottom_navigation_bar.dart';
import 'calendar/calendar_screen.dart';
import 'home/home_screen.dart';

class RootScreen extends StatelessWidget {
  const RootScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(CustomBottomNavigationBarController());
    return Container(
      color: const Color(0xFFFFFFFF),
      child: SafeArea(
        child: Scaffold(
          backgroundColor: const Color(0xFFFFFFFF),
          body: Obx(() => IndexedStack(
                index:
                    CustomBottomNavigationBarController.to.selectedIndex.value,
                children: [
                  HomeScreen(),
                  CalendarScreen(),
                  SearchClubScreen(),
                  ProfileScreen(),
                ],
              )),
          bottomNavigationBar: const CustomBottomNavigationBar(),
        ),
      ),
    );
  }
}
