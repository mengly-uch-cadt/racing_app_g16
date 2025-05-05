class Participant {
  final String id; // userId
  final int currentRace;
  final Map<String, DateTime?> raceTimestamps;

  Participant({
    required this.id,
    required this.currentRace,
    required this.raceTimestamps,
  });

  factory Participant.fromMap(String id, Map<String, dynamic> data) {
    final rawTimestamps = Map<String, dynamic>.from(data['raceTimestamps'] ?? {});
    return Participant(
      id: id,
      currentRace: data['currentRace'] ?? 1,
      raceTimestamps: {
        'race1': rawTimestamps['race1'] != null
            ? DateTime.fromMillisecondsSinceEpoch(rawTimestamps['race1'])
            : null,
        'race2': rawTimestamps['race2'] != null
            ? DateTime.fromMillisecondsSinceEpoch(rawTimestamps['race2'])
            : null,
        'race3': rawTimestamps['race3'] != null
            ? DateTime.fromMillisecondsSinceEpoch(rawTimestamps['race3'])
            : null,
      },
    );
  }
}
