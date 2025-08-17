import '../ruby_text.dart';

/// Abstract base class for ruby text parsers.
///
/// Parsers are responsible for converting input strings into lists of
/// [RubyTextWord] objects that can be displayed by [RubyText].
///
/// Implement this interface to create custom parsers for different
/// annotation formats.
abstract class RubyTextParser {
  /// Parses an input string and returns a list of [RubyTextWord] objects.
  ///
  /// The [input] parameter is the string to parse.
  /// Returns a list of [RubyTextWord] objects representing the parsed content.
  List<RubyTextWord> parse(String input);
}
