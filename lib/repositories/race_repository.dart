import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';

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

  DatabaseReference getUsersStream() {
    return db.child('users');
  }

  DatabaseReference getRacesStream() {
    return db.child('races');
  }

  DatabaseReference getParticipantsStream(String raceId) {
    debugPrint("===============================================");
    debugPrint('Fetching participants');
    debugPrint('Loaded participants: ${db.child('races/$raceId/participants')}');
    debugPrint("===============================================");

    return db.child('races/$raceId/participants');
  }

  DatabaseReference getStartTimeStream(String raceId) {
    return db.child('races/$raceId/startTime');
  }
}
