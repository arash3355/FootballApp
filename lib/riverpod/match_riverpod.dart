import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:math';
import '../models/match_item.dart';
import '../models/team.dart';
import 'league_riverpod.dart';

final matchesProvider =
    Provider.family<List<MatchItem>, String>((ref, leagueId) {
  final rng = Random();
  final leagues = ref.watch(leaguesProvider);
  final league =
      leagues.firstWhere((l) => l.id == leagueId, orElse: () => leagues.first);
  final teams = league.teams;
  final now = DateTime.now();

  return List.generate(15, (i) {
    final home = teams[rng.nextInt(teams.length)];
    Team away;
    do {
      away = teams[rng.nextInt(teams.length)];
    } while (away.id == home.id);

    final date = now.add(Duration(days: rng.nextInt(14) - 7)); // -7 to +7 days
    final isPast = date.isBefore(now);
    final status = isPast ? 'Full Time' : '${12 + rng.nextInt(12)}:00';

    return MatchItem(
      id: '$leagueId-match-$i',
      leagueId: leagueId,
      home: home,
      away: away,
      date: date,
      status: status,
    );
  });
});
