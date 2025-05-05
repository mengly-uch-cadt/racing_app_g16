import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/race_provider.dart';
import 'start_screen.dart';

class RaceSelectorScreen extends StatelessWidget {
  const RaceSelectorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final raceProvider = Provider.of<RaceProvider>(context);
    final races = raceProvider.races;

    return Scaffold(
      appBar: AppBar(title: const Text('Select Race')),
      body: races.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : ListView(
              children: races.entries.map((entry) {
                final raceId = entry.key;
                final raceData = entry.value as Map;
                final raceName = raceData['name'] ?? 'Unnamed Race';

                return ListTile(
                  title: Text(raceName),
                  trailing: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => StartScreen(
                            raceId: raceId,
                            raceName: raceName,
                          ),
                        ),
                      );
                    },
                    child: const Text('Select'),
                  ),
                );
              }).toList(),
            ),
    );
  }
}
