import 'dart:math';

import 'package:flutter/material.dart';
import 'package:test_app/src/utils/utils.dart';

/// A key which is used to find the tappable area of this page
@visibleForTesting
final tappableAreaKey = UniqueKey();

/// Page which just show a [text] in the centre and can change
/// it's background color.
class ColorfulPage extends StatefulWidget {
  /// [generator] is needed to generate new background [Color] of this page.
  final ColorGenerator generator;

  /// Text which will be shown in the middle of the page.
  final String text;

  /// Page constructor.
  const ColorfulPage({
    super.key,
    required this.generator,
    this.text = '',
  });

  @override
  State<ColorfulPage> createState() => _ColorfulPageState();
}

class _ColorfulPageState extends State<ColorfulPage> {
  final _random = Random();
  var _color = Colors.white;

  void _updateColor() => _color = widget.generator.generate();

  @override
  void initState() {
    super.initState();
    _updateColor();
  }

  @override
  Widget build(BuildContext context) {
    // Font size and color will change dynamically
    final fontSize = 16.0 + _random.nextInt(20);
    final useDarkText = _color.computeLuminance() > 0.5;

    return Scaffold(
      backgroundColor: _color,
      body: InkWell(
        key: tappableAreaKey,
        onTap: () => setState(_updateColor),
        child: Center(
          child: AnimatedDefaultTextStyle(
            duration: const Duration(milliseconds: 75),
            style: TextStyle(
              fontSize: fontSize,
              color: useDarkText ? Colors.black : Colors.white,
            ),
            child: Text(widget.text),
          ),
        ),
      ),
    );
  }
}
