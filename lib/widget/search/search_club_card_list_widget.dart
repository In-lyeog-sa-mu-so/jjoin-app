import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../model/search/search_club.dart';
import 'search_club_card_widget.dart';

class ClubCardListWidget extends StatelessWidget {
  final List<SearchClub> clubs;

  const ClubCardListWidget({
    Key? key,
    required this.clubs,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: clubs.length,
      itemBuilder: (context, index) {
        final club = clubs[index];
        return InkWell(
          onTap: () {
            Get.toNamed('/clubs/', arguments: club.clubId);
          },
          child: ClubCard(club: club),
        );
      },
    );
  }
}
