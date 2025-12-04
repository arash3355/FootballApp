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

    final today = DateTime.now();
    final recentMatches = matches.where((m) => m.date.isBefore(today)).toList()
      ..sort((a, b) => b.date.compareTo(a.date));

    final random = Random();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Football League', style: textTitle),
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.account_circle, color: Colors.blue),
          ),
        ],
      ),
      body: CustomScrollView(
        slivers: [
          // --- League Tabs ---
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: LeagueTabs(
                leagues: leagues,
                selectedId: selectedId,
                onSelect: (id) =>
                    ref.read(selectedLeagueIdProvider.notifier).state = id,
              ),
            ),
          ),

          // --- Table Standings ---
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Card(
                elevation: 2,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(1)),
                child: Column(
                  children: [
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: ConstrainedBox(
                        constraints: BoxConstraints(
                            minWidth: MediaQuery.of(context).size.width),
                        child: DataTable(
                          columns: const [
                            DataColumn(
                                label: Text('Pos.', style: textSubtitle)),
                            DataColumn(
                                label: Text('Team', style: textSubtitle)),
                            DataColumn(label: Text('W', style: textSubtitle)),
                            DataColumn(label: Text('D', style: textSubtitle)),
                            DataColumn(label: Text('L', style: textSubtitle)),
                            DataColumn(label: Text('Pts', style: textSubtitle)),
                          ],
                          rows: List.generate(teams.length, (index) {
                            final t = teams[index];
                            return DataRow(cells: [
                              DataCell(Text('${index + 1}')),
                              DataCell(Text(t.name)),
                              DataCell(Text('${t.played ~/ 4}')),
                              const DataCell(Text('0')),
                              const DataCell(Text('0')),
                              DataCell(Text('${t.points}')),
                            ]);
                          }),
                        ),
                      ),
                    ),
                    
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 12),
                      child: Column(
                        children: [
                          Text(
                            'W = Win   |   D = Draw   |   L = Lose   |   Pts = Points',
                            style: textBody,
                          ),
                          gap4
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // --- Recent Matches ---
          const SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.fromLTRB(12, 24, 12, 8),
              child: Text(
                'Recent Matches',
                style: textSubtitle,
              ),
            ),
          ),
          
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                final m = recentMatches[index];
                final homeScore = random.nextInt(5);
                final awayScore = random.nextInt(5);
                final dateStr =
                    '${m.date.day}/${m.date.month} ${m.date.hour}:${m.date.minute.toString().padLeft(2, '0')}';

                return Container(
                  height: 80,
                  margin:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.grey.shade300),
                    boxShadow: [
                      BoxShadow(
                        // ignore: deprecated_member_use
                        color: Colors.grey.withOpacity(0.1),
                        blurRadius: 2,
                        offset: const Offset(0, 1),
                      )
                    ],
                  ),
                  child: Row(
                    children: [
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
                                style: textSubtitle,
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
                            style: textSubtitle,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
              childCount: recentMatches.length,
            ),
          ),
        ],
      ),
    );
  }
}
