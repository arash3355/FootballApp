import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/team.dart';

final standingsProvider = Provider.family<List<Team>, String>((ref, leagueId) {
  // Return teams sorted by points (dummy)
  final teams = [
    Team(id: 't1', name: 'Persib', played: 12, points: 30),
    Team(id: 't2', name: 'Persija', played: 12, points: 28),
    Team(id: 't3', name: 'Persita', played: 12, points: 22),
    Team(id: 't4', name: 'Persebaya', played: 12, points: 20),
  ];
  teams.sort((a, b) => b.points.compareTo(a.points));
  return teams;
});
