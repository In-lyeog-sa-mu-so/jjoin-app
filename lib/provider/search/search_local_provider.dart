import 'package:get/get.dart';

import '../../model/base/e_club_part.dart';
import '../../model/search/search_club.dart';
import '../../model/search/search_tag.dart';

class SearchLocalProvider extends GetConnect {
  List<Tag> getDummyTags() {
    List<Tag> tags = [
      Tag(
        tagId: 1,
        tagName: "개발",
      ),
      Tag(
        tagId: 2,
        tagName: "학술",
      ),
      Tag(
        tagId: 3,
        tagName: "밴드",
      ),
      Tag(
        tagId: 4,
        tagName: "음악",
      ),
      Tag(
        tagId: 5,
        tagName: "봉사",
      ),
      Tag(
        tagId: 6,
        tagName: "취미",
      ),
      Tag(
        tagId: 7,
        tagName: "종교",
      ),
      Tag(
        tagId: 8,
        tagName: "스포츠",
      ),
      Tag(
        tagId: 9,
        tagName: "연합",
      ),
    ];
    return tags;
  }

  List<SearchClub> getDummyClubs() {
    List<SearchClub> searchClubs = [
      SearchClub(
        clubId: 1,
        clubName: "음샘",
        introduction: "밴드 음악을 하고 있는 중앙동아리 음샘입니다.",
        userNumber: 20,
        part: EClubPart.CENTRAL,
        profileImageUuid: "", // 실제 이미지 경로나 Base64 인코딩된 데이터로 가정
        isFinished: false,
        startDate: DateTime.parse("2023-08-01"),
        endDate: DateTime.parse("2023-08-31"),
      ),
      SearchClub(
        clubId: 2,
        clubName: "세미콜론",
        introduction: "동국대학교 컴공 학생회의 축구 소모임 세미콜론입니다ㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁ",
        userNumber: 30,
        part: EClubPart.DEPARTMENT,
        profileImageUuid: "", // 실제 이미지 경로나 Base64 인코딩된 데이터로 가정
        isFinished: true,
        startDate: DateTime.parse("2023-11-01"),
        endDate: DateTime.parse("2023-11-30"),
      ),
      SearchClub(
        clubId: 3,
        clubName: "GDSC",
        introduction: "동국대학교 구글 개발자 학생 동아리 GDSC입니다.",
        userNumber: 30,
        part: EClubPart.UNION,
        profileImageUuid: "", // 실제 이미지 경로나 Base64 인코딩된 데이터로 가정
        isFinished: true,
        startDate: DateTime.parse("2023-11-01"),
        endDate: DateTime.parse("2023-11-30"),
      ),
      SearchClub(
        clubId: 4,
        clubName: "멋쟁이 사자처럼",
        introduction: "동국대학교 개발 연합 동아리 멋사 .",
        userNumber: 30,
        part: EClubPart.UNION,
        profileImageUuid: "", // 실제 이미지 경로나 Base64 인코딩된 데이터로 가정
        isFinished: true,
        startDate: DateTime.parse("2023-11-01"),
        endDate: DateTime.parse("2023-11-30"),
      ),
    ];

    return searchClubs;
  }
}
