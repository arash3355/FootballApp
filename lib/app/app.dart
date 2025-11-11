import 'package:flutter/material.dart';
import '../ui/screens/main_screen.dart';

class FootballLeagueApp extends StatelessWidget {
  const FootballLeagueApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Football League',
      theme: ThemeData(
        brightness: Brightness.light,
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: const Color.fromARGB(255, 231, 244, 255),
        useMaterial3: true,
      ),
      home: const MainScreen(),
    );
  }
}
