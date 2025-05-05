import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:racing_app/screens/start_screen.dart';
import '../providers/race_provider.dart';
import '../widgets/participant_card.dart';
import 'result_screen.dart';

class RaceScreen extends StatelessWidget {
  final String raceId;
  final int raceNumber;

  const RaceScreen({required this.raceId, required this.raceNumber, super.key});

  @override
  Widget build(BuildContext context) {
    final raceProvider = Provider.of<RaceProvider>(context);

    // Ensure provider is initialized
    if (raceProvider.currentRaceId != raceId) {
      raceProvider.init(raceId);
    }

    // Filter participants in this race round
    final participantEntries = raceProvider.participants.entries
        .where((entry) => entry.value.currentRace == raceNumber)
        .toList();

    return Scaffold(
      appBar: AppBar(title: Text('Race $raceNumber')),
      body: participantEntries.isEmpty
          ? const Center(child: Text('No participants in this race.'))
          : ListView(
              children: participantEntries.map((entry) {
                final id = entry.key;
                final participant = entry.value;
                final user = raceProvider.users[id];

                if (user == null) {
                  debugPrint('Warning: Missing user data for $id');
                  return const SizedBox.shrink();
                }

                return ParticipantCard(
                  user: user,
                  participant: participant,
                  onFinish: () async {
                    await raceProvider.finishParticipant(id, raceNumber);

                    if (raceNumber == 3) {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (_) => StartScreen(raceId: raceId),
                        ),
                      );
                    }
                  },
                );
              }).toList(),
            ),
    );
  }
}
