import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../model/application/application_form.dart';

class ApplicationTopBar extends StatelessWidget {
  final ApplicationForm applicationForm;

  const ApplicationTopBar({
    super.key,
    required this.applicationForm,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 0,
              blurRadius: 5.0,
              offset: Offset(0, 1), // changes position of shadow
            ),
          ],
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(
            color: Colors.grey.shade300,
            width: 1.0,
          ),
        ),
        margin: const EdgeInsets.symmetric(horizontal: 2.0, vertical: 6.0),
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                applicationForm.clubName,
                style: const TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                '이름, 학번, 학과의 정보는 회원가입 시에 입력한 정보로 자동 제출됩니다.\n수집된 정보는 관리자 외에는 열람이 불가능 하며 가입 외에 다른 용도로 사용되지 않습니다.',
                style: TextStyle(fontSize: 15.0),
                textAlign: TextAlign.start,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
