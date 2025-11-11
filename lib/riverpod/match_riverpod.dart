import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/match_item.dart';
import '../models/team.dart';

// Dummy matches per league id for demo
final matchesProvider =
    Provider.family<List<MatchItem>, String>((ref, leagueId) {
  final now = DateTime.now();

  // Dummy teams berbeda per league
  late Team teamA;
  late Team teamB;

  if (leagueId == 'la') {
    teamA = Team(id: 'rma', name: 'Real Madrid', played: 10, points: 25);
    teamB = Team(id: 'bar', name: 'Barcelona', played: 10, points: 22);
  } else if (leagueId == 'epl') {
    teamA = Team(id: 'mci', name: 'Manchester City', played: 10, points: 26);
    teamB = Team(id: 'liv', name: 'Liverpool', played: 10, points: 24);
  } else if (leagueId == 'bundes') {
    teamA = Team(id: 'b04', name: 'Bayer Leverkusen', played: 12, points: 31);
    teamB = Team(id: 'bvb', name: 'Borussia Dortmund', played: 12, points: 28);
  } else if (leagueId == 'seriea') {
    teamA = Team(id: 'juv', name: 'Juventus', played: 12, points: 27);
    teamB = Team(id: 'int', name: 'Inter Milan', played: 12, points: 26);
  }

  return List.generate(8, (i) {
    final date = now.add(Duration(days: i ~/ 2));
    final status = i % 3 == 0 ? 'Watch' : '${(18 + i) % 24}:00';
    return MatchItem(
        id: '$leagueId-m-$i',
        home: teamA,
        away: teamB,
        date: date,
        status: status);
  });
});
