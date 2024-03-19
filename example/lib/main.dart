import 'package:flutter/material.dart';
import 'package:full_screen_loading_indicator/full_screen_loading_indicator.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: GlobalLoaderOverlay(
        useDefaultLoading: false,
        overlayWidgetBuilder: (progress) {
          return Center(
            child: Container(
              color: Colors.blue,
              width: 100,
              height: 100,
            ),
          );
        },
        child: Scaffold(
          body: Builder(builder: (context) {
            return Center(
              child: ElevatedButton(
                onPressed: () {
                  FullScreenLoadingIndicator.show(context, () async {
                    await Future.delayed(const Duration(seconds: 2));
                    return 'After 2 seconds';
                  });
                },
                child: const Text('Hello World!'),
              ),
            );
          }),
        ),
      ),
    );
  }
}
