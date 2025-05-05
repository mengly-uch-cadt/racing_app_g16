import 'package:flutter/material.dart';

class TimerDisplay extends StatelessWidget {
  final Duration duration;

  const TimerDisplay({required this.duration, super.key});

  String _formatDuration(Duration d) {
    final hours = d.inHours.toString().padLeft(2, '0');
    final minutes = (d.inMinutes % 60).toString().padLeft(2, '0');
    final seconds = (d.inSeconds % 60).toString().padLeft(2, '0');
    final millis = (d.inMilliseconds % 1000).toString().padLeft(3, '0');
    return '$hours:$minutes:$seconds.$millis';
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      _formatDuration(duration),
      style: const TextStyle(
        fontSize: 48,
        fontWeight: FontWeight.bold,
        fontFeatures: [FontFeature.tabularFigures()],
      ),
    );
  }
}
