import 'package:flutter/material.dart';

import 'package:flutter_ruby_text/src/util/iterable_extension.dart';

import 'parser/ruby_text_parser.dart';

/// A word with optional ruby annotation.
///
/// This class represents a single word or character with an optional ruby text
/// annotation above it. Ruby text is commonly used for phonetic annotations
/// like Chinese pinyin or Japanese furigana.
class RubyTextWord {
  /// Creates a ruby text word.
  ///
  /// The [text] parameter is the base text to display.
  /// The [ruby] parameter is the optional annotation text displayed above the base text.
  /// The [style] parameter overrides the base text style for this word.
  /// The [rubyStyle] parameter overrides the ruby text style for this word.
  const RubyTextWord(this.text, {this.ruby, this.style, this.rubyStyle});

  /// The base text content.
  final String text;

  /// The ruby annotation text displayed above the base text.
  ///
  /// If null, no ruby text will be displayed for this word.
  final String? ruby;

  /// The text style for the base text.
  ///
  /// If null, the style from [RubyText.style] will be used.
  final TextStyle? style;

  /// The text style for the ruby text.
  ///
  /// If null, the style from [RubyText.rubyStyle] will be used.
  final TextStyle? rubyStyle;
}

/// A widget that displays text with ruby annotations.
///
/// Ruby text is commonly used in East Asian typography to show pronunciation
/// or meaning of characters. This widget supports displaying base text with
/// smaller annotation text positioned above it.
///
/// Example usage:
/// ```dart
/// RubyText([
///   RubyTextWord('漢', ruby: 'hàn'),
///   RubyTextWord('字', ruby: 'zì'),
/// ])
/// ```
class RubyText extends StatelessWidget {
  /// Creates a ruby text widget from a list of words.
  ///
  /// The [words] parameter contains the list of [RubyTextWord] objects to display.
  /// The [spacing] parameter controls the horizontal spacing between words.
  /// The [style] parameter sets the default style for base text.
  /// The [rubyStyle] parameter sets the default style for ruby text.
  /// The [autoLetterSpacing] parameter enables automatic letter spacing adjustment.
  const RubyText(
    this.words, {
    super.key,
    this.spacing = _defaultSpacing,
    this.style,
    this.rubyStyle,
    this.textDirection,
    this.softWrap,
    this.overflow,
    this.maxLines,
    this.rubySoftWrap,
    this.rubyOverflow,
    this.rubyMaxLines,
    this.wordWidth,
    this.autoLetterSpacing = _defaultAutoLetterSpacing,
  });

  /// Creates a ruby text widget by parsing a string.
  ///
  /// The [data] parameter is the input string to parse.
  /// The [parser] parameter specifies how to parse the input string.
  ///
  /// Example:
  /// ```dart
  /// RubyText.parse(
  ///   '煮[zhǔ]豆[dòu]',
  ///   parser: const RubyTextBracketParser(),
  /// )
  /// ```
  RubyText.parse(
    String data, {
    super.key,
    required RubyTextParser parser,
    this.spacing = _defaultSpacing,
    this.style,
    this.rubyStyle,
    this.textDirection,
    this.softWrap,
    this.overflow,
    this.maxLines,
    this.rubySoftWrap,
    this.rubyOverflow,
    this.rubyMaxLines,
    this.wordWidth,
    this.autoLetterSpacing = _defaultAutoLetterSpacing,
  }) : words = parser.parse(data);

  /// The list of words with ruby annotations to display.
  final List<RubyTextWord> words;

  /// The horizontal spacing between each word.
  ///
  /// Defaults to 4.0.
  final double spacing;

  /// The default text style for base text.
  ///
  /// Individual words can override this with [RubyTextWord.style].
  final TextStyle? style;

  /// The default text style for ruby text.
  ///
  /// Individual words can override this with [RubyTextWord.rubyStyle].
  final TextStyle? rubyStyle;

  /// The text direction for the widget.
  ///
  /// If null, the ambient [Directionality] is used.
  final TextDirection? textDirection;

  /// Whether the base text should break at soft line breaks.
  ///
  /// This corresponds to [Text.softWrap].
  final bool? softWrap;

  /// How to handle base text that overflows its container.
  ///
  /// This corresponds to [Text.overflow].
  final TextOverflow? overflow;

  /// The maximum number of lines for base text.
  ///
  /// This corresponds to [Text.maxLines].
  final int? maxLines;

  /// Whether the ruby text should break at soft line breaks.
  final bool? rubySoftWrap;

