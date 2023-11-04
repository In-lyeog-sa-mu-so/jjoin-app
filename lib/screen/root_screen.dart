import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jjoin/screen/profile_screen.dart';
import 'package:jjoin/screen/search_club_screen.dart';

import '../common/bottom_navigation_bar.dart';
import 'calendar_screen.dart';
import 'home_screen.dart';

class RootScreen extends StatelessWidget {
  const RootScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(CustomBottomNavigationBarController());
    return SafeArea(
      child: Scaffold(
        body: Obx(() => IndexedStack(
              index: CustomBottomNavigationBarController.to.selectedIndex.value,
              children: const [
                HomeScreen(),
                CalendarScreen(),
                SearchClubScreen(),
                ProfileScreen(),
              ],
            )),
        bottomNavigationBar: const CustomBottomNavigationBar(),
      ),
    );
  }
}
