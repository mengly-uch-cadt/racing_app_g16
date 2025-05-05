import 'package:racing_app/models/participant.dart';

class Race {
  final String id; // raceId
  final String name;
  final DateTime? startTime;
  final Map<String, Participant> participants;

  Race({
    required this.id,
    required this.name,
    required this.startTime,
    required this.participants,
  });

  factory Race.fromMap(String id, Map<String, dynamic> data) {
    final participantsMap = data['participants'] as Map<String, dynamic>;
    final participants = participantsMap.map((userId, participantData) =>
        MapEntry(userId, Participant.fromMap(userId, participantData)));

    return Race(
      id: id,
      name: data['name'],
      startTime: data['startTime'] != null
          ? DateTime.fromMillisecondsSinceEpoch(data['startTime'])
          : null,
      participants: participants,
    );
  }
}
