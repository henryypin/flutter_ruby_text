# Flutter Ruby Text

[![License](https://img.shields.io/badge/license-MIT-green.svg)](/LICENSE)
[![Platform Flutter](https://img.shields.io/badge/platform-Flutter-blue.svg)](https://flutter.dev)
[![Pub Version](https://img.shields.io/pub/v/flutter_ruby_text.svg)](https://pub.dev/packages/flutter_ruby_text)

A Flutter package for displaying ruby text annotations, supporting phonetic annotations like Chinese pinyin and Japanese furigana.

📱 **[Try the live demo](https://henryypin.github.io/flutter_ruby_text/)**

## Basic Usage

### Using RubyTextWord List

```dart
RubyText([
  const RubyTextWord('漢', ruby: 'hàn'),
  const RubyTextWord('字', ruby: 'zì'),
])
```

### Using Parser

```dart
RubyText.parse(
  '煮[zhǔ]豆[dòu]持[chí]作[zuò]羹[gēng]',
  parser: const RubyTextBracketParser(),
)
```

## Examples

### Chinese Pinyin

```dart
import 'package:flutter/material.dart';
import 'package:flutter_ruby_text/flutter_ruby_text.dart';

class ChineseExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: RubyText.parse(
          '七[qī]步[bù]詩[shī] - 煮[zhǔ]豆[dòu]持[chí]作[zuò]羹[gēng]，漉[lù]菽[shū]以[yǐ]為[wéi]汁[zhī]。',
          parser: const RubyTextBracketParser(),
          style: const TextStyle(
            fontSize: 20,
            color: Colors.black,
          ),
          rubyStyle: const TextStyle(
            fontSize: 12,
            color: Colors.blue,
          ),
        ),
      ),
    );
  }
}
```

### Japanese Furigana

```dart
import 'package:flutter/material.dart';
import 'package:flutter_ruby_text/flutter_ruby_text.dart';

class JapaneseExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: RubyText.parse(
          '(九州)[きゅうしゅう]などでは、(14日)[じゅうよっか]も(晴)[は]れて(暑)[あつ]くなりました。',
          parser: const RubyTextBracketParser(),
          style: const TextStyle(
            fontSize: 18,
            color: Colors.black,
          ),
          rubyStyle: const TextStyle(
            fontSize: 10,
            color: Colors.red,
          ),
        ),
      ),
    );
  }
}
```

## API Reference

### RubyText Properties

| Property | Type | Description |
|----------|------|-------------|
| `words` | `List<RubyTextWord>` | List of ruby text words to display |
| `spacing` | `double` | Horizontal spacing between words, defaults to 4.0 |
| `style` | `TextStyle?` | Default style for base text |
| `rubyStyle` | `TextStyle?` | Default style for ruby text |
| `textDirection` | `TextDirection?` | Text direction, uses ambient Directionality if null |
| `softWrap` | `bool?` | Whether base text should break at soft line breaks |
| `overflow` | `TextOverflow?` | How to handle base text overflow |
| `maxLines` | `int?` | Maximum lines for base text |
| `rubySoftWrap` | `bool?` | Whether ruby text should break at soft line breaks |
| `rubyOverflow` | `TextOverflow?` | How to handle ruby text overflow |
| `rubyMaxLines` | `int?` | Maximum lines for ruby text |
| `wordWidth` | `double?` | Fixed width for each word, null for automatic sizing |
| `autoLetterSpacing` | `bool` | Auto letter spacing adjustment, defaults to false |

### RubyTextWord Properties

| Property | Type | Description |
|----------|------|-------------|
| `text` | `String` | Base text content |
| `ruby` | `String?` | Ruby annotation text, null for no annotation |
| `style` | `TextStyle?` | Override style for this word's base text |
| `rubyStyle` | `TextStyle?` | Override style for this word's ruby text |

### RubyTextBracketParser

Parses bracket-style ruby text annotations with two formats:
- **Single character:** `char[ruby]` 
- **Grouped:** `(base)[ruby]`

```dart
const parser = RubyTextBracketParser();
final words = parser.parse('漢[hàn]字[zì]');
```

### Custom Parser

You can implement your own parser to support different annotation formats:

```dart
class CustomRubyTextParser implements RubyTextParser {
  @override
  List<RubyTextWord> parse(String input) {
    // Implement your parsing logic
    return [];
  }
}
```

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Changelog

See [CHANGELOG.md](CHANGELOG.md) for detailed version history.

## Support

If you encounter any issues or have feature requests, please file them in the [GitHub Issues](https://github.com/henryypin/flutter_ruby_text/issues).