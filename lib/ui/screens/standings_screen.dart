import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:football_league_app/utils/helper.dart';
import '../../riverpod/league_riverpod.dart';
import '../../riverpod/standings_riverpod.dart';
import '../../riverpod/match_riverpod.dart';
import '../widgets/league_tabs.dart';

class StandingsScreen extends ConsumerWidget {
  const StandingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final leagues = ref.watch(leaguesProvider);
    final selectedId = ref.watch(selectedLeagueIdProvider);
    final teams = ref.watch(standingsProvider(selectedId));
    final matches = ref.watch(matchesProvider(selectedId));

    // Ambil matches yang sudah selesai (before today)
    final today = DateTime.now();
    final recentMatches = matches.where((m) => m.date.isBefore(today)).toList()
      ..sort((a, b) => b.date.compareTo(a.date));

    final random = Random();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'Football League',
          style: textTitle,
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.account_circle, color: Colors.blue),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            // --- Tab liga ---
            LeagueTabs(
              leagues: leagues,
              selectedId: selectedId,
              onSelect: (id) =>
                  ref.read(selectedLeagueIdProvider.notifier).state = id,
            ),
            const SizedBox(height: 12),

            // --- Table standings dibungkus card ---
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(1)),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                      minWidth: MediaQuery.of(context).size.width),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: DataTable(
                      columns: const [
                        DataColumn(
                            label: Text(
                          'No',
                          style: textSubtitle,
                        )),
                        DataColumn(
                            label: Text(
                          'Team',
                          style: textSubtitle,
                        )),
                        DataColumn(
                            label: Text(
                          'W',
                          style: textSubtitle,
                        )),
                        DataColumn(
                            label: Text(
                          'D',
                          style: textSubtitle,
                        )),
                        DataColumn(
                            label: Text(
                          'L',
                          style: textSubtitle,
                        )),
                        DataColumn(
                            label: Text(
                          'Pts',
                          style: textSubtitle,
                        )),
                      ],
                      rows: List.generate(teams.length, (index) {
                        final t = teams[index];
                        return DataRow(cells: [
                          DataCell(Text('${index + 1}')),
                          DataCell(Text(t.name)),
                          DataCell(Text('${t.played ~/ 4}')),
                          DataCell(Text('0')),
                          DataCell(Text('0')),
                          DataCell(Text('${t.points}')),
                        ]);
                      }),
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 24),

            // --- Recent matches ---
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Recent Matches',
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 8),

            // Expanded vertical list
            Expanded(
              child: ListView.builder(
                itemCount: recentMatches.length,
                itemBuilder: (context, index) {
                  final m = recentMatches[index];
                  final homeScore = random.nextInt(5);
                  final awayScore = random.nextInt(5);
                  final dateStr =
                      '${m.date.day}/${m.date.month} ${m.date.hour}:${m.date.minute.toString().padLeft(2, '0')}';

                  return Container(
                    height: 80, // card lebih tinggi
                    margin: const EdgeInsets.only(bottom: 8),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.grey.shade300),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.1),
                          blurRadius: 2,
                          offset: const Offset(0, 1),
                        )
                      ],
                    ),
                    child: Row(
                      children: [
                        // --- Kiri: Tim ---
                        Expanded(
                          flex: 3,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '${m.home.name} vs ${m.away.name}',
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  dateStr,
                                  style: const TextStyle(
                                      fontSize: 12, color: Colors.grey),
                                ),
                              ],
                            ),
                          ),
                        ),

                        // --- Kanan: Score ---
                        Container(
                          width: 100,
                          decoration: BoxDecoration(
                            border: Border(
                              left: BorderSide(
                                  color: Colors.grey.shade400, width: 1),
                            ),
                          ),
                          child: Center(
                            child: Text(
                              '$homeScore - $awayScore',
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
