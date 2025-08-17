import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_ruby_text/src/parser/ruby_text_bracket_parser.dart';

void main() {
  group('RubyTextBracketParser', () {
    late RubyTextBracketParser parser;

    setUp(() {
      parser = const RubyTextBracketParser();
    });

    test('should parse single character with ruby', () {
      final result = parser.parse('漢[かん]');
      expect(result.isNotEmpty, isTrue);

      // Find the part with ruby annotation
      final rubyPart = result.firstWhere((part) => part.ruby != null);
      expect(rubyPart.text, equals('漢'));
      expect(rubyPart.ruby, equals('かん'));
    });

    test('should parse grouped text with ruby', () {
      final result = parser.parse('(漢字)[かんじ]');
      expect(result.isNotEmpty, isTrue);

      // Find the part with ruby annotation
      final rubyPart = result.firstWhere((part) => part.ruby != null);
      expect(rubyPart.text, equals('漢字'));
      expect(rubyPart.ruby, equals('かんじ'));
    });

    test('should parse mixed formats', () {
      final result = parser.parse('漢[かん](字学)[じがく]');
      expect(result.isNotEmpty, isTrue);

      // Find the parts with ruby annotations
      final rubyParts = result.where((part) => part.ruby != null).toList();
      expect(rubyParts.length, equals(2));
    });

    test('should handle plain text', () {
      final result = parser.parse('Hello world');
      expect(result.isNotEmpty, isTrue);

      // Join all text parts to get the full text
      final fullText = result.map((part) => part.text).join('');
      expect(fullText, equals('Hello world'));

      // Ensure no parts have ruby annotations
      expect(result.every((part) => part.ruby == null), isTrue);
    });

    test('should handle empty input', () {
      final result = parser.parse('');
      expect(result, isEmpty);
    });
  });
}
