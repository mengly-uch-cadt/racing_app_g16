import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:racing_app/screens/race_screen_wrapper.dart';
import 'providers/race_provider.dart';
import 'screens/race_select_screen.dart';
import 'screens/result_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => RaceProvider()),
        // Add more providers here if needed in the future
      ],
      child: MaterialApp(
        title: 'Race Tracker',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          useMaterial3: true,
          scaffoldBackgroundColor: Colors.white,
        ),
        initialRoute: '/',
        routes: {
          '/': (context) => const RaceSelectorScreen(),
          '/race': (context) => const RaceScreenWrapper(),
          // '/result': (context) => const ResultScreen(raceId: '',),
        },
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
