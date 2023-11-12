import 'package:flutter/material.dart';

class SearchFieldWidget extends StatelessWidget {
  final ValueChanged<String> onQueryChanged;
  final VoidCallback onSearchPressed;

  const SearchFieldWidget({
    Key? key,
    required this.onQueryChanged,
    required this.onSearchPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(
                right: 6.0, left: 20.0, top: 8.0, bottom: 8.0),
            child: SizedBox(
              height: 50,
              child: TextField(
                onChanged: onQueryChanged,
                onSubmitted: (value) => onSearchPressed(),
                decoration: const InputDecoration(
                  labelText: '검색',
                  labelStyle: TextStyle(fontSize: 18.0),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.grey,
                      width: 0.1,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        IconButton(
          icon: const Icon(
            Icons.search,
            size: 30.0,
          ),
          onPressed: onSearchPressed,
        ),
      ],
    );
  }
}
