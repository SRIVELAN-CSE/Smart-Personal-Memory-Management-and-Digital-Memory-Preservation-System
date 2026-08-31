import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../event_management/presentation/memory_controller.dart';

class PeopleTaggingScreen extends ConsumerStatefulWidget {
  const PeopleTaggingScreen({required this.eventId, super.key});

  final String eventId;

  @override
  ConsumerState<PeopleTaggingScreen> createState() =>
      _PeopleTaggingScreenState();
}

class _PeopleTaggingScreenState extends ConsumerState<PeopleTaggingScreen> {
  final _nameController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
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
    return Scaffold(
      appBar: AppBar(title: const Text('People tags')),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Text(
            'Who was there?',
            style: Theme.of(
              context,
            ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w800),
          ),
          const SizedBox(height: 8),
          const Text(
            'Names are stored only after you confirm them. Smart Memory does not read contacts or automatically assign identities.',
          ),
          const SizedBox(height: 20),
          TextField(
            controller: _nameController,
            textCapitalization: TextCapitalization.words,
            decoration: InputDecoration(
              labelText: 'Person name',
              prefixIcon: const Icon(Icons.person_add_alt),
              suffixIcon: IconButton(
                onPressed: () {
                  ref
                      .read(memoryControllerProvider.notifier)
                      .addPerson(event.id, _nameController.text);
                  _nameController.clear();
                },
                icon: const Icon(Icons.add_circle),
              ),
            ),
            onSubmitted: (value) {
              ref
                  .read(memoryControllerProvider.notifier)
                  .addPerson(event.id, value);
              _nameController.clear();
            },
          ),
          const SizedBox(height: 22),
          if (event.people.isEmpty)
            const Card(
              child: Padding(
                padding: EdgeInsets.all(20),
                child: Text('No confirmed people yet.'),
              ),
            )
          else
            ...event.people.map(
              (person) => Card(
                child: ListTile(
                  leading: CircleAvatar(
                    child: Text(person.name.characters.first.toUpperCase()),
                  ),
                  title: Text(person.name),
                  subtitle: const Text('Confirmed manual tag'),
                  trailing: IconButton(
                    tooltip: 'Remove tag',
                    onPressed: () => ref
                        .read(memoryControllerProvider.notifier)
                        .removePerson(event.id, person.id),
                    icon: const Icon(Icons.close),
                  ),
                ),
              ),
            ),
          const SizedBox(height: 20),
          const ListTile(
            leading: Icon(Icons.face_retouching_off),
            title: Text('Automatic identity recognition is not included'),
            subtitle: Text(
              'A replaceable face-suggestion interface is future work; identities always require confirmation.',
            ),
          ),
        ],
      ),
    );
  }
}
