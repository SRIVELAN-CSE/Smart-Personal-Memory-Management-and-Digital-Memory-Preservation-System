import '../entities/chat_message.dart';

class IntentDetector {
  const IntentDetector();
  ChatIntent detect(String query) {
    final q = query.toLowerCase();
    if (RegExp(r'^(help|hello|hi|what can you do)[?!. ]*$').hasMatch(q)) {
      return ChatIntent.help;
    }
    if (q.contains('favourite') || q.contains('favorite')) {
      return ChatIntent.searchFavourite;
    }
    if (q.contains('highly rated')) return ChatIntent.searchHighlyRated;
    if (q.contains('missing') && q.contains('story')) {
      return ChatIntent.searchMissingStory;
    }
    if (q.contains('voice')) return ChatIntent.searchVoiceNotes;
    if (q.contains('explain') || q.startsWith('why')) {
      if (q.contains('significance')) return ChatIntent.explainSignificance;
      if (q.contains('risk') || q.contains('rediscovery')) {
        return ChatIntent.explainRediscovery;
      }
      if (q.contains('preservation')) return ChatIntent.explainPreservation;
      return ChatIntent.explainRecommendation;
    }
    if (q.contains('high risk') ||
        q.contains('high-risk') ||
        q.contains('high rediscovery risk')) {
      return ChatIntent.searchHighRisk;
    }
    if (q.contains('important')) return ChatIntent.searchImportant;
    if (q.contains('recent') || q.contains('latest')) {
      return ChatIntent.searchRecent;
    }
    if (q.startsWith('open ')) return ChatIntent.openEvent;
    if (q.contains('story') && (q.contains('add') || q.contains('write'))) {
      return ChatIntent.startStory;
    }
    if (q.contains('remind')) return ChatIntent.createReminder;
    return ChatIntent.searchByTitle;
  }
}
