import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../features/event_management/presentation/add_story_screen.dart';
import '../features/event_management/presentation/edit_event_screen.dart';
import '../features/event_management/presentation/event_detail_screen.dart';
import '../features/event_management/presentation/home_dashboard_screen.dart';
import '../features/event_management/presentation/voice_note_screen.dart';
import '../features/media_import/presentation/media_scan_screen.dart';
import '../features/memory_graph/presentation/memory_graph_screen.dart';
import '../features/onboarding/presentation/onboarding_screen.dart';
import '../features/onboarding/presentation/permission_screen.dart';
import '../features/onboarding/presentation/splash_screen.dart';
import '../features/people/presentation/people_tagging_screen.dart';
import '../features/privacy/presentation/privacy_screen.dart';
import '../features/recommendations/presentation/recommendation_detail_screen.dart';
import '../features/recommendations/presentation/recommendation_inbox_screen.dart';
import '../features/reminders/presentation/time_capsule_screen.dart';
import '../features/settings/presentation/about_methodology_screen.dart';
import '../features/settings/presentation/data_management_screen.dart';
import '../features/timeline/presentation/story_timeline_screen.dart';

final appRouterProvider = Provider<GoRouter>((ref) {
  final router = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(path: '/', builder: (context, state) => const SplashScreen()),
      GoRoute(
        path: '/onboarding',
        builder: (context, state) => const OnboardingScreen(),
      ),
      GoRoute(
        path: '/permissions',
        builder: (context, state) => const PermissionScreen(),
      ),
      GoRoute(
        path: '/home',
        builder: (context, state) => const HomeDashboardScreen(),
      ),
      GoRoute(
        path: '/scan',
        builder: (context, state) => const MediaScanScreen(),
      ),
      GoRoute(
        path: '/timeline',
        builder: (context, state) => const StoryTimelineScreen(),
      ),
      GoRoute(
        path: '/event/:id',
        builder: (context, state) =>
            EventDetailScreen(eventId: state.pathParameters['id']!),
        routes: [
          GoRoute(
            path: 'edit',
            builder: (context, state) =>
                EditEventScreen(eventId: state.pathParameters['id']!),
          ),
          GoRoute(
            path: 'people',
            builder: (context, state) =>
                PeopleTaggingScreen(eventId: state.pathParameters['id']!),
          ),
          GoRoute(
            path: 'story',
            builder: (context, state) =>
                AddStoryScreen(eventId: state.pathParameters['id']!),
          ),
          GoRoute(
            path: 'voice',
            builder: (context, state) =>
                VoiceNoteScreen(eventId: state.pathParameters['id']!),
          ),
        ],
      ),
      GoRoute(
        path: '/graph',
        builder: (context, state) => const MemoryGraphScreen(),
      ),
      GoRoute(
        path: '/recommendations',
        builder: (context, state) => const RecommendationInboxScreen(),
      ),
      GoRoute(
        path: '/recommendation/:id',
        builder: (context, state) => RecommendationDetailScreen(
          recommendationId: state.pathParameters['id']!,
        ),
        routes: [
          GoRoute(
            path: 'capsule',
            builder: (context, state) => TimeCapsuleScreen(
              recommendationId: state.pathParameters['id']!,
            ),
          ),
        ],
      ),
      GoRoute(
        path: '/privacy',
        builder: (context, state) => const PrivacyScreen(),
      ),
      GoRoute(
        path: '/data-management',
        builder: (context, state) => const DataManagementScreen(),
      ),
      GoRoute(
        path: '/about',
        builder: (context, state) => const AboutMethodologyScreen(),
      ),
    ],
    errorBuilder: (context, state) => Scaffold(
      appBar: AppBar(title: const Text('Page unavailable')),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.link_off, size: 56),
            const SizedBox(height: 12),
            Text(
              state.error?.toString() ?? 'The requested page was not found.',
            ),
            const SizedBox(height: 12),
            FilledButton(
              onPressed: () => context.go('/home'),
              child: const Text('Return home'),
            ),
          ],
        ),
      ),
    ),
  );
  ref.onDispose(router.dispose);
  return router;
});
