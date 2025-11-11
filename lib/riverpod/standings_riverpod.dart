import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/team.dart';
import 'league_riverpod.dart';

final standingsProvider = Provider.family<List<Team>, String>((ref, leagueId) {
  final leagues = ref.read(leaguesProvider);
  final league = leagues.firstWhere((l) => l.id == leagueId);
  final teams = List<Team>.from(league.teams);
  teams.sort((a, b) => b.points.compareTo(a.points));
  return teams;
});
