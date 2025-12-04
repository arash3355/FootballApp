import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:football_league_app/utils/helper.dart';
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

    // --- Kelompok match berdasarkan tanggal ---
    final Map<String, List> grouped = {};

    // Urutkan match berdasarkan tanggal
    final sortedMatches = [...matches]
      ..sort((a, b) => a.date.compareTo(b.date));

    final random = Random();

    for (var m in sortedMatches) {
      final dateKey = _dateLabel(m.date, today);
      grouped.putIfAbsent(dateKey, () => []).add(m);
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Football League', style: textTitle),
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

                final isPast = _isBeforeToday(dateMatches.first.date, today);

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Text(dateLabel, style: textSubtitle),
                    ),
                    ...dateMatches.map((m) {
                      final dateStr = DateFormat('HH:mm').format(m.date);

                      final homeScore =
                          isPast ? random.nextInt(5) : null; // tampilkan skor
                      final awayScore = isPast ? random.nextInt(5) : null;

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
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    isPast
                                        ? '${m.home.name} $homeScore-$awayScore ${m.away.name}'
                                        : '${m.home.name} vs ${m.away.name}',
                                    style: textSubtitle,
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
                            
                            if (!isPast)
                              SizedBox(
                                width: 80,
                                child: Container(
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
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 4, vertical: 4),
                                            textStyle:
                                                const TextStyle(fontSize: 12),
                                          ),
                                        )
                                      : Container(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 4, vertical: 4),
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
                                ),
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

  bool _isBeforeToday(DateTime date, DateTime today) =>
      date.isBefore(DateTime(today.year, today.month, today.day));

  String _dateLabel(DateTime date, DateTime today) {
    if (_isSameDay(date, today)) return 'Today';
    if (_isBeforeToday(date, today)) {
      final diff = today.difference(date).inDays;
      return diff == 1 ? 'Yesterday' : DateFormat('EEE, d MMM').format(date);
    } else {
      final diff = date.difference(today).inDays;
      return diff == 1 ? 'Tomorrow' : DateFormat('EEE, d MMM').format(date);
    }
  }
}
