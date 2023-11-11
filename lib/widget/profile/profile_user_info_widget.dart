import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../model/profile/profile_user.dart';

class ProfileUserInfo extends StatelessWidget {
  final User user;

  const ProfileUserInfo({
    Key? key,
    required this.user,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 0.5,
              blurRadius: 1,
              offset: Offset(0, 0),
            ),
          ],
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 60,
                    backgroundImage: AssetImage(user.profileImageUuid),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: Text(
                            user.name,
                            style: const TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 5),
                          child: Text('전공: ${user.major}',
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w300,
                              )),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 5),
                          child: Text('학번: ${user.studentId.toString()}',
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w300,
                              )),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Text(
              user.introduction,
              textAlign: TextAlign.left,
            ),
            const SizedBox(height: 20)
          ],
        ),
      ),
    );
  }
}
