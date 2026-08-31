import 'package:flutter/material.dart';

class AboutMethodologyScreen extends StatelessWidget {
  const AboutMethodologyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('About & methodology')),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Icon(
            Icons.auto_awesome_mosaic,
            size: 72,
            color: Theme.of(context).colorScheme.primary,
          ),
          const SizedBox(height: 12),
          Text(
            'Smart Memory',
            textAlign: TextAlign.center,
            style: Theme.of(
              context,
            ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w900),
          ),
          const SizedBox(height: 4),
          const Text(
            'Smart Personal Memory Management and Digital Memory Preservation System',
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 26),
          const _MethodCard(
            icon: Icons.account_tree_outlined,
            title: 'Event grouping',
            body:
                'Media is ordered by capture time. A deterministic score combines time (0.50), nearby embedded location (0.20), OCR token overlap (0.20), and optional compatible visual embeddings (0.10). Missing signals are renormalized rather than treated as negative evidence.',
          ),
          const _MethodCard(
            icon: Icons.star_outline,
            title: 'Application-level significance',
            body:
                'A normalized weighted estimate uses manual rating, favourite status, revisits, confirmed people, added context, and user corrections. It does not read or claim to infer emotion.',
          ),
          const _MethodCard(
            icon: Icons.history,
            title: 'Rediscovery risk',
            body:
                'An app-usage estimate considers time since last view, view count, event age, prior reminders, and dismissals. It describes the chance that a record remains unopened inside this application—not biological forgetting.',
          ),
          const _MethodCard(
            icon: Icons.health_and_safety_outlined,
            title: 'Preservation decision',
            body:
                'Need = significance × rediscovery risk × (1 − context completeness) × (1 − sensitivity). User-controlled sensitivity is a safety gate that suppresses proactive surfaces.',
          ),
          const _MethodCard(
            icon: Icons.science_outlined,
            title: 'Research integrity',
            body:
                'Demo values and thresholds are illustrative and not experimentally validated. Automatic photo grouping is preprocessing; the project contribution is proactive, explainable preservation of personal context.',
          ),
          const SizedBox(height: 16),
          Text(
            'Version 1.0.0 • Offline-first MVP',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ],
      ),
    );
  }
}

class _MethodCard extends StatelessWidget {
  const _MethodCard({
    required this.icon,
    required this.title,
    required this.body,
  });

  final IconData icon;
  final String title;
  final String body;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: Theme.of(context).colorScheme.primary),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 7),
                  Text(body, style: const TextStyle(height: 1.45)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
