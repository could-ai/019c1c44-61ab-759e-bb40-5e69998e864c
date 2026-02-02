import 'package:flutter/material.dart';
import '../../services/poll_service.dart';
import '../../models/poll.dart';

class AdminDashboard extends StatefulWidget {
  const AdminDashboard({super.key});

  @override
  State<AdminDashboard> createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {
  final PollService _pollService = PollService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Dashboard'),
        backgroundColor: Colors.deepPurple.shade100,
      ),
      body: ListenableBuilder(
        listenable: _pollService,
        builder: (context, child) {
          final polls = _pollService.polls;
          if (polls.isEmpty) {
            return const Center(child: Text('No polls created yet.'));
          }
          return ListView.builder(
            itemCount: polls.length,
            padding: const EdgeInsets.all(16),
            itemBuilder: (context, index) {
              final poll = polls[index];
              return Card(
                margin: const EdgeInsets.only(bottom: 16),
                child: ListTile(
                  title: Text(poll.question, style: const TextStyle(fontWeight: FontWeight.bold)),
                  subtitle: Text('Total Votes: ${poll.totalVotes}'),
                  trailing: const Icon(Icons.bar_chart),
                  onTap: () {
                    Navigator.pushNamed(
                      context, 
                      '/results',
                      arguments: poll,
                    );
                  },
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.pushNamed(context, '/create_poll');
        },
        label: const Text('Create Poll'),
        icon: const Icon(Icons.add),
      ),
    );
  }
}
