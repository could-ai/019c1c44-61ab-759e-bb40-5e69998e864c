import 'package:flutter/material.dart';
import '../models/poll.dart';
import '../services/poll_service.dart';

class ResultsScreen extends StatelessWidget {
  final Poll poll;
  const ResultsScreen({super.key, required this.poll});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Poll Results')),
      body: ListenableBuilder(
        listenable: PollService(),
        builder: (context, child) {
          // Get the latest version of this poll from service
          final currentPoll = PollService().polls.firstWhere(
            (p) => p.id == poll.id, 
            orElse: () => poll
          );
          
          final totalVotes = currentPoll.totalVotes;

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  currentPoll.question,
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Text(
                  'Total Votes: $totalVotes',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Colors.grey[600]),
                ),
                const SizedBox(height: 32),
                Expanded(
                  child: ListView.builder(
                    itemCount: currentPoll.options.length,
                    itemBuilder: (context, index) {
                      final option = currentPoll.options[index];
                      final percentage = totalVotes == 0 
                          ? 0.0 
                          : (option.voteCount / totalVotes);
                      
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 24.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  option.text,
                                  style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
                                ),
                                Text(
                                  '${(percentage * 100).toStringAsFixed(1)}% (${option.voteCount})',
                                  style: const TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(4),
                              child: LinearProgressIndicator(
                                value: percentage,
                                minHeight: 12,
                                backgroundColor: Colors.grey[200],
                                color: Colors.deepPurple,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
