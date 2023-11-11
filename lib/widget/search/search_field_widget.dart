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
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              onChanged: onQueryChanged,
              onSubmitted: (value) => onSearchPressed(),
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
          onPressed: onSearchPressed,
        ),
      ],
    );
  }
}
