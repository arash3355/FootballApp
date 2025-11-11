import 'package:flutter/material.dart';
import '../../models/league.dart';

class LeagueTabs extends StatelessWidget {
  final List<League> leagues;
  final String selectedId;
  final void Function(String) onSelect;
  const LeagueTabs(
      {super.key,
      required this.leagues,
      required this.selectedId,
      required this.onSelect});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 30,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: leagues.length,
        itemBuilder: (context, index) {
          final l = leagues[index];
          final selected = l.id == selectedId;
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 6.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: selected ? Colors.blue : Colors.grey[200],
                foregroundColor: selected ? Colors.white : Colors.black,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6)),
                elevation: 0,
              ),
              onPressed: () => onSelect(l.id),
              child: Text(l.name),
            ),
          );
        },
      ),
    );
  }
}
