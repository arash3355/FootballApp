import 'team.dart';

class MatchItem {
  final String id;
  final Team home;
  final Team away;
  final DateTime date;
  final String status; // 'watch' or time like '20:00'
  final String? imageUrl;

  MatchItem(
      {required this.id,
      required this.home,
      required this.away,
      required this.date,
      this.status = '-',
      this.imageUrl});
}
