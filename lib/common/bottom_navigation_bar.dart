import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class CustomBottomNavigationBar
    extends GetView<CustomBottomNavigationBarController> {
  const CustomBottomNavigationBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() => Theme(
          data: ThemeData(
            highlightColor: Colors.transparent,
            splashFactory: NoSplash.splashFactory,
          ),
          child: BottomNavigationBar(
            currentIndex: controller.selectedIndex.value,
            onTap: controller.changeIndex,

            // 선택에 따라 icon·label 색상 변경
            selectedItemColor: Colors.blue,
            unselectedItemColor: Colors.grey,

            // 선택에 따라 label text style 변경
            unselectedLabelStyle: const TextStyle(fontSize: 10),
            selectedLabelStyle: const TextStyle(fontSize: 10),

            // 탭 애니메이션 변경 (fixed: 없음)
            type: BottomNavigationBarType.fixed,
            backgroundColor: Colors.white,

            // Bar에 보여질 요소. icon과 label로 구성.
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                  icon: SvgPicture.asset(
                    'assets/icons/icon_profile_24.svg',
                  ),
                  label: "홈"),
              BottomNavigationBarItem(
                  icon: SvgPicture.asset(
                    'assets/icons/icon_profile_24.svg',
                  ),
                  label: "캘린더"),
              BottomNavigationBarItem(
                  icon: SvgPicture.asset(
                    'assets/icons/icon_profile_24.svg',
                  ),
                  label: "동아리찾기"),
              BottomNavigationBarItem(
                  icon: SvgPicture.asset(
                    'assets/icons/icon_profile_24.svg',
                  ),
                  label: "마이페이지"),
            ],
          ),
        ));
  }
}

class CustomBottomNavigationBarController extends GetxController {
  final RxInt selectedIndex = 0.obs;

  static CustomBottomNavigationBarController get to => Get.find();

  void changeIndex(int index) {
    selectedIndex(index);
  }
}
