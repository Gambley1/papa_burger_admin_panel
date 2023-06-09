import 'package:flutter/material.dart';
import 'package:papa_burger_admin_panel/app.dart';
import 'package:papa_burger_admin_panel/src/config/theme/theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Papa Burger admin panel',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkTheme,
      home: const App(),
    );
  }
}
