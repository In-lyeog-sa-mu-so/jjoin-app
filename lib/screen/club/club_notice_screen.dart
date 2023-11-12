import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jjoin/widget/base/default_back_appbar.dart';

import '../../provider/club/club_local_provider.dart';
import '../../provider/club/club_remote_provider.dart';
import '../../repository/club/club_repository.dart';
import '../../viewmodel/club/club_notice_detail_viewmodel.dart';

class ClubNoticeScreen extends StatefulWidget {
  const ClubNoticeScreen({Key? key}) : super(key: key);

  @override
  State<ClubNoticeScreen> createState() => _ClubNoticeScreenState();
}

class _ClubNoticeScreenState extends State<ClubNoticeScreen> {
  late final ClubNoticeDetailViewModel _clubNoticeViewModel;
  late final int _clubId;
  late final int _noticeId;

  @override
  void initState() {
    super.initState();
    _clubId = Get.arguments["clubId"];
    _noticeId = Get.arguments["noticeId"];

    _clubNoticeViewModel = Get.put(
      ClubNoticeDetailViewModel(
        clubId: _clubId,
        noticeId: _noticeId,
        clubRepository: Get.put(
          ClubRepository(
            clubLocalProvider: Get.put(ClubLocalProvider()),
            clubRemoteProvider: Get.put(ClubRemoteProvider()),
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
          title: "동아리 공지사항",
        ),
      ),
      body: Obx(
        () => _clubNoticeViewModel.isLoading == true
            ? Center(
                child: CircularProgressIndicator(
                  color: Colors.grey[300],
                ),
              )
            : SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            _clubNoticeViewModel.noticeDetail.title,
                            style: const TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox.fromSize(size: const Size.fromHeight(5)),
                          Text(
                            "작성일: ${_clubNoticeViewModel.noticeDetail.createdDateStr}",
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.grey[600],
                            ),
                          ),
                          Text(
                            "수정일: ${_clubNoticeViewModel.noticeDetail.updatedDateStr}",
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
                    SizedBox.fromSize(size: const Size.fromHeight(10)),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                      ),
                      child: Text(
                        _clubNoticeViewModel.noticeDetail.content,
                        style: const TextStyle(
                          fontSize: 18,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
