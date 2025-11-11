import 'package:flutter/material.dart';
import 'package:football_league_app/riverpod/league_riverpod.dart';
import 'package:football_league_app/utils/helper.dart';
import '../../models/match_item.dart';
import 'package:intl/intl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MatchCard extends ConsumerWidget {
  final MatchItem match;
  final bool dense;
  const MatchCard({super.key, required this.match, this.dense = false});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Ambil semua liga
    final leagues = ref.watch(leaguesProvider);

    // Cari liga yang sesuai match
    final league = leagues.firstWhere(
      (l) => l.id == match.leagueId,
      orElse: () => leagues[0],
    );

    final imageUrl = league.imageUrl ??
        'https://images.unsplash.com/photo-1730816401327-1b6ce7b2a926?ixlib=rb-4.1.0&auto=format&fit=crop&q=80&w=1112'; // Gambar default jika tidak ada

    final dateStr = DateFormat('EEE, d MMM').format(match.date);

    return Container(
      constraints: const BoxConstraints(minHeight: 160, maxHeight: 200),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        image: DecorationImage(
          image: NetworkImage(imageUrl),
          fit: BoxFit.cover,
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.35),
          borderRadius: BorderRadius.circular(10),
        ),
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${match.home.name} vs ${match.away.name}',
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            gap8,
            Text(
              dateStr,
              style: const TextStyle(fontSize: 12, color: Colors.white70),
            ),
            const Spacer(),
            Align(
              alignment: Alignment.bottomRight,
              child: match.status.toLowerCase() == 'watch'
                  ? ElevatedButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.play_arrow, size: 14),
                      label: const Text('Watch'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 1),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        textStyle: const TextStyle(fontSize: 12),
                      ),
                    )
                  : Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 6),
                      decoration: BoxDecoration(
                        color: Colors.redAccent,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        match.status,
                        style:
                            const TextStyle(color: Colors.white, fontSize: 12),
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
