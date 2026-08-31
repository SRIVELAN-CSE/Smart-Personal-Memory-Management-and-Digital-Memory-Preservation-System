import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'memory_controller.dart';

class AddStoryScreen extends ConsumerStatefulWidget {
  const AddStoryScreen({required this.eventId, super.key});

  final String eventId;

  @override
  ConsumerState<AddStoryScreen> createState() => _AddStoryScreenState();
}

class _AddStoryScreenState extends ConsumerState<AddStoryScreen> {
  TextEditingController? _controller;

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final event = ref
        .watch(memoryControllerProvider)
        .events
        .where((item) => item.id == widget.eventId)
        .firstOrNull;
    if (event == null) {
      return Scaffold(
        appBar: AppBar(),
        body: const Center(child: Text('Event not found')),
      );
    }
    _controller ??= TextEditingController(text: event.story ?? '');
    return Scaffold(
      appBar: AppBar(title: const Text('Add your story')),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Text(
            event.title,
            style: Theme.of(
              context,
            ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w800),
          ),
          const SizedBox(height: 8),
          const Text(
            'What happened? Why does it matter to you? This stays in local derived app data.',
          ),
          const SizedBox(height: 20),
          TextField(
            controller: _controller,
            minLines: 8,
            maxLines: 14,
            maxLength: 2000,
            textCapitalization: TextCapitalization.sentences,
            decoration: const InputDecoration(
              hintText: 'I remember…',
              alignLabelWithHint: true,
            ),
          ),
          const SizedBox(height: 16),
          FilledButton.icon(
            onPressed: () {
              ref
                  .read(memoryControllerProvider.notifier)
                  .saveStory(event.id, _controller!.text);
              context.pop();
            },
            icon: const Icon(Icons.save_outlined),
            label: const Text('Save personal story'),
          ),
          const SizedBox(height: 12),
          Text(
            'No generative AI service receives this text. Timeline templates are generated locally and remain editable.',
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ],
      ),
    );
  }
}
