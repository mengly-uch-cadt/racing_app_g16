// lib/screens/start_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/race_provider.dart';
import 'race_screen.dart';

class StartScreen extends StatelessWidget {
  final String raceId;

  const StartScreen({required this.raceId, super.key});

  @override
  Widget build(BuildContext context) {
    final raceProvider = Provider.of<RaceProvider>(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Start Race')),
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            raceProvider.init(raceId);
            await raceProvider.startRace();
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => RaceScreen(raceId: raceId, raceNumber: 1)),
            );
          },
          child: const Text('Start'),
        ),
      ),
    );
  }
}
