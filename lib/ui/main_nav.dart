import 'package:flutter/material.dart';
import 'package:football_league_app/ui/screens/home_screen.dart';
import 'package:football_league_app/ui/screens/schedule_screen.dart';
import 'package:football_league_app/ui/screens/standings_screen.dart';

class MainNav extends StatefulWidget {
  const MainNav({super.key});

  @override
  State<MainNav> createState() => _MainNavState();
}

class _MainNavState extends State<MainNav> {
  int _currentIndex = 0;

  final List<Widget> _pages = const [
    HomeScreen(),
    ScheduleScreen(),
    StandingsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        // ✅ ganti ke IndexedStack agar widget tidak rebuild setiap tab pindah
        index: _currentIndex,
        children: _pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentIndex,
        onTap: (i) {
          if (!mounted)
            return; // ✅ cegah error "Looking up a deactivated widget's ancestor"
          setState(() => _currentIndex = i);
        },
        backgroundColor: Colors.blue.shade900,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white70,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.schedule), label: 'Schedule'),
          BottomNavigationBarItem(
              icon: Icon(Icons.table_chart), label: 'Standings'),
        ],
      ),
    );
  }
}
