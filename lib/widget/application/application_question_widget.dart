import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ApplicationQuestion extends StatelessWidget {
  final String questionText;
  final TextEditingController controller;
  final Function(String) onAnswerChanged;

  const ApplicationQuestion({
    Key? key,
    required this.questionText,
    required this.controller,
    required this.onAnswerChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 20.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(
            color: Colors.grey.shade300,
            width: 1.0,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  left: 16,
                  right: 16,
                  top: 16,
                  bottom: 8,
                ),
                child: Text(questionText, style: const TextStyle(fontSize: 18)),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: controller,
                  onChanged: onAnswerChanged,
                  minLines: 1,
                  maxLines: 5,
                  decoration: const InputDecoration(
                    hintText: '내 답변',
                    contentPadding: EdgeInsets.symmetric(
                      vertical: 8.0,
                      horizontal: 8,
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.grey,
                        width: 1,
                      ),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.green,
                        width: 1,
                      ),
                    ),
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