  /// How to handle ruby text that overflows its container.
  final TextOverflow? rubyOverflow;

  /// The maximum number of lines for ruby text.
  final int? rubyMaxLines;

  /// Fixed width for each word.
  ///
  /// If provided, all words will have this fixed width regardless of their
  /// text content. This is useful for creating uniform spacing.
  /// If null, the width is determined by the text content.
  final double? wordWidth;

  /// Whether to automatically adjust letter spacing.
  ///
  /// When true, the widget will add letter spacing to align base text
  /// and ruby text when they have different widths.
  /// Defaults to false.
  final bool autoLetterSpacing;

  static const double _defaultSpacing = 4.0;
  static const bool _defaultAutoLetterSpacing = false;

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        children: words
            .map(
              (w) => WidgetSpan(
                child: _RubyTextSpanWidget(
                  w,
                  style: style,
                  rubyStyle: rubyStyle,
                  textDirection: textDirection,
                  rubySoftWrap: rubySoftWrap,
                  rubyOverflow: rubyOverflow,
                  rubyMaxLines: rubyMaxLines,
                  wordWidth: wordWidth,
                  autoLetterSpacing: autoLetterSpacing,
                ),
              ),
            )
            .separate(WidgetSpan(child: SizedBox(width: spacing)))
            .toList(),
      ),
      textDirection: textDirection,
      softWrap: softWrap,
      overflow: overflow,
      maxLines: maxLines,
    );
  }
}

class _RubyTextSpanWidget extends StatelessWidget {
  const _RubyTextSpanWidget(
    this.word, {
    required this.style,
    required this.rubyStyle,
    required this.textDirection,
    required this.rubySoftWrap,
    required this.rubyOverflow,
    required this.rubyMaxLines,
    required this.wordWidth,
    required this.autoLetterSpacing,
  });

  final RubyTextWord word;
  final TextStyle? style;
  final TextStyle? rubyStyle;
  final TextDirection? textDirection;
  final bool? rubySoftWrap;
  final TextOverflow? rubyOverflow;
  final int? rubyMaxLines;
  final double? wordWidth;
  final bool autoLetterSpacing;

  @override
  Widget build(BuildContext context) {
    final textDirection = this.textDirection ?? Directionality.maybeOf(context);
    var style = word.style ?? this.style ?? DefaultTextStyle.of(context).style;
    var rubyStyle =
        word.rubyStyle ?? this.rubyStyle ?? DefaultTextStyle.of(context).style;

    final Widget widget;
    final ruby = word.ruby ?? "";

    // Add Letter Spacing
    double textWidth = 0;
    double rubyWidth = 0;
    if (autoLetterSpacing && (word.text.length >= 2 || ruby.length >= 2)) {
      textWidth = _measureWidth(
        word.text,
        style: style,
        textDirection: textDirection,
      );
      rubyWidth = _measureWidth(
        ruby,
        style: rubyStyle,
        textDirection: textDirection,
      );

      if (textWidth > rubyWidth && ruby.length >= 2) {
        final letterSpacing = (textWidth - rubyWidth) / ruby.length;
        rubyStyle = rubyStyle.merge(TextStyle(letterSpacing: letterSpacing));
      } else if (textWidth < rubyWidth && word.text.length >= 2) {
        final letterSpacing = (rubyWidth - textWidth) / word.text.length;
        style = style.merge(TextStyle(letterSpacing: letterSpacing));
      }
    }

    widget = Column(
      children: [
        SizedBox(
          width: textWidth > rubyWidth ? textWidth : null,
          child: Text(
            ruby,
            style: rubyStyle,
            textAlign: TextAlign.center,
            textDirection: textDirection,
            softWrap: rubySoftWrap,
            overflow: rubyOverflow,
            maxLines: rubyMaxLines,
          ),
        ),
        SizedBox(
          width: rubyWidth > textWidth ? rubyWidth : null,
          child: Text(
            word.text,
            style: style,
            textDirection: textDirection,
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );

    if (wordWidth != null) {
      return SizedBox(width: wordWidth, child: widget);
    }

    return widget;
  }

  double _measureWidth(
    String text, {
    TextStyle? style,
    TextDirection? textDirection,
  }) {
    final textPainter = TextPainter(
      text: TextSpan(text: text, style: style),
      textDirection: textDirection,
      textAlign: TextAlign.center,
      maxLines: rubyMaxLines,
    );
    textPainter.layout();
    return textPainter.width;
  }
}
