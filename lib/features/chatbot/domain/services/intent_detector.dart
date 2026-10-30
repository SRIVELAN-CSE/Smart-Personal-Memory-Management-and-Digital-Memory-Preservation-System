import '../entities/chat_message.dart';
import 'entity_extractor.dart';

class IntentDetector {
  const IntentDetector();
  ChatIntent detect(String query) {
    final q = query.toLowerCase();
    if (RegExp(r'^(hi|hello|help)[!.?]*$').hasMatch(q.trim())) {
      return ChatIntent.help;
    }
    if (q.contains('explain') || q.startsWith('why')) {
      if (q.contains('rediscovery')) return ChatIntent.explainRediscovery;
      if (q.contains('significance')) return ChatIntent.explainSignificance;
      return ChatIntent.explainPreservation;
    }
    if (q.contains('favourite') || q.contains('favorite')) {
      return ChatIntent.searchFavourite;
    }
    if (q.contains('important')) return ChatIntent.searchImportant;
    if (q.contains('high') && q.contains('risk')) {
      return ChatIntent.searchHighRisk;
    }
    if (q.contains('rated')) return ChatIntent.searchHighlyRated;
    if ((q.contains('missing') ||
            q.contains('without') ||
            q.contains('no story')) &&
        (q.contains('story') || q.contains('stories'))) {
      return ChatIntent.searchMissingStory;
    }
    if (q.contains('voice')) return ChatIntent.searchVoiceNotes;
    if (q.startsWith('open ')) return ChatIntent.openEvent;
    if (q.contains('add a story') || q.contains('write a story')) {
      return ChatIntent.startStory;
    }
    if (q.contains('remind')) return ChatIntent.createReminder;
    if (q.contains('recent')) return ChatIntent.searchRecent;
    if (RegExp(r'\b(with|who|people|attended)\b').hasMatch(q)) {
      return ChatIntent.searchByPerson;
    }
    if (RegExp(r'\b(at|location|place|city|where)\b').hasMatch(q)) {
      return ChatIntent.searchByPlace;
    }
    if (const EntityExtractor().extractDateRange(q) != null) {
      return ChatIntent.searchByDate;
    }
    return ChatIntent.searchByTitle;
  }
}
