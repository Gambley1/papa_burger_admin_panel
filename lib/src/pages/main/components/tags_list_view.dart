import 'package:flutter/material.dart';
import 'package:papa_burger_admin_panel/src/config/constants/radius.dart';
import 'package:papa_burger_admin_panel/src/models/restaurant/restaurant.dart';
import 'package:papa_burger_admin_panel/src/widgets/k_text.dart';

class TagsListView extends StatelessWidget {
  const TagsListView({
    required this.tags,
    required this.onDeleted,
    super.key,
  });

  final List<Tag> tags;
  final ValueSetter<Tag> onDeleted;

  @override
  Widget build(BuildContext context) {
    if (tags.isEmpty) {
      return const EmptyList();
    }
    return SizedBox(
      height: 36,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final tag = tags[index];
          final name = tag.name;
          return Chip(
            label: KText(
              name,
              color: Colors.black,
              fontWeight: FontWeight.bold,
              size: 18,
            ),
            backgroundColor: Colors.blue,
            padding: const EdgeInsets.only(bottom: 4, right: 4),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(defaultBorderRadius),
            ),
            deleteIcon: const Icon(
              Icons.cancel,
            ),
            onDeleted: () => onDeleted(tag),
          );
        },
        itemCount: tags.length,
      ),
    );
  }
}

class EmptyList extends StatelessWidget {
  const EmptyList({super.key});

  @override
  Widget build(BuildContext context) {
    return const SizedBox.shrink();
  }
}
