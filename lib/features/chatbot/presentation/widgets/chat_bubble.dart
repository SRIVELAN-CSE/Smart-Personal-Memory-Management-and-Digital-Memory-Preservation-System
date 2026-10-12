import 'package:flutter/material.dart';

/// A single chat bubble — user messages appear on the right, assistant on left.
class ChatBubble extends StatelessWidget {
  const ChatBubble({
    super.key,
    required this.text,
    required this.isUser,
    required this.timestamp,
  });

  final String text;
  final bool isUser;
  final DateTime timestamp;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final bgColor = isUser
        ? scheme.primaryContainer
        : scheme.surfaceContainerHighest;
    final textColor = isUser
        ? scheme.onPrimaryContainer
        : scheme.onSurfaceVariant;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: isUser
            ? MainAxisAlignment.end
            : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          if (!isUser) ...[
            CircleAvatar(
              radius: 14,
              backgroundColor: scheme.primary,
              child: Icon(Icons.smart_toy, size: 14, color: scheme.onPrimary),
            ),
            const SizedBox(width: 8),
          ],
          Flexible(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
              decoration: BoxDecoration(
                color: bgColor,
                borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(18),
                  topRight: const Radius.circular(18),
                  bottomLeft: Radius.circular(isUser ? 18 : 4),
                  bottomRight: Radius.circular(isUser ? 4 : 18),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _MarkdownText(text: text, color: textColor),
                  const SizedBox(height: 4),
                  Text(
                    _formatTime(timestamp),
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                      color: textColor.withValues(alpha: 0.6),
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (isUser) const SizedBox(width: 8),
        ],
      ),
    );
  }

  String _formatTime(DateTime dt) {
    final h = dt.hour.toString().padLeft(2, '0');
    final m = dt.minute.toString().padLeft(2, '0');
    return '$h:$m';
  }
}

/// Minimal **bold** and *italic* markdown renderer without external deps.
class _MarkdownText extends StatelessWidget {
  const _MarkdownText({required this.text, required this.color});

  final String text;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final style = Theme.of(
      context,
    ).textTheme.bodyMedium?.copyWith(color: color, height: 1.5);
    return _buildRichText(context, style);
  }

  Widget _buildRichText(BuildContext context, TextStyle? baseStyle) {
    final spans = <InlineSpan>[];
    final lines = text.split('\n');

    for (int i = 0; i < lines.length; i++) {
      if (i > 0) spans.add(const TextSpan(text: '\n'));
      spans.addAll(_parseInline(lines[i], baseStyle));
    }

    return RichText(text: TextSpan(children: spans));
  }

  List<InlineSpan> _parseInline(String line, TextStyle? base) {
    final result = <InlineSpan>[];
    // Match **bold** or *italic*
    final pattern = RegExp(r'\*\*(.+?)\*\*|\*(.+?)\*');
    int lastEnd = 0;
    for (final match in pattern.allMatches(line)) {
      if (match.start > lastEnd) {
        result.add(
          TextSpan(text: line.substring(lastEnd, match.start), style: base),
        );
      }
      final isBold = match.group(1) != null;
      final content = isBold ? match.group(1)! : match.group(2)!;
      result.add(
        TextSpan(
          text: content,
          style: base?.copyWith(
            fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
            fontStyle: isBold ? FontStyle.normal : FontStyle.italic,
          ),
        ),
      );
      lastEnd = match.end;
    }
    if (lastEnd < line.length) {
      result.add(TextSpan(text: line.substring(lastEnd), style: base));
    }
    return result;
  }
}

/// Typing indicator — three animated dots.
class TypingIndicator extends StatefulWidget {
  const TypingIndicator({super.key});

  @override
  State<TypingIndicator> createState() => _TypingIndicatorState();
}

class _TypingIndicatorState extends State<TypingIndicator>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          CircleAvatar(
            radius: 14,
            backgroundColor: scheme.primary,
            child: Icon(Icons.smart_toy, size: 14, color: scheme.onPrimary),
          ),
          const SizedBox(width: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: scheme.surfaceContainerHighest,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(18),
                topRight: Radius.circular(18),
                bottomRight: Radius.circular(18),
                bottomLeft: Radius.circular(4),
              ),
            ),
            child: AnimatedBuilder(
              animation: _controller,
              builder: (_, __) => Row(
                mainAxisSize: MainAxisSize.min,
                children: List.generate(3, (i) {
                  final opacity = ((_controller.value * 3 - i).clamp(0.0, 1.0));
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 2),
                    child: Opacity(
                      opacity: opacity < 0.3 ? 0.3 : opacity,
                      child: CircleAvatar(
                        radius: 4,
                        backgroundColor: scheme.onSurfaceVariant,
                      ),
                    ),
                  );
                }),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
