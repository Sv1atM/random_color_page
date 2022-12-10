import 'package:flutter/material.dart';
import 'package:test_app/src/ui/ui.dart';
import 'package:test_app/src/utils/utils.dart';

/// The main application.
class App extends StatelessWidget {
  /// Create the application instance.
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Test app',
      home: ColorfulPage(
        generator: ColorGenerator(),
        text: 'Hey there',
      ),
    );
  }
}
