import 'participant.dart';

class Race {
  final String id;
  final String name;
  final int? startTime;
  final Map<String, String> segments;
  final Map<String, Participant> participants;

  Race({
    required this.id,
    required this.name,
    required this.startTime,
    required this.segments,
    required this.participants,
  });

  factory Race.fromMap(String id, Map<dynamic, dynamic> map) {
    // Safely cast segments
    final segmentsRaw = map['segments'] as Map<dynamic, dynamic>?;
    final segmentMap = segmentsRaw != null
        ? segmentsRaw.map((key, value) => MapEntry(key.toString(), value.toString()))
        : {
            'race1': 'Running',
            'race2': 'Swimming',
            'race3': 'Cycling',
          };

    // Safely cast participants
    final participantsRaw = map['participants'] as Map<dynamic, dynamic>?;
    final participantMap = <String, Participant>{};
    if (participantsRaw != null) {
      participantsRaw.forEach((key, value) {
        participantMap[key.toString()] =
            Participant.fromMap(key.toString(), Map<String, dynamic>.from(value as Map));
      });
    }

    return Race(
      id: id,
      name: map['name'] ?? '',
      startTime: map['startTime'],
      segments: segmentMap,
      participants: participantMap,
    );
  }
}
