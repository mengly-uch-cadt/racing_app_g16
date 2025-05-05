import 'package:flutter/material.dart';
import 'race_screen.dart';

class RaceScreenWrapper extends StatelessWidget {
  const RaceScreenWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;

    if (args == null || !args.containsKey('raceId') || !args.containsKey('raceNumber')) {
      return const Scaffold(
        body: Center(child: Text('Error: Missing race parameters')),
      );
    }

    final String raceId = args['raceId'];
    final int raceNumber = args['raceNumber'];

    return RaceScreen(raceId: raceId, raceNumber: raceNumber);
  }
}
