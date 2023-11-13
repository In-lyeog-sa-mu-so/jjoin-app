import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jjoin/repository/club/club_repository.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

import '../../provider/club/club_local_provider.dart';
import '../../provider/club/club_remote_provider.dart';
import '../../viewmodel/club/club_plan_detail_viewmodel.dart';
import '../../widget/base/default_back_appbar.dart';

class ClubPlanScreen extends StatefulWidget {
  const ClubPlanScreen({super.key});

  @override
  State<ClubPlanScreen> createState() => _ClubPlanScreenState();
}

class _ClubPlanScreenState extends State<ClubPlanScreen> {
  late final int _clubId;
  late final int _scheduleId;
  late final ClubPlanDetailViewModel _viewModel;

  @override
  void initState() {
    super.initState();
    _clubId = Get.arguments["clubId"];
    _scheduleId = Get.arguments["scheduleId"];

    print("clubId: $_clubId, scheduleId: $_scheduleId");

    _viewModel = Get.put(
      ClubPlanDetailViewModel(
        clubId: _clubId,
        scheduleId: _scheduleId,
        clubRepository: Get.put(
          ClubRepository(
            clubLocalProvider: Get.put(ClubLocalProvider()),
            clubProvider: Get.put(ClubProvider()),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFFFF),
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: DefaultBackAppbar(
          title: "동아리 일정",
        ),
      ),
      body: Obx(
        () => _viewModel.isLoading == true
            ? Center(
                child: CircularProgressIndicator(
                  color: Colors.grey[300],
                ),
              )
            : SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            _viewModel.planDetail.title,
                            style: const TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox.fromSize(size: const Size.fromHeight(5)),
                        ],
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.only(right: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            "작성일: ${_viewModel.planDetail.createdDateStr}",
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.grey[600],
                            ),
                          ),
                          Text(
                            "수정일: ${_viewModel.planDetail.updatedDateStr}",
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox.fromSize(size: const Size.fromHeight(10)),
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: Colors.grey[300]!,
                            width: 1,
                          ),
                        ),
                      ),
                    ),
                    SizedBox.fromSize(size: const Size.fromHeight(30)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Column(
                          children: [
                            Text(
                              "시작  ",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              "종료  ",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Text(
                              _viewModel.planDetail.startDateStr,
                              style: const TextStyle(
                                fontSize: 18,
                              ),
                            ),
                            Text(
                              _viewModel.planDetail.endDateStr,
                              style: const TextStyle(
                                fontSize: 18,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox.fromSize(size: const Size.fromHeight(30)),
                    Text(
                      "일정 참여율: ${_viewModel.planDetail.progress.toStringAsFixed(1)}%",
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox.fromSize(size: const Size.fromHeight(10)),
                    // 일정 참여율 중앙정렬, 라운드 둥글게 처리
                    Container(
                      margin: const EdgeInsets.symmetric(
                        horizontal: 20,
                      ),
                      child: LinearPercentIndicator(
                        barRadius: Radius.circular(10),
                        animation: true,
                        lineHeight: 20.0,
                        animationDuration: 1500,
                        percent: _viewModel.planDetail.progress / 100,
                        progressColor: const Color(0xFF11C71B),
                      ),
                    ),
                    SizedBox.fromSize(size: const Size.fromHeight(50)),
                    // 참가, 불참 버튼 Row로 한줄로 표시
                    // 이때 참가는 파란색 배경에 흰 글짜, 불참은 연한 빨간 배경에 흰 글짜
                    // InkWell 사용
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox.fromSize(size: const Size(20, 0)),
                        Expanded(
                          child: Theme(
                            data: ThemeData(
                              splashColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                            ),
                            child: InkWell(
                              onTap: () {
                                _viewModel.updateSchedule(
                                    _viewModel.planDetail.id, true);
                              },
                              child: Container(
                                height: 70,
                                decoration: BoxDecoration(
                                  color: _viewModel.planDetail.isAgree ==
                                              null ||
                                          _viewModel.planDetail.isAgree == false
                                      ? Colors.blue[200]
                                      : Colors.blue,
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(16)),
                                ),
                                child: Center(
                                  child: Text(
                                    "참가",
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: _viewModel.planDetail.isAgree ==
                                                  null ||
                                              _viewModel.planDetail.isAgree ==
                                                  false
                                          ? Colors.grey
                                          : Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox.fromSize(size: const Size(10, 0)),
                        Expanded(
                          child: Theme(
                            data: ThemeData(
                              splashColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                            ),
                            child: InkWell(
                              onTap: () {
                                _viewModel.updateSchedule(
                                    _viewModel.planDetail.id, false);
                              },
                              child: Container(
                                height: 70,
                                decoration: BoxDecoration(
                                  color: _viewModel.planDetail.isAgree ==
                                              null ||
                                          _viewModel.planDetail.isAgree == false
                                      ? Colors.red
                                      : Colors.red[100],
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(16)),
                                ),
                                child: Center(
                                  child: Text(
                                    "불참",
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: _viewModel.planDetail.isAgree ==
                                                  null ||
                                              _viewModel.planDetail.isAgree ==
                                                  true
                                          ? Colors.grey
                                          : Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox.fromSize(size: const Size(20, 0)),
                      ],
                    ),
                    SizedBox.fromSize(size: const Size(0, 20)),
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: Colors.grey[300]!,
                            width: 1,
                          ),
                        ),
                      ),
                    ),
                    SizedBox.fromSize(size: const Size(0, 20)),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                      ),
                      child: Text(
                        _viewModel.planDetail.content,
                        style: const TextStyle(
                          fontSize: 18,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    SizedBox.fromSize(size: const Size(0, 20)),
                  ],
                ),
              ),
      ),
    );
  }
}
