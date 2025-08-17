import 'package:flutter_ruby_text/flutter_ruby_text.dart';

/// A parser for bracket-style ruby text annotations.
///
/// This parser supports two annotation formats:
///
/// **Single character format:** `char[ruby]`
/// - Example: `煮[zhǔ]豆[dòu]持[chí]`
/// - Each character is followed by its ruby annotation in square brackets
///
/// **Grouped format:** `(base)[ruby]`
/// - Example: `(九州)[きゅうしゅう]`
/// - Multiple characters are grouped in parentheses with a single ruby annotation
///
/// Both formats can be mixed in the same input string. Plain text without
/// annotations is also supported.
///
/// Example usage:
/// ```dart
/// const parser = RubyTextBracketParser();
/// final words = parser.parse('Hello (世界)[せかい]!');
/// ```
class RubyTextBracketParser implements RubyTextParser {
  /// Creates a bracket-style ruby text parser.
  const RubyTextBracketParser();

  /// Parses the input string and returns a list of [RubyTextWord] objects.
  ///
  /// The parser recognizes:
  /// - `(base)[ruby]` - grouped format for multiple characters
  /// - `char[ruby]` - single character format
  /// - Plain text without annotations
  ///
  /// Example:
  /// ```dart
  /// parse('Hello (世界)[せかい]!')
  /// // Returns:
  /// // [
  /// //   RubyTextWord('H'),
  /// //   RubyTextWord('e'),
  /// //   RubyTextWord('l'),
  /// //   RubyTextWord('l'),
  /// //   RubyTextWord('o'),
  /// //   RubyTextWord(' '),
  /// //   RubyTextWord('世界', ruby: 'せかい'),
  /// //   RubyTextWord('!'),
  /// // ]
  /// ```
  @override
  List<RubyTextWord> parse(String input) {
    // Parses ruby annotation in two formats:
    // 1. (base)[ruby]: Parentheses group multiple base characters, brackets provide ruby text.
    //    Example: (九州)[きゅうしゅう]
    // 2. char[ruby]: Single character followed by brackets for ruby text.
    //    Example: 煮[zhǔ]
    // Both formats can be mixed and used in any language. Plain text and punctuation are also supported.
    final regex = RegExp(
      r'\(([^\)]+)\)\[([^\]]+)\]|(.)\[([^\]]+)\]|(.)',
      multiLine: true,
    );
    final result = <RubyTextWord>[];
    for (final match in regex.allMatches(input)) {
      if (match.group(1) != null && match.group(2) != null) {
        // (base)[ruby] format
        result.add(RubyTextWord(match.group(1)!, ruby: match.group(2)));
      } else if (match.group(3) != null && match.group(4) != null) {
        // char[ruby] format
        result.add(RubyTextWord(match.group(3)!, ruby: match.group(4)));
      } else if (match.group(5) != null) {
        // Plain character
        result.add(RubyTextWord(match.group(5)!));
      }
    }
    return result;
  }
}
