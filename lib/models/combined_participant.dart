import 'package:racing_app/models/participant.dart';
import 'package:racing_app/models/user.dart';

class CombinedParticipant {
  final User user;
  final Participant participant;

  CombinedParticipant({
    required this.user,
    required this.participant,
  });
}
