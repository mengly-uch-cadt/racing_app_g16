// // lib/screens/result_screen.dart
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import '../providers/race_provider.dart';

// class ResultScreen extends StatelessWidget {
//   final String raceId;

//   const ResultScreen({required this.raceId, super.key});

//   @override
//   Widget build(BuildContext context) {
//     final raceProvider = Provider.of<RaceProvider>(context);
//     final participantIds = raceProvider.participants.keys.toList();

//     return Scaffold(
//       appBar: AppBar(title: const Text('Results')),
//       body: ListView(
//         children: participantIds.map((id) {
//           final user = raceProvider.users[id];
//           final participant = raceProvider.participants[id];
//           if (user == null || participant == null) return const SizedBox.shrink();

//           final timestamps = participant.raceTimestamps;
//           return ListTile(
//             title: Text('${user.bib} - ${user.name}'),
//             subtitle: Text(
//               'Race 1: ${timestamps['race1']}\n'
//               'Race 2: ${timestamps['race2']}\n'
//               'Race 3: ${timestamps['race3']}',
//             ),
//           );
//         }).toList(),
//       ),
//     );
//   }
// }
