import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../../riverpod/league_riverpod.dart';
import '../../riverpod/match_riverpod.dart';
import '../widgets/league_tabs.dart';

class ScheduleScreen extends ConsumerWidget {
  const ScheduleScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final leagues = ref.watch(leaguesProvider);
    final selectedId = ref.watch(selectedLeagueIdProvider);
    final notifier = ref.read(selectedLeagueIdProvider.notifier);
    final matches = ref.watch(matchesProvider(selectedId));

    final today = DateTime.now();
    final yesterday = today.subtract(const Duration(days: 1));
    final tomorrow = today.add(const Duration(days: 1));

    // --- Pisahkan list ---
    final yesterdayMatches =
        matches.where((m) => _isSameDay(m.date, yesterday)).toList();
    final todayMatches =
        matches.where((m) => _isSameDay(m.date, today)).toList();
    final tomorrowMatches =
        matches.where((m) => _isSameDay(m.date, tomorrow)).toList();
    final otherMatches = matches
        .where((m) =>
            !_isSameDay(m.date, yesterday) &&
            !_isSameDay(m.date, today) &&
            !_isSameDay(m.date, tomorrow))
        .toList();

    // --- Buat Map dateLabel -> matches ---
    Map<String, List> grouped = {};
    if (yesterdayMatches.isNotEmpty) grouped['Yesterday'] = yesterdayMatches;
    if (todayMatches.isNotEmpty) grouped['Today'] = todayMatches;
    if (tomorrowMatches.isNotEmpty) grouped['Tomorrow'] = tomorrowMatches;

    // Tambahkan tanggal lain sesuai urutan
    final otherSorted = otherMatches.toList()
      ..sort((a, b) => a.date.compareTo(b.date));
    for (var m in otherSorted) {
      final key = DateFormat('EEE, d MMM').format(m.date);
      grouped.putIfAbsent(key, () => []).add(m);
    }

    final random = Random();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Football League',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.account_circle, color: Colors.blue),
          )
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: LeagueTabs(
              leagues: leagues,
              selectedId: selectedId,
              onSelect: (id) => notifier.state = id,
            ),
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              children: grouped.entries.map((entry) {
                final dateLabel = entry.key;
                final dateMatches = entry.value;

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Header tanggal
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Text(dateLabel,
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold)),
                    ),
                    ...dateMatches.map((m) {
                      final dateStr = DateFormat('HH:mm').format(m.date);

                      bool isYesterday = dateLabel == 'Yesterday';
                      final homeScore = isYesterday ? random.nextInt(5) : null;
                      final awayScore = isYesterday ? random.nextInt(5) : null;

                      return Container(
                        margin: const EdgeInsets.only(bottom: 8),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 8),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey.shade300),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          children: [
                            // Tim + score / time
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    isYesterday
                                        ? '${m.home.name} $homeScore-$awayScore ${m.away.name}'
                                        : '${m.home.name} vs ${m.away.name}',
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    dateStr,
                                    style: const TextStyle(
                                        fontSize: 12, color: Colors.grey),
                                  ),
                                ],
                              ),
                            ),

                            // Tombol hanya jika bukan yesterday
                            SizedBox(
                              width: 80,
                              child: !isYesterday
                                  ? Container(
                                      decoration: BoxDecoration(
                                        border: Border(
                                          left: BorderSide(
                                              color: Colors.grey.shade400,
                                              width: 1),
                                        ),
                                      ),
                                      padding: const EdgeInsets.only(left: 12),
                                      child: m.status.toLowerCase() == 'watch'
                                          ? ElevatedButton.icon(
                                              onPressed: () {},
                                              icon: const Icon(Icons.play_arrow,
                                                  size: 14),
                                              label: const Text('Watch'),
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor: Colors.green,
                                                foregroundColor: Colors.white,
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 4,
                                                        vertical: 4),
                                                textStyle: const TextStyle(
                                                    fontSize: 12),
                                              ),
                                            )
                                          : Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 4,
                                                      vertical: 4),
                                              decoration: BoxDecoration(
                                                color: Colors.redAccent,
                                                borderRadius:
                                                    BorderRadius.circular(6),
                                              ),
                                              child: Center(
                                                child: Text(
                                                  m.status,
                                                  style: const TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 12),
                                                ),
                                              ),
                                            ),
                                    )
                                  : const SizedBox(),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ],
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  bool _isSameDay(DateTime a, DateTime b) =>
      a.year == b.year && a.month == b.month && a.day == b.day;
}
