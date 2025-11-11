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
          'https://www.shutterstock.com/shutterstock/photos/2247981549/display_1500/stock-photo-stadium-soccer-football-match-championship-blue-team-players-attacks-plays-in-pass-action-game-2247981549.jpg',
      teams: [
        Team(id: 'rma', name: 'Real Madrid', played: 12, points: 32),
        Team(id: 'fcb', name: 'FC Barcelona', played: 12, points: 29),
        Team(id: 'atm', name: 'Atletico Madrid', played: 12, points: 27),
        Team(id: 'sev', name: 'Sevilla FC', played: 12, points: 25),
        Team(id: 'bet', name: 'Real Betis', played: 12, points: 24),
        Team(id: 'soc', name: 'Real Sociedad', played: 12, points: 22),
        Team(id: 'val', name: 'Valencia CF', played: 12, points: 20),
        Team(id: 'osa', name: 'Osasuna', played: 12, points: 18),
        Team(id: 'cel', name: 'Celta Vigo', played: 12, points: 16),
        Team(id: 'ath', name: 'Athletic Bilbao', played: 12, points: 14),
      ],
    ),
    League(
      id: 'epl',
      name: 'Premier League',
      country: 'England',
      imageUrl:
          'https://www.shutterstock.com/shutterstock/photos/2452490349/display_1500/stock-photo-backview-of-fans-cheer-for-their-team-on-a-stadium-during-soccer-championship-match-teams-play-2452490349.jpg',
      teams: [
        Team(id: 'mci', name: 'Manchester City', played: 12, points: 30),
        Team(id: 'liv', name: 'Liverpool', played: 12, points: 28),
        Team(id: 'ars', name: 'Arsenal', played: 12, points: 27),
        Team(id: 'che', name: 'Chelsea', played: 12, points: 25),
        Team(id: 'tot', name: 'Tottenham Hotspur', played: 12, points: 24),
        Team(id: 'mnu', name: 'Manchester United', played: 12, points: 22),
        Team(id: 'eve', name: 'Everton', played: 12, points: 20),
        Team(id: 'lei', name: 'Leicester City', played: 12, points: 18),
        Team(id: 'sou', name: 'Southampton', played: 12, points: 16),
        Team(id: 'wol', name: 'Wolverhampton', played: 12, points: 14),
      ],
    ),
    League(
      id: 'bundes',
      name: 'Bundesliga',
      country: 'Germany',
      imageUrl:
          'https://www.shutterstock.com/shutterstock/photos/2578181787/display_1500/stock-photo-soccer-athletes-dressed-sport-uniforms-challenging-for-soccer-ball-on-wet-grass-cleats-kicking-up-2578181787.jpg',
      teams: [
        Team(id: 'b04', name: 'Bayer Leverkusen', played: 12, points: 32),
        Team(id: 'bvb', name: 'Borussia Dortmund', played: 12, points: 30),
        Team(id: 'fcb', name: 'FC Bayern Munich', played: 12, points: 28),
        Team(id: 'rbl', name: 'RB Leipzig', played: 12, points: 26),
        Team(id: 'wol', name: 'VfL Wolfsburg', played: 12, points: 24),
        Team(id: 'frk', name: 'Eintracht Frankfurt', played: 12, points: 22),
        Team(id: 'aug', name: 'FC Augsburg', played: 12, points: 20),
        Team(id: 'kol', name: '1. FC Köln', played: 12, points: 18),
        Team(id: 'darm', name: 'SV Darmstadt', played: 12, points: 16),
        Team(id: 'her', name: 'Hertha BSC', played: 12, points: 14),
      ],
    ),
    League(
      id: 'seriea',
      name: 'Serie A',
      country: 'Italy',
      imageUrl:
          'https://images.unsplash.com/photo-1730816401327-1b6ce7b2a926?ixlib=rb-4.1.0&auto=format&fit=crop&q=80&w=1112',
      teams: [
        Team(id: 'juv', name: 'Juventus', played: 12, points: 32),
        Team(id: 'int', name: 'Inter Milan', played: 12, points: 30),
        Team(id: 'acm', name: 'AC Milan', played: 12, points: 28),
        Team(id: 'nap', name: 'Napoli', played: 12, points: 26),
        Team(id: 'rom', name: 'AS Roma', played: 12, points: 24),
        Team(id: 'laz', name: 'Lazio', played: 12, points: 22),
        Team(id: 'ata', name: 'Atalanta', played: 12, points: 20),
        Team(id: 'fio', name: 'Fiorentina', played: 12, points: 18),
        Team(id: 'tor', name: 'Torino', played: 12, points: 16),
        Team(id: 'sam', name: 'Sampdoria', played: 12, points: 14),
      ],
    ),
  ];
  return leagues;
});

final selectedLeagueIdProvider = StateProvider<String>((ref) {
  final leagues = ref.read(leaguesProvider);
  return leagues.isNotEmpty ? leagues[0].id : '';
});
