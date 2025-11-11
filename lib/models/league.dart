import 'team.dart';

class League {
  final String id;
  final String name;
  final String country;
  final List<Team> teams;
  final String? imageUrl;

  League({
    required this.id,
    required this.name,
    required this.country,
    required this.imageUrl,
    required this.teams,
  });
}
