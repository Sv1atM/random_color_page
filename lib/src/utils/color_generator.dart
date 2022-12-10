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
    final alpha = _randomValue();
    final red = _randomValue();
    final green = _randomValue();
    final blue = _randomValue();

    return Color.fromARGB(alpha, red, green, blue);
  }

  int _randomValue() => _random.nextInt(_max);
}
