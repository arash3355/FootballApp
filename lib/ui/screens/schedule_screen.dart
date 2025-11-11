import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../riverpod/league_riverpod.dart';
import '../../riverpod/match_riverpod.dart';
import '../widgets/league_tabs.dart';
import '../widgets/match_card.dart';

class ScheduleScreen extends ConsumerWidget {
  const ScheduleScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final leagues = ref.watch(leaguesProvider);
    final selectedId = ref.watch(selectedLeagueIdProvider);
    final notifier = ref.read(selectedLeagueIdProvider.notifier);
    final matches = ref.watch(matchesProvider(selectedId));

    return Column(
      children: [
        AppBar(title: const Text('Football League', style: TextStyle(color: Colors.black)), backgroundColor: Colors.white, elevation: 0, actions: [IconButton(onPressed: (){}, icon: const Icon(Icons.account_circle, color: Colors.blue))]),
        Padding(padding: const EdgeInsets.all(12.0), child: LeagueTabs(leagues: leagues, selectedId: selectedId, onSelect: (id) => notifier.state = id)),
        Expanded(
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            itemCount: matches.length,
            separatorBuilder: (_, __) => const SizedBox(height: 8),
            itemBuilder: (context, index) {
              final m = matches[index];
              // group by date simplified: just show date when first item or day changes
              return MatchCard(match: m, dense: true);
            },
          ),
        ),
      ],
    );
  }
}
