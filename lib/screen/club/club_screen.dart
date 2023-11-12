import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:jjoin/viewmodel/club/club_viewmodel.dart';
import 'package:jjoin/widget/base/default_back_appbar.dart';
import 'package:jjoin/widget/club/club_disable_event_item_widget.dart';
import 'package:jjoin/widget/club/club_plan_item_widget.dart';

import '../../provider/club/club_local_provider.dart';
import '../../provider/club/club_remote_provider.dart';
import '../../repository/club/club_repository.dart';
import '../../widget/club/club_information_widget.dart';
import '../../widget/club/club_notice_item_widget.dart';

class ClubScreen extends StatefulWidget {
  const ClubScreen({super.key});

  @override
  State<ClubScreen> createState() => _ClubScreenState();
}

class _ClubScreenState extends State<ClubScreen>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;
  late final ClubViewModel _clubViewModel;
  late final int _clubId;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = TabController(
      length: 2,
      vsync: this,
    );
    _tabController.addListener(() {
      setState(() {});
    });
    _clubViewModel = Get.put(ClubViewModel(
      clubRepository: ClubRepository(
        clubLocalProvider: Get.put(ClubLocalProvider()),
        clubRemoteProvider: Get.put(ClubRemoteProvider()),
      ),
    ));
    _clubId = Get.arguments["clubId"];
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFFFF),
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: DefaultBackAppbar(
          title: "동아리",
        ),
      ),
      body: Column(
        children: [
          ClubInformation(),
          // 실선
          Container(
            margin: const EdgeInsets.only(
              top: 10,
            ),
            height: 1,
            color: Colors.grey[300],
          ),
          TabBar(
            controller: _tabController,
            indicatorColor: Colors.green,
            labelColor: Colors.green,
            // 올렸을 때 색 바꾸기
            unselectedLabelColor: Colors.grey[600],
            overlayColor: MaterialStateProperty.all(Colors.white),
            labelStyle: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
            tabs: const [
              Tab(
                text: "공지 사항",
              ),
              Tab(
                text: "행사 일정",
              ),
            ],
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                ListView.builder(
                  itemCount: _clubViewModel.notices.length,
                  itemBuilder: (context, index) {
                    return ClubNoticeItem(
                      item: _clubViewModel.notices[index],
                      clubId: _clubId,
                    );
                  },
                ),
                ListView.builder(
                  itemCount: _clubViewModel.schedules.length,
                  itemBuilder: (context, index) {
                    return ClubPlanItem(item: _clubViewModel.schedules[index]);
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
