import 'package:flutter/material.dart';

class TagFilterChipWidget extends StatelessWidget {
  final List<String> allTags;
  final List<String> selectedTags;
  final ValueChanged<String> onTagSelected;

  const TagFilterChipWidget({
    Key? key,
    required this.allTags,
    required this.selectedTags,
    required this.onTagSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8.0,
      runSpacing: 8.0,
      children: allTags
          .map((tag) => FilterChip(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                side:
                    BorderSide(color: Colors.grey.withOpacity(0.05), width: 0),
                showCheckmark: false,
                label: Text(tag,
                    style: const TextStyle(fontWeight: FontWeight.w400)),
                selected: selectedTags.contains(tag),
                selectedColor: Colors.blue.shade100.withOpacity(0.7),
                backgroundColor: Colors.grey.withOpacity(0.1),
                onSelected: (bool selected) {
                  onTagSelected(tag);
                },
              ))
          .toList(),
    );
  }
}
