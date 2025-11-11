import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/league.dart';
import '../models/team.dart';

final leaguesProvider = Provider<List<League>>((ref) {
  final leagues = [
    League(
        id: 'la',
        name: 'LaLiga',
        country: 'Spain',
        imageUrl:
            'https://www.shutterstock.com/shutterstock/photos/1039736680/display_1500/stock-photo-soccer-player-kicking-ball-during-match-in-stadium-1039736680.jpg',
        teams: [
          Team(id: 'rma', name: 'Real Madrid', played: 12, points: 32),
          Team(id: 'fcb', name: 'FC Barcelona', played: 12, points: 29),
        ]),
    League(
        id: 'epl',
        name: 'Premier League',
        country: 'England',
        imageUrl:
            'https://www.shutterstock.com/shutterstock/photos/2452490349/display_1500/stock-photo-backview-of-fans-cheer-for-their-team-on-a-stadium-during-soccer-championship-match-teams-play-2452490349.jpg',
        teams: [
          Team(id: 'mci', name: 'Manchester City', played: 12, points: 30),
          Team(id: 'mnu', name: 'Manchester United', played: 12, points: 24),
        ]),
    League(
        id: 'bundes',
        name: 'Bundesliga',
        country: 'Germany',
        imageUrl:
            'https://www.shutterstock.com/shutterstock/photos/2578181787/display_1500/stock-photo-soccer-athletes-dressed-sport-uniforms-challenging-for-soccer-ball-on-wet-grass-cleats-kicking-up-2578181787.jpg',
        teams: [
          Team(id: 'b04', name: 'Bayer Leverkusen', played: 12, points: 31),
          Team(id: 'bvb', name: 'Borussia Dortmund', played: 12, points: 28),
        ]),
    League(
        id: 'seriea',
        name: 'Serie A',
        country: 'Italy',
        imageUrl:
            'https://images.unsplash.com/photo-1730816401327-1b6ce7b2a926?ixlib=rb-4.1.0&auto=format&fit=crop&q=80&w=1112',
        teams: [
          Team(id: 'juv', name: 'Juventus', played: 12, points: 27),
          Team(id: 'int', name: 'Inter Milan', played: 12, points: 26),
        ]),
  ];
  return leagues;
});

final selectedLeagueIdProvider = StateProvider<String>((ref) {
  final leagues = ref.read(leaguesProvider);
  return leagues.isNotEmpty ? leagues[0].id : '';
});
