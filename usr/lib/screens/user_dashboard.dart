import 'package:flutter/material.dart';
import '../../services/poll_service.dart';

class UserDashboard extends StatelessWidget {
  const UserDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    final pollService = PollService();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Vote Now'),
      ),
      body: ListenableBuilder(
        listenable: pollService,
        builder: (context, child) {
          final polls = pollService.polls;
          if (polls.isEmpty) {
            return const Center(child: Text('No active polls available.'));
          }
          return ListView.builder(
            itemCount: polls.length,
            padding: const EdgeInsets.all(16),
            itemBuilder: (context, index) {
              final poll = polls[index];
              return Card(
                margin: const EdgeInsets.only(bottom: 16),
                elevation: 2,
                child: ListTile(
                  contentPadding: const EdgeInsets.all(16),
                  title: Text(
                    poll.question,
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  subtitle: Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text('${poll.options.length} options available'),
                  ),
                  trailing: ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(
                        context, 
                        '/vote',
                        arguments: poll,
                      );
                    },
                    child: const Text('Vote'),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
