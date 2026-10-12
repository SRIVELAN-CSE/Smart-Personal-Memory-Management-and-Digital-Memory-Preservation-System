import 'package:flutter/material.dart';

/// Horizontally-scrollable suggested-question chips shown below the input box.
class SuggestedChips extends StatelessWidget {
  const SuggestedChips({super.key, required this.onSelected});

  final void Function(String query) onSelected;

  static const _suggestions = [
    'Show important memories',
    'Which memories have high rediscovery risk?',
    'Show memories from last year',
    'Who attended my events?',
    'Add a story to a memory',
    'Remind me about an event',
    'Explain preservation score',
    'Help',
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        itemCount: _suggestions.length,
        separatorBuilder: (_, __) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          return ActionChip(
            label: Text(
              _suggestions[index],
              style: Theme.of(context).textTheme.labelMedium,
            ),
            onPressed: () => onSelected(_suggestions[index]),
            padding: const EdgeInsets.symmetric(horizontal: 4),
          );
        },
      ),
    );
  }
}
