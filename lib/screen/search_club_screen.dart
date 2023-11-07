import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../repository/SearchClub/search_club_repository.dart';

import '../model/SearchClub/search_club.dart';
import 'detail_club_screen.dart';

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
      appBar: AppBar(
        title: const Text('동아리 검색'),
      ),
      body: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    onChanged: (value) => searchQuery = value,
                    onSubmitted: (value) {
                      // 사용자가 키보드에서 '검색'을 눌렀을 때 검색 실행
                      sendSearchRequest();
                    },
                    decoration: const InputDecoration(
                      labelText: '검색',
                      labelStyle: TextStyle(fontSize: 18.0),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(),
                      ),
                    ),
                  ),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.search),
                onPressed: sendSearchRequest,
              ),
            ],
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
          Expanded(
            child: ListView.builder(
              itemCount: clubs.length,
              itemBuilder: (context, index) {
                final club = clubs[index];
                return InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            DetailClubScreen(clubId: club.clubId),
                      ),
                    );
                  },
                  child: ClubCard(club: club),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class ClubCard extends StatelessWidget {
  const ClubCard({
    super.key,
    required this.club,
  });

  final SearchClub club;

  @override
  Widget build(BuildContext context) {
    final bool isRecruiting = club.isFinished;
    String recruitingText = isRecruiting
        ? '모집 중 (${DateFormat('MM.dd').format(club.startDate)}~${DateFormat('MM.dd').format(club.endDate)})'
        : '모집 마감';

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      decoration: BoxDecoration(
        border: Border(
          left: BorderSide(
            color: isRecruiting ? Colors.green.shade300 : Colors.red.shade300,
            width: 8,
          ),
        ),
      ),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                club.clubName,
                style: const TextStyle(
                    fontSize: 20.0, fontWeight: FontWeight.bold),
              ),
              const Divider(), // clubName과 아래 행을 구분하는 줄
              const SizedBox(height: 10),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  // 이미지 표시 부분 (임시로 placeholder 이미지 사용)
                  Image.network(
                      club.profileImageUuid.isNotEmpty
                          ? club.profileImageUuid
                          : 'assets/images/dgu_image.png',
                      height: 80,
                      width: 80),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          club.dependent ?? '',
                          style: const TextStyle(fontSize: 16.0),
                        ),
                        Text(
                          recruitingText,
                          style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                            color: isRecruiting ? Colors.green : Colors.red,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Text(
                club.introduction,
                style: const TextStyle(fontSize: 16.0),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
