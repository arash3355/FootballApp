import 'dart:async';
import 'package:flutter/material.dart';
import 'package:football_league_app/utils/helper.dart';
import 'main_screen.dart';

class SplashScreenn extends StatefulWidget {
  const SplashScreenn({super.key});

  @override
  State<SplashScreenn> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreenn>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeIn;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    _fadeIn = CurvedAnimation(parent: _controller, curve: Curves.easeIn);
    _controller.forward();

    Timer(const Duration(seconds: 5), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => const MainScreen()),
      );
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade900,
      body: SafeArea(
        child: Stack(
          children: [
            // --- Tengah Layar ---
            Center(
              child: FadeTransition(
                opacity: _fadeIn,
                child: const Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.sports_soccer_outlined,
                      size: 100,
                      color: Colors.white,
                    ),
                    gap16,
                    Text(
                      'Football League',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        letterSpacing: 1.2,
                      ),
                    ),
                    gap24,
                    loadingIndicator
                  ],
                ),
              ),
            ),

            // --- Credit di bawah layar ---
            const Positioned(
              bottom: 16,
              left: 0,
              right: 0,
              child: Text(
                'Created by Abdul Rahman Shalehudin\n22552011002 (TIF-RM 23B)',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 11,
                  color: Color.fromARGB(180, 220, 220, 220),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
