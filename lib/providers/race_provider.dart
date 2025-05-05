import 'package:flutter/material.dart';
import '../models/user.dart';
import '../models/participant.dart';
import '../repositories/race_repository.dart';

class RaceProvider with ChangeNotifier {
  final RaceRepository _repo = RaceRepository();

  Map<String, User> users = {};
  Map<String, Participant> participants = {};
  Map<String, dynamic> races = {};
  int? startTime;
  String? currentRaceId;

  RaceProvider() {
    _listenToRaces();
    _listenToUsers();
  }

  void init(String raceId) {
    currentRaceId = raceId;
    _listenToParticipants();
    _listenToStartTime();
  }

  void _listenToRaces() {
    _repo.getRacesStream().onValue.listen((event) {
      final data = event.snapshot.value as Map?;
      if (data != null) {
        races = Map<String, dynamic>.from(data);
        notifyListeners();
      }
    });
  }

  void _listenToUsers() {
    _repo.getUsersStream().onValue.listen((event) {
      final data = event.snapshot.value as Map?;
      if (data != null) {
        users = data.map((key, value) =>
            MapEntry(key, User.fromMap(key, Map<String, dynamic>.from(value))));
        notifyListeners();
      }
    });
  }

  void _listenToParticipants() {
    if (currentRaceId == null) return;
    _repo.getParticipantsStream(currentRaceId!).onValue.listen((event) {
      final data = event.snapshot.value as Map?;
      if (data != null) {
        participants = data.map((key, value) => MapEntry(
            key, Participant.fromMap(key, Map<String, dynamic>.from(value))));
        notifyListeners();
      }
    });
  }

  void _listenToStartTime() {
    if (currentRaceId == null) return;
    _repo.getStartTimeStream(currentRaceId!).onValue.listen((event) {
      startTime = event.snapshot.value as int?;
      notifyListeners();
    });
  }

  Future<void> startRace() => _repo.startRace(currentRaceId!);

  Future<void> finishParticipant(String id, int raceNumber) async {
    await _repo.finishParticipant(currentRaceId!, id, raceNumber);
    // Let the listener auto-refresh participants
  }
}
