import 'dart:math';
import 'dart:ui';

/// Class for random color generation.
class ColorGenerator {
  final Random _random;

  static const _max = 256;

  /// Creates a new generator instance.
  /// [seed] value is used to initialize a [Random] instance.
  ColorGenerator([int? seed]) : _random = Random(seed);

  /// Returns new random [Color] value.
  Color generate() {
    final red = _randomValue();
    final green = _randomValue();
    final blue = _randomValue();

    return Color.fromRGBO(red, green, blue, 1);
  }

  int _randomValue() => _random.nextInt(_max);
}
