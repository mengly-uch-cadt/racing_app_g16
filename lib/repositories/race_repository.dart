import 'package:firebase_database/firebase_database.dart';

class RaceRepository {
  final db = FirebaseDatabase.instance.ref();

  Future<void> startRace(String raceId) async {
    await db.child('races/$raceId/startTime').set(ServerValue.timestamp);
  }

  Future<void> finishParticipant(String raceId, String participantId, int raceNumber) async {
    final timestampKey = 'race$raceNumber';
    await db
        .child('races/$raceId/participants/$participantId/raceTimestamps/$timestampKey')
        .set(ServerValue.timestamp);

    if (raceNumber < 3) {
      await db.child('races/$raceId/participants/$participantId/currentRace').set(raceNumber + 1);
    }
  }

  DatabaseReference getUsersStream() => db.child('users');

  DatabaseReference getRacesStream() => db.child('races');

  DatabaseReference getParticipantsStream(String raceId) =>
      db.child('races/$raceId/participants');

  DatabaseReference getStartTimeStream(String raceId) =>
      db.child('races/$raceId/startTime');
}
