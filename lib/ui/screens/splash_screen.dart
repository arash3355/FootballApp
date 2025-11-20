import 'dart:async';
import 'package:flutter/material.dart';
import 'package:football_league_app/utils/helper.dart';
import 'main_screen.dart'; // halaman utama kamu

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    // Timer delay 3 detik
    Timer(const Duration(seconds: 3), () {
      if (mounted) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => const MainScreen()),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.blueAccent,
      body: Stack(
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.sports_soccer, color: Colors.white, size: 100),
                gap16,
                Text(
                  'Football League',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 26,
                      fontWeight: FontWeight.bold),
                ),
                gap24,
                loadingIndicator,
              ],
            ),
          ),

          // Copyright
          Positioned(
            bottom: 16,
            left: 0,
            right: 0,
            child: Text(
              'Created by Abdul Rahman Shalehudin\n22552011002 (TIF-RM 23B)',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 11,
                color: Color.fromARGB(255, 194, 194, 194),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
