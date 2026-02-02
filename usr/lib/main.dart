import 'package:flutter/material.dart';
import 'screens/role_selection_screen.dart';
import 'screens/admin_dashboard.dart';
import 'screens/create_poll_screen.dart';
import 'screens/user_dashboard.dart';
import 'screens/vote_screen.dart';
import 'screens/results_screen.dart';
import 'models/poll.dart';

void main() {
  runApp(const VotingApp());
}

class VotingApp extends StatelessWidget {
  const VotingApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Voting System',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const RoleSelectionScreen(),
        '/admin': (context) => const AdminDashboard(),
        '/create_poll': (context) => const CreatePollScreen(),
        '/user': (context) => const UserDashboard(),
      },
      onGenerateRoute: (settings) {
        if (settings.name == '/vote') {
          final poll = settings.arguments as Poll;
          return MaterialPageRoute(
            builder: (context) => VoteScreen(poll: poll),
          );
        }
        if (settings.name == '/results') {
          final poll = settings.arguments as Poll;
          return MaterialPageRoute(
            builder: (context) => ResultsScreen(poll: poll),
          );
        }
        return null;
      },
    );
  }
}
