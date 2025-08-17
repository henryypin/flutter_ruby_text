import 'package:flutter/material.dart';

import 'package:flutter_ruby_text/flutter_ruby_text.dart';

enum RubyTextDemoType {
  chinese,
  japanese;

  List<String> get data {
    switch (this) {
      case RubyTextDemoType.chinese:
        return [
          "七[qī]步[bù]詩[shī]",
          "煮[zhǔ]豆[dòu]持[chí]作[zuò]羹[gēng]，漉[lù]菽[shū]以[yǐ]為[wéi]汁[zhī]。",
          "萁[qí]在[zài]釜[fǔ]下[xià]燃[rán]，豆[dòu]在[zài]釜[fǔ]中[zhōng]泣[qì]。",
          "本[běn]是[shì]同[tóng]根[gēn]生[shēng]，相[xiāng]煎[jiān]何[hé]太[tài]急[jí]？",
        ];
      case RubyTextDemoType.japanese:
        return ["(九州)[きゅうしゅう]などでは、(14日)[じゅうよっか]も(晴)[は]れて(暑)[あつ]くなりました。"];
    }
  }

  RubyTextParser get parser {
    switch (this) {
      case RubyTextDemoType.chinese:
        return const RubyTextBracketParser();
      case RubyTextDemoType.japanese:
        return const RubyTextBracketParser();
    }
  }
}

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  RubyTextDemoType _demoType = RubyTextDemoType.chinese;
  double _textFontSize = 16;
  double _rubyFontSize = 12;
  bool _autoLetterSpacing = false;
  bool _rubySoftWrap = false;
  bool _useWordWidth = false;
  double _wordWidth = 16;

  @override
  Widget build(BuildContext context) {
    final style = TextStyle(fontSize: _textFontSize, color: Colors.black);
    final rubyStyle = TextStyle(fontSize: _rubyFontSize, color: Colors.grey);

    return MaterialApp(
      home: Scaffold(
        body: SafeArea(
          child: ListView(
            children: [
              ..._demoType.data.map(
                (data) => RubyText.parse(
                  data,
                  parser: _demoType.parser,
                  style: style,
                  rubyStyle: rubyStyle,
                  wordWidth: _useWordWidth ? _wordWidth : null,
                  rubySoftWrap: _rubySoftWrap,
                  rubyMaxLines: _rubySoftWrap ? null : 1,
                  rubyOverflow: _rubySoftWrap ? null : TextOverflow.ellipsis,
                  autoLetterSpacing: _autoLetterSpacing,
                ),
              ),
              const SizedBox(height: 20),
              _pannel(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _pannel() => Padding(
    padding: const EdgeInsets.all(8.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          spacing: 12,
          children: [
            const Text(
              "Demo Type:",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            DropdownButton<RubyTextDemoType>(
              value: _demoType,
              items: RubyTextDemoType.values.map((type) {
                return DropdownMenuItem(value: type, child: Text(type.name));
              }).toList(),
              onChanged: (value) {
                if (value != null) {
                  setState(() {
                    _demoType = value;
                  });
                }
              },
            ),
          ],
        ),
        Row(
          children: [
            const Text(
              "Text Font Size:",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Expanded(
              child: Slider(
                min: 10,
                max: 40,
                value: _textFontSize,
                label: _textFontSize.toStringAsFixed(0),
                onChanged: (value) {
                  setState(() {
                    _textFontSize = value;
                  });
                },
              ),
            ),
            Text(
              _textFontSize.toStringAsFixed(0),
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        Row(
          children: [
            const Text(
              "Ruby Font Size:",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Expanded(
              child: Slider(
                min: 10,
                max: 40,
                value: _rubyFontSize,
                label: _rubyFontSize.toStringAsFixed(0),
                onChanged: (value) {
                  setState(() {
                    _rubyFontSize = value;
                  });
                },
              ),
            ),
            Text(
              _rubyFontSize.toStringAsFixed(0),
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        Row(
          children: [
            const Text(
              "Auto Letter Spacing:",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Checkbox(
              value: _autoLetterSpacing,
              onChanged: (value) {
                setState(() {
                  _autoLetterSpacing = value ?? true;
                });
              },
            ),
          ],
        ),
        Row(
          children: [
            const Text(
              "Ruby Soft Wrap:",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Checkbox(
              value: _rubySoftWrap,
              onChanged: (value) {
                setState(() {
                  _rubySoftWrap = value ?? false;
                });
              },
            ),
          ],
        ),
        Row(
          children: [
            const Text(
              "Word Width:",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Expanded(
              child: Slider(
                min: 16,
                max: 100,
                value: _wordWidth,
                label: _wordWidth.toStringAsFixed(0),
                onChanged: (value) {
                  setState(() {
                    _wordWidth = value;
                  });
                },
              ),
            ),
            Text(
              _wordWidth.toStringAsFixed(0),
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Checkbox(
              value: _useWordWidth,
              onChanged: (value) {
                setState(() {
                  _useWordWidth = value ?? false;
                });
              },
            ),
          ],
        ),
      ],
    ),
  );
}
