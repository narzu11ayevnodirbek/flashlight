import 'package:flashlight/view/home_screen.dart';
import 'package:flashlight/view_model/flashlight_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => FlashlightViewModel(),
      child: const MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Flashlight App",
      theme: ThemeData.dark(),
      home: const HomeScreen(),
    );
  }
}
