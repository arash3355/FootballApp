import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../riverpod/league_riverpod.dart';
import '../../riverpod/standings_riverpod.dart';
import '../widgets/league_tabs.dart';

class StandingsScreen extends ConsumerWidget {
  const StandingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final leagues = ref.watch(leaguesProvider);
    final selectedId = ref.watch(selectedLeagueIdProvider);
    final teams = ref.watch(standingsProvider(selectedId));

    return Column(
      children: [
        AppBar(title: const Text('Football League', style: TextStyle(color: Colors.black)), backgroundColor: Colors.white, elevation: 0, actions: [IconButton(onPressed: (){}, icon: const Icon(Icons.account_circle, color: Colors.blue))]),
        Padding(padding: const EdgeInsets.all(12.0), child: LeagueTabs(leagues: leagues, selectedId: selectedId, onSelect: (id) => ref.read(selectedLeagueIdProvider.notifier).state = id)),
        Expanded(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
              columns: const [
                DataColumn(label: Text('No')),
                DataColumn(label: Text('Team')),
                DataColumn(label: Text('W')),
                DataColumn(label: Text('D')),
                DataColumn(label: Text('L')),
                DataColumn(label: Text('Pts')),
              ],
              rows: List.generate(teams.length, (index) {
                final t = teams[index];
                return DataRow(cells: [
                  DataCell(Text('${index+1}')),
                  DataCell(Text(t.name)),
                  DataCell(Text('${t.played~/4}')),
                  DataCell(Text('0')),
                  DataCell(Text('0')),
                  DataCell(Text('${t.points}')),
                ]);
              }),
            ),
          ),
        ),
      ],
    );
  }
}
