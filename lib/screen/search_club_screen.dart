import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../repository/SearchClub/search_club_repository.dart';

import '../model/SearchClub/search_club.dart';
import '../widget/search/search_club_card_list_widget.dart';
import '../widget/search/search_club_card_widget.dart';
import '../widget/search/search_field_widget.dart';
import 'club/club_screen.dart';

class SearchClubScreen extends StatefulWidget {
  const SearchClubScreen({Key? key}) : super(key: key);

  @override
  _SearchClubScreenState createState() => _SearchClubScreenState();
}

class _SearchClubScreenState extends State<SearchClubScreen> {
  String searchQuery = '';
  List<String> selectedTags = [];
  List<SearchClub> clubs = []; // 동아리 데이터 리스트
  final allTags = ['스터디', '운동', '음악', '봉사', '취미', '드럼', '농구', '요리'];

  @override
  void initState() {
    super.initState();
    // TODO:JSON 데이터로부터 동아리 정보를 초기화합니다 (여기서는 더미 데이터로 가정)
    clubs = SearchClubRepository.getDummyClubs();
  }

  void sendSearchRequest() async {
    print('searchQuery: $searchQuery');
    print('selectedTags: $selectedTags');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFFFF),
      appBar: AppBar(
        title: const Text(
          'JJoin',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
        surfaceTintColor: Colors.white,
        backgroundColor: Colors.white,
        automaticallyImplyLeading: true,
        leadingWidth: 90,
      ),
      body: Column(
        children: [
          SearchFieldWidget(
            onQueryChanged: (value) => setState(() => searchQuery = value),
            onSearchPressed: sendSearchRequest,
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Wrap(
                    spacing: 8.0,
                    runSpacing: 8.0,
                    children: allTags
                        .map((tag) => FilterChip(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              side: BorderSide(
                                  color: Colors.grey.withOpacity(0.05),
                                  width: 0),
                              showCheckmark: false,
                              label: Text(
                                tag,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              selected: selectedTags.contains(tag),
                              selectedColor:
                                  Colors.blue.shade100.withOpacity(0.8),
                              backgroundColor: Colors.grey.withOpacity(0.2),
                              onSelected: (bool selected) {
                                setState(() {
                                  if (selected) {
                                    selectedTags.add(tag);
                                  } else {
                                    selectedTags.remove(tag);
                                  }
                                });
                              },
                            ))
                        .toList(),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.refresh_outlined),
                  onPressed: () {
                    setState(() {
                      selectedTags.clear();
                    });
                  },
                ),
              ],
            ),
          ),
          // 동아리 카드 리스트 표시
          Expanded(child: ClubCardListWidget(clubs: clubs)),
        ],
      ),
    );
  }
}
