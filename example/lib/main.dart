import 'package:example/views/quotes_view.dart';
import 'package:flutter/material.dart';

import 'dependency_injection.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  /// Inject all view models in advance
  DI.setUp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pulse State Management Demo',
      theme: ThemeData(
        primarySwatch: Colors.amber,
        scaffoldBackgroundColor: Colors.amber.shade50,
        useMaterial3: true,
        appBarTheme: AppBarTheme(
          centerTitle: true,
          backgroundColor: Colors.amber.shade50,
          elevation: 0.0,
        ),
      ),
      debugShowCheckedModeBanner: false,
      home: QuotesView(),
    );
  }
}
