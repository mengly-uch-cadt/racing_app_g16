import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/race_provider.dart';
import '../widgets/participant_card.dart';
import '../widgets/timer_display.dart';
import 'result_screen.dart';

class RaceScreen extends StatefulWidget {
  final String raceId;
  final int raceNumber;

  const RaceScreen({required this.raceId, required this.raceNumber, super.key});

  @override
  State<RaceScreen> createState() => _RaceScreenState();
}

class _RaceScreenState extends State<RaceScreen> {
  late Timer _timer;
  Duration _elapsed = Duration.zero;

  @override
  void initState() {
    super.initState();
    _startLiveTimer();
  }

  void _startLiveTimer() {
    final raceProvider = Provider.of<RaceProvider>(context, listen: false);
    _timer = Timer.periodic(const Duration(milliseconds: 100), (_) {
      final startTime = raceProvider.startTime;

      // Check if race 3 and no participants left → stop timer
      if (widget.raceNumber == 3) {
        final activeParticipants = raceProvider.participants.values
            .where((p) => p.currentRace == 3)
            .toList();

        if (activeParticipants.isEmpty) {
          _timer.cancel();
          return;
        }
      }

      if (startTime != null) {
        final now = DateTime.now();
        final start = DateTime.fromMillisecondsSinceEpoch(startTime);
        setState(() {
          _elapsed = now.difference(start);
        });
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final raceProvider = Provider.of<RaceProvider>(context);
    final race = raceProvider.races[widget.raceId];
    final segmentName =
        race['segments']?['race${widget.raceNumber}'] ?? 'Race ${widget.raceNumber}';

    final participantIds = raceProvider.participants.entries
        .where((e) => e.value.currentRace == widget.raceNumber)
        .map((e) => e.key)
        .toList();

    return Scaffold(
      appBar: AppBar(title: Text(segmentName)),
      body: Column(
        children: [
          TimerDisplay(duration: _elapsed),
          Expanded(
            child: participantIds.isEmpty
                ? const Center(child: Text('No participants left in this race.'))
                : ListView(
                    children: participantIds.map((id) {
                      final user = raceProvider.users[id];
                      final participant = raceProvider.participants[id];
                      if (user == null || participant == null) return const SizedBox.shrink();

                      return ParticipantCard(
                        user: user,
                        participant: participant,
                        onFinish: () async {
                          await raceProvider.finishParticipant(id, widget.raceNumber);
                          setState(() {}); // force refresh to update list after finish
                        },
                      );
                    }).toList(),
                  ),
          ),
          if (widget.raceNumber < 3)
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => RaceScreen(
                      raceId: widget.raceId,
                      raceNumber: widget.raceNumber + 1,
                    ),
                  ),
                );
              },
              child: const Text('Go to Next Race'),
            )
          else
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => ResultScreen(raceId: widget.raceId),
                  ),
                );
              },
              child: const Text('View Results'),
            ),
        ],
      ),
    );
  }
}
