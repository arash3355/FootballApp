import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../riverpod/league_riverpod.dart';
import '../../riverpod/match_riverpod.dart';
import '../widgets/league_tabs.dart';
import '../widgets/match_carousel.dart';
import '../widgets/match_card.dart';
import '../../utils/helper.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // --- Data provider ---
    final leagues = ref.watch(leaguesProvider);
    final selectedId = ref.watch(selectedLeagueIdProvider);
    final notifier = ref.read(selectedLeagueIdProvider.notifier);
    final matches = ref.watch(matchesProvider(selectedId));

    // --- Pemisahan data berdasarkan tanggal ---
    final today = DateTime.now();
    final todayMatches = matches
        .where((m) =>
            m.date.year == today.year &&
            m.date.month == today.month &&
            m.date.day == today.day)
        .toList();
    final upcomingMatches = matches
        .where((m) => !(m.date.year == today.year &&
            m.date.month == today.month &&
            m.date.day == today.day))
        .toList();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Football League', style: textTitle),
        backgroundColor: Colors.white,
        elevation: 0,
        actions: const [
          Icon(Icons.account_circle, color: Colors.blue),
          gapW12,
        ],
      ),

      // --- Body utama ---
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              gap12,

              // --- Carousel atas ---
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.30,
                child: const MatchCarousel(),
              ),
              gap24,

              // --- Tab liga ---
              LeagueTabs(
                leagues: leagues,
                selectedId: selectedId,
                onSelect: (id) => notifier.state = id,
              ),
              gap24,

              // Today Matches
              _buildSectionTitle('Today Matches'),
              gap8,
              _buildMatchList(todayMatches),
              gap24,

              // Upcoming Matches
              _buildSectionTitle('Upcoming Matches'),
              gap8,
              _buildMatchList(upcomingMatches),
              gap24,
            ],
          ),
        ),
      ),
    );
  }

  /// Judul section seperti "Today Matches" / "Upcoming Matches"
  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: textSubtitle.copyWith(fontSize: 18, fontWeight: FontWeight.bold),
    );
  }

  /// Daftar pertandingan dengan scroll horizontal
  Widget _buildMatchList(List matches) {
    if (matches.isEmpty) {
      return emptyState('No matches available.');
    }

    return SizedBox(
      height: 150,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: matches.length,
        itemBuilder: (context, index) {
          final match = matches[index];
          return Padding(
            padding: const EdgeInsets.only(right: 12),
            child: SizedBox(
              width: 230,
              child: MatchCard(match: match),
            ),
          );
        },
      ),
    );
  }
}
