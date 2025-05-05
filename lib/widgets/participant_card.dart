// lib/widgets/participant_card.dart
import 'package:flutter/material.dart';
import '../models/user.dart';
import '../models/participant.dart';

class ParticipantCard extends StatelessWidget {
  final User user;
  final Participant participant;
  final VoidCallback onFinish;

  const ParticipantCard({
    required this.user,
    required this.participant,
    required this.onFinish,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text('${user.bib} - ${user.name}'),
        subtitle: Text('Current Race: ${participant.currentRace}'),
        trailing: ElevatedButton(
          onPressed: onFinish,
          child: const Text('Finish'),
        ),
      ),
    );
  }
}
